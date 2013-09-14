#include "llvm/Constants.h"
#include "llvm/Instructions.h"
#include "llvm/Instruction.h"
#include "llvm/Module.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/CFG.h"
#include <iostream>
#include <fstream>

using namespace llvm;

namespace {
  struct ThreadTestNx : public ModulePass
  {
    static char ID;
    ThreadTestNx() : ModulePass((intptr_t)&ID) {}
    virtual bool runOnModule(Module &M);
    StructType *FileStruct;
    StructType *IOmarkerStruct;
    StructType *ListStruct;
    StructType *MutexSStruct;
    StructType *TimeValStruct;
    StructType *TimeZoneStruct;
    StructType *MutexTStruct;
    StructType *MutexAttrTStruct;
    void GlobalTypesAndVars (Module &M);
  };
  char ThreadTestNx::ID = 0;
  RegisterPass<ThreadTestNx> X("threadtestnx", 
			       "Test Threaded Parts of Programs");
}

void ThreadTestNx::GlobalTypesAndVars (Module &M)
{
  LLVMContext &MyContext = M.getContext();
  std::vector<const Type*> Elements;
  PATypeHolder NewFile = OpaqueType::get(MyContext);
  PATypeHolder NewIOMarker = OpaqueType::get(MyContext);
  PATypeHolder NewList = OpaqueType::get(MyContext);

  // Create FILE struct
  Elements.push_back(Type::getInt32Ty(MyContext));
  Elements.push_back(Type::getInt8PtrTy(MyContext));
  Elements.push_back(Type::getInt8PtrTy(MyContext));
  Elements.push_back(Type::getInt8PtrTy(MyContext));
  Elements.push_back(Type::getInt8PtrTy(MyContext));
  Elements.push_back(Type::getInt8PtrTy(MyContext));
  Elements.push_back(Type::getInt8PtrTy(MyContext));
  Elements.push_back(Type::getInt8PtrTy(MyContext));
  Elements.push_back(Type::getInt8PtrTy(MyContext));
  Elements.push_back(Type::getInt8PtrTy(MyContext));
  Elements.push_back(Type::getInt8PtrTy(MyContext));
  Elements.push_back(Type::getInt8PtrTy(MyContext));
  Elements.push_back(PointerType::getUnqual(NewIOMarker));
  Elements.push_back(PointerType::getUnqual(NewFile));
  Elements.push_back(Type::getInt32Ty(MyContext));
  Elements.push_back(Type::getInt32Ty(MyContext));
  Elements.push_back(Type::getInt64Ty(MyContext));
  Elements.push_back(Type::getInt16Ty(MyContext));
  Elements.push_back(Type::getInt8Ty(MyContext));
  Elements.push_back(ArrayType::get(Type::getInt8Ty(MyContext),1));
  Elements.push_back(Type::getInt8PtrTy(MyContext));
  Elements.push_back(Type::getInt64Ty(MyContext));
  Elements.push_back(Type::getInt8PtrTy(MyContext));
  Elements.push_back(Type::getInt8PtrTy(MyContext));
  Elements.push_back(Type::getInt8PtrTy(MyContext));
  Elements.push_back(Type::getInt8PtrTy(MyContext));
  Elements.push_back(Type::getInt64Ty(MyContext));
  Elements.push_back(Type::getInt32Ty(MyContext));
  Elements.push_back(ArrayType::get(Type::getInt8Ty(MyContext),20));
  FileStruct = StructType::get(MyContext,Elements);
  Elements.clear();
  cast<OpaqueType>(NewFile.get())->refineAbstractTypeTo(FileStruct);
  FileStruct = cast<StructType>(NewFile.get());

  // Create _IO_marker struct
  Elements.push_back(PointerType::getUnqual(NewIOMarker));
  Elements.push_back(PointerType::getUnqual(FileStruct));
  Elements.push_back(Type::getInt32Ty(MyContext));
  IOmarkerStruct = StructType::get(MyContext,Elements);
  Elements.clear();
  cast<OpaqueType>(NewIOMarker.get())->refineAbstractTypeTo(IOmarkerStruct);
  IOmarkerStruct = cast<StructType>(NewIOMarker.get());

  // Create __pthread_list_t struct
  Elements.push_back(PointerType::getUnqual(NewList));
  Elements.push_back(PointerType::getUnqual(NewList));
  ListStruct = StructType::get(MyContext,Elements);
  Elements.clear();
  cast<OpaqueType>(NewList.get())->refineAbstractTypeTo(ListStruct);
  ListStruct = cast<StructType>(NewList.get());

  // Create __pthread_mutex_s struct
  Elements.push_back(Type::getInt32Ty(MyContext));
  Elements.push_back(Type::getInt32Ty(MyContext));
  Elements.push_back(Type::getInt32Ty(MyContext));
  Elements.push_back(Type::getInt32Ty(MyContext));
  Elements.push_back(Type::getInt32Ty(MyContext));
  Elements.push_back(Type::getInt32Ty(MyContext));
  Elements.push_back(ListStruct);
  MutexSStruct = StructType::get(MyContext,Elements);
  Elements.clear();

  // Create timeval struct
  Elements.push_back(Type::getInt64Ty(MyContext));
  Elements.push_back(Type::getInt64Ty(MyContext));
  TimeValStruct = StructType::get(MyContext,Elements);
  Elements.clear();

  // Create timezone struct
  Elements.push_back(Type::getInt32Ty(MyContext));
  Elements.push_back(Type::getInt32Ty(MyContext));
  TimeZoneStruct = StructType::get(MyContext,Elements);
  Elements.clear();
  M.addTypeName("TimeZone", TimeZoneStruct);

  // Create pthread_mutex_t struct
  Elements.push_back(MutexSStruct);
  MutexTStruct = StructType::get(MyContext,Elements);
  Elements.clear();

  // Create pthread_mutexattr_t struct
  Elements.push_back(Type::getInt32Ty(MyContext));
  MutexAttrTStruct = StructType::get(MyContext,Elements);
  Elements.clear();
}

bool ThreadTestNx::runOnModule(Module &M)
{
  Function *Main = M.getFunction("main");
  if (Main == 0) {
    errs() << "!!! No Main Function - No Print Sequence File !!!\n";
    return false;
  }
  LLVMContext &MyContext = M.getContext();
  GlobalTypesAndVars(M);
  PointerType *TVSP = PointerType::getUnqual(TimeValStruct);
  PointerType *TZSP = PointerType::getUnqual(TimeZoneStruct);

  Constant *InitLLVM   = M.getOrInsertFunction("MBInitLLVM",
					       Type::getInt32Ty(MyContext),
					       NULL);
  Constant *StrtThread = M.getOrInsertFunction("MBStartThread",
					       Type::getInt32Ty(MyContext),
					       NULL);
  Constant *StopThread = M.getOrInsertFunction("MBStopThread",
					       Type::getInt32Ty(MyContext),
					       Type::getInt32Ty(MyContext),
					       TVSP, NULL);
  Constant *GetTimeDay = M.getOrInsertFunction("gettimeofday",
					       Type::getInt32Ty(MyContext),
					       TVSP, TZSP, NULL);
  Constant *TimeVarArr =
    M.getOrInsertGlobal("MBTime",ArrayType::get(TimeValStruct,8));

  BasicBlock::iterator InsertPos;
  CallInst   *FuncCall, *ThrdIndex;
  Function   *ThreadFunc;
  Function   *ThreadCreate;
  AllocaInst *CurrentTime;
  Instruction *Helper;
  char FuncName[64];
  int Loc;
  std::vector<Value*> Params, TimeParams;
  std::vector<Function*> TFvector;
  std::ifstream ThrdFile("thrdfunc.inf", std::ifstream::in);
  std::ofstream FuncBBInfo("funcbbl.inf");
  ThrdFile >> FuncName;
  ThrdFile >> Loc;
  ThrdFile.close();
  ThreadCreate = M.getFunction(FuncName);

  for (Value::use_iterator FuncUser = ThreadCreate->use_begin();
       FuncUser != ThreadCreate->use_end(); FuncUser++) {
    FuncCall   = cast<CallInst>(FuncUser);
    ThreadFunc =
      cast<Function>(FuncCall->getOperand(Loc)->stripPointerCasts());
    if ((std::find(TFvector.begin(), TFvector.end(), ThreadFunc)) ==
	TFvector.end()) {
      TFvector.push_back(ThreadFunc);
      InsertPos = ThreadFunc->getEntryBlock().begin();
      while (isa<AllocaInst>(InsertPos) || isa<PHINode>(InsertPos))
	++InsertPos;
      CurrentTime = new AllocaInst(TimeValStruct,"CurrentTime",InsertPos);
      ThrdIndex = CallInst::Create(StrtThread, "ThreadIndex", InsertPos);

      TimeParams.push_back(ConstantInt::get(Type::getInt32Ty(MyContext),0));
      TimeParams.push_back(ThrdIndex);
      Helper = GetElementPtrInst::CreateInBounds(TimeVarArr,
						 TimeParams.begin(),
						 TimeParams.end(),
                                                 "", InsertPos);
      TimeParams.clear();
      TimeParams.push_back(Helper);
      TimeParams.push_back(ConstantPointerNull::get(TZSP));
      CallInst::Create(GetTimeDay, TimeParams.begin(),
		       TimeParams.end(), "", InsertPos);
      TimeParams.clear();

      Params.push_back(ThrdIndex);
      FuncBBInfo << "- Function: " << ThreadFunc->getNameStr() << "\n";
      for (Function::iterator BB = ThreadFunc->begin();
	   BB != ThreadFunc->end(); BB++) {
	InsertPos = BB->end();
	InsertPos--;
	Params.push_back(CurrentTime);
	if ( ((ReturnInst::classof(InsertPos)) == true) ||
	     ((UnwindInst::classof(InsertPos)) == true) ) {
	  TimeParams.push_back(CurrentTime);
	  TimeParams.push_back(ConstantPointerNull::get(TZSP));
	  CallInst::Create(GetTimeDay, TimeParams.begin(),
			   TimeParams.end(), "", InsertPos);
	  TimeParams.clear();
	  CallInst::Create(StopThread, Params.begin(),
			   Params.end(), "", InsertPos);
	}
	else if (UnreachableInst::classof(InsertPos) == true) {
	  InsertPos--;
	  TimeParams.push_back(CurrentTime);
	  TimeParams.push_back(ConstantPointerNull::get(TZSP));
	  CallInst::Create(GetTimeDay, TimeParams.begin(),
			   TimeParams.end(), "", InsertPos);
	  TimeParams.clear();
	  CallInst::Create(StopThread, Params.begin(),
			   Params.end(), "", InsertPos);
	}
	Params.pop_back();
      }
      Params.clear();
    }
  }
  FuncBBInfo.close();
  TFvector.clear();

  InsertPos = Main->getEntryBlock().begin();
  while (isa<AllocaInst>(InsertPos) || isa<PHINode>(InsertPos))
    ++InsertPos;
  CallInst::Create(InitLLVM, "", InsertPos);
  return true;
}
