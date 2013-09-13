/*
 * LoopCountInsertion.cpp
 *
 *  Created on: Oct 30, 2011
 *      Author: kula85
 */

#define DEBUG_TYPE "delaythread"
#include "llvm/ADT/ArrayRef.h"
#include "llvm/ADT/SmallVector.h"
#include "llvm/ADT/StringRef.h"
#include "llvm/Analysis/DebugInfo.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/BasicBlock.h"
#include "llvm/Constants.h"
#include "llvm/DerivedTypes.h"
#include "llvm/Function.h"
#include "llvm/GlobalValue.h"
#include "llvm/GlobalVariable.h"
#include "llvm/Instructions.h"
#include "llvm/Metadata.h"
#include "llvm/Module.h"
#include "llvm/Pass.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/InstIterator.h"
#include "llvm/Support/IRBuilder.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/TypeBuilder.h"
#include "llvm/Transforms/Scalar.h"
#include <cstdio>
#include <string>
#include <vector>

using namespace llvm;

static cl::opt<bool>
EnableLoopCountInsertion("enable-lci", cl::init(false),
    cl::desc("Enable LoopCountInsertion Pass"));

namespace {
struct LoopCountInsertion : public ModulePass {
  static char ID;
  LoopCountInsertion() : ModulePass(ID) {
    initializeLoopCountInsertionPass(*PassRegistry::getPassRegistry());
  }

  virtual bool runOnModule(Module &M);

  void getAnalysisUsage(AnalysisUsage &AU) const {
    AU.setPreservesCFG();
    AU.addRequired<LoopInfo>();
  }

private:
  void addFunctionDecls(Module &M);
  void gettidinfo(Module &M);
};

}

void LoopCountInsertion::addFunctionDecls(Module &M) {
  LLVMContext* Context = &M.getContext();

  // Add struct type DTO_position.
  StructType *postype = M.getTypeByName("struct.DTO_position");
  // Add struct type to store position info if not exist.
  if(!postype) {
    std::vector<Type*> infotypes;
    infotypes.push_back(ArrayType::get(IntegerType::getInt8Ty
        (*Context),256)); //dirname
    infotypes.push_back(ArrayType::get(IntegerType::getInt8Ty
        (*Context),256)); //filename
    infotypes.push_back(IntegerType::getInt32Ty(*Context)); // loop line number
    infotypes.push_back(IntegerType::getInt32Ty(*Context)); // iteration

    postype = StructType::create(M.getContext(),
        makeArrayRef(infotypes), StringRef("struct.DTO_position"));
  }

  AttributeWithIndex AWI1 = AttributeWithIndex::get(~0u, Attribute::NoUnwind);
  AttributeWithIndex AWI2 = AttributeWithIndex::get(~0u,
                                   Attribute::ReadNone | Attribute::NoUnwind);

  // Add declaration for strcpy.
  M.getOrInsertFunction(
      "strcpy",
      AttrListPtr::get(&AWI1, 1),
      Type::getInt8PtrTy(*Context), // return type
      Type::getInt8PtrTy(*Context),
      Type::getInt8PtrTy(*Context),
      NULL );

  // Add declaration for pthread_self.
  M.getOrInsertFunction(
      "pthread_self",
      AttrListPtr::get(&AWI2, 1),
      Type::getInt64Ty(*Context), // return type
      NULL );

  // Add declaration for DTO_setpid.
  M.getOrInsertFunction(
      "DTO_setpid",
      AttrListPtr::get(&AWI1, 1),
      Type::getVoidTy(*Context), // return type
      Type::getInt64PtrTy(*Context),
      NULL );

  // Add declaration for DTO_getpid.
  M.getOrInsertFunction(
      "DTO_getpid",
      AttrListPtr::get(&AWI1, 1),
      Type::getInt32Ty(*Context), // return type
      Type::getInt64PtrTy(*Context),
      NULL );
}

void LoopCountInsertion::gettidinfo(Module &M) {
  SmallVector<inst_iterator, 5> InsertPoints;
  SmallVector<CallInst*, 5> TidValues;

  // Collect InsertPoints & TidValues.
  for(Module::iterator MI=M.begin(), ME=M.end(); MI != ME; MI++)
    for(inst_iterator i = inst_begin(*MI), e = inst_end(*MI); i != e; ++i) {
      CallInst* callInst = dyn_cast<CallInst>(&*i);
      if(!callInst) continue;

      Function* Fany = callInst->getCalledFunction();
      // If this is an indirect call(use function pointer), return.
      if(!Fany) continue;
      // see if it's an papi thread. if so, skip to next pthread_create
      if(Fany->hasName() &&
          !((Fany->getName()).startswith(StringRef("pthread_create")))) continue;

      // Do not trace papi thread.
      Function* papifun = dyn_cast<Function>(callInst->getArgOperand(2));
      if (papifun->hasName() &&
          ((papifun->getName()).startswith(StringRef("DTO_"))))
        continue;

      InsertPoints.push_back(i);
      TidValues.push_back(callInst);
    }

  // Instrument DTO_setpid calls with InsertPoints & TidValues.
  IRBuilder<> Builder(M.getContext());
  for(int i = 0, size = InsertPoints.size(); i < size; i++) {
    // t is the insert position after callInst
    inst_iterator t(InsertPoints[i]);
    t++;
    Instruction* tinst = dyn_cast<Instruction>(&*t);
    Builder.SetInsertPoint(tinst);
    Builder.CreateCall(M.getFunction("DTO_setpid"),
        TidValues[i]->getArgOperand(0));
  }

}


bool LoopCountInsertion::runOnModule(Module &M) {
  unsigned LoopCounterIndex = 0;
  Constant *posvalue;

  // Clang flag to switch LoopCountInsertion On/Off
  if(!EnableLoopCountInsertion) return false;

  // If source file contains no function, then return.
  if(M.getFunctionList().size() == 0) return false;

  // Run this pass only once
  if(M.getNamedGlobal(StringRef("DTO_pos"))) return false;

  // Add various function declarations.
  addFunctionDecls(M);

  // Get thread ID info. Make DTO aware of new threads created.
  gettidinfo(M);

  // Begin to modify IR.
  IRBuilder<> Builder(&*M.begin()->begin());

  // Add current file name to global.
  NamedMDNode *CU_Nodes = M.getNamedMetadata("llvm.dbg.cu");
  assert( CU_Nodes && "No NamedMDNode for Module. Forgot to use '-g' flag?");
  assert( CU_Nodes->getNumOperands() == 1 &&
      "Moule has more than 1 CompileUnit metadata?");
  DICompileUnit CU(CU_Nodes->getOperand(0));
  StringRef Dir = CU.getDirectory();
  StringRef File = CU.getFilename();
  Value *dirnamestr = Builder.CreateGlobalString(Dir, Twine("DTO_dirname"));
  Value *filenamestr = Builder.CreateGlobalString(File, Twine("DTO_filename"));

  StructType *postype = M.getTypeByName("struct.DTO_position");
  posvalue = M.getOrInsertGlobal(StringRef("DTO_pos"),
      ArrayType::get(postype, 8));

  // Set alignment to 16 if possible.
  if (GlobalVariable *GV = dyn_cast<GlobalVariable>(posvalue)) {
    GV->setAlignment(16);
  }

  // Get all loops in this module.
  SmallPtrSet<Loop*, 5> AllLoops;
  for(Module::iterator MI=M.begin(), ME=M.end(); MI != ME; MI++) {
    // Ignore if this function is just a declaration.
    if(MI->isDeclaration()) continue;

    // Ignore if this function has no name.
    if(MI->getName().size() == 0) continue;

    // Add call to pthread_self to get threadID
    Function *pself_func = M.getFunction("pthread_self");
    Function *getpid_func = M.getFunction("DTO_getpid");
    Builder.SetInsertPoint((MI->getEntryBlock()).getTerminator());
    AllocaInst *pidlocal = Builder.CreateAlloca(Type::getInt64Ty(M.getContext()));
    CallInst *pselfcall = Builder.CreateCall(pself_func);
    Builder.CreateStore(pselfcall, pidlocal);
    CallInst *getpidcall = Builder.CreateCall(getpid_func, pidlocal);

    Value *Idxs1[] = {
        ConstantInt::get(Type::getInt64Ty(M.getContext()), 0),
        //ConstantInt::get(Type::getInt64Ty(M.getContext()), 0),
        getpidcall,
        ConstantInt::get(Type::getInt32Ty(M.getContext()), 0),
        ConstantInt::get(Type::getInt64Ty(M.getContext()), 0)
    };

    Value *Idxs2[] = {
        ConstantInt::get(Type::getInt64Ty(M.getContext()), 0),
        //ConstantInt::get(Type::getInt64Ty(M.getContext()), 0),
        getpidcall,
        ConstantInt::get(Type::getInt32Ty(M.getContext()), 1),
        ConstantInt::get(Type::getInt64Ty(M.getContext()), 0)
    };

    Value *Idxs3[] = {
        ConstantInt::get(Type::getInt64Ty(M.getContext()), 0),
        ConstantInt::get(Type::getInt64Ty(M.getContext()), 0)
    };

    Value *Idxs4[] = {
        ConstantInt::get(Type::getInt64Ty(M.getContext()), 0),
        //ConstantInt::get(Type::getInt64Ty(M.getContext()), 0),
        getpidcall,
        ConstantInt::get(Type::getInt32Ty(M.getContext()), 2)
    };

    Value *Idxs5[] = {
        ConstantInt::get(Type::getInt64Ty(M.getContext()), 0),
        //ConstantInt::get(Type::getInt64Ty(M.getContext()), 0),
        getpidcall,
        ConstantInt::get(Type::getInt32Ty(M.getContext()), 3)
    };

     //Add two strcpy calls for dirname&filename. Each for one function.
    Function *strcpy_func = M.getFunction("strcpy");
    Builder.CreateCall2(strcpy_func,
        Builder.CreateInBoundsGEP(posvalue, makeArrayRef(Idxs1)),
        Builder.CreateInBoundsGEP(dirnamestr, makeArrayRef(Idxs3)));

    Builder.CreateCall2(strcpy_func,
        Builder.CreateInBoundsGEP(posvalue, makeArrayRef(Idxs2)),
        Builder.CreateInBoundsGEP(filenamestr, makeArrayRef(Idxs3)));

    LoopInfo &LI = getAnalysis<LoopInfo>(*MI);
    for(Function::iterator FI=MI->begin(), FE=MI->end(); FI != FE; FI++) {
      // if L is null or L is already processed, goto next BB
      Loop *L = LI.getLoopFor(&*FI);
      if(L == 0) continue;
      if(!AllLoops.insert(L)) continue;

      GlobalVariable *loopcounter = new GlobalVariable(M,
          IntegerType::getInt32Ty(Builder.getContext()),
          false, GlobalValue::InternalLinkage, Builder.getInt32(0),
          Twine("DTO_loopcounter")+Twine(LoopCounterIndex));
      loopcounter->setAlignment(4);

      // Add loop counter in loop body.
      // FIXME: This is not necessarily the loop body. see s_rnge.c in clapack.
//      BasicBlock *loopbody = L->getHeader()->getTerminator()->getSuccessor(0);
//      Builder.SetInsertPoint(loopbody->getFirstInsertionPt());
//      LoadInst *loadindex = Builder.CreateLoad(loopcounter);
//      Value *addinst = Builder.CreateNSWAdd(loadindex, Builder.getInt32(1));
//      StoreInst *storeinst = Builder.CreateStore(addinst, loopcounter);



      unsigned Line = 0;
      MDNode *N = 0;

      if(L->getHeader()->size() == 1) {
        N = L->getHeader()->getTerminator()->getMetadata("dbg");
        Line = 0;
      } else {
        N = L->getHeader()->getTerminator()->getPrevNode()->getMetadata("dbg");
        DILocation Loc(N);
        Line = Loc.getLineNumber();
      }


      // FIXME: Should move this right before each loop. Do once for each loop.
      // Store line number for the current loop.
//      storeinst = Builder.CreateStore(ConstantInt::get(
//          Type::getInt32Ty(M.getContext()), Line),
//          Builder.CreateInBoundsGEP(posvalue, makeArrayRef(Idxs4)));
//      storeinst->setVolatile(1);
//
//      // Deliberately not to clear this counter right before this loop.
//      // Each loop may be entered multiple times. If clear this counter
//      // to 0, we don't know where are we at.
//      loadindex = Builder.CreateLoad(loopcounter);
//      Builder.CreateStore(loadindex,
//          Builder.CreateInBoundsGEP(posvalue, makeArrayRef(Idxs5)));
//      loadindex->setVolatile(1);
    }
  }

  return true;
}

char LoopCountInsertion::ID = 0;
INITIALIZE_PASS_BEGIN(LoopCountInsertion, "loop-count-insertion",
    "Pass to add loop profiling counter to know "
    "which iteration we are in. "
    "This pass also generate a file "
    "which contains info about which counter is for "
    "which loop(line no is for cmp inst).", false, false)
INITIALIZE_PASS_DEPENDENCY(LoopInfo)
INITIALIZE_PASS_END(LoopCountInsertion, "loop-count-insertion",
    "Pass to add loop profiling counter to know "
    "which iteration we are in. "
    "This pass also generate a file "
    "which contains info about which counter is for "
    "which loop(line no is for cmp inst).", false, false)

    Pass *llvm::createLoopCountInsertionPass() {
  return new LoopCountInsertion();
}
