#include "llvm/Constants.h"
#include "llvm/DerivedTypes.h"
#include "llvm/Instructions.h"
#include "llvm/Instruction.h"
#include "llvm/Module.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"
#include <fstream>

using namespace llvm;

namespace {
  struct IncPerfBench : public ModulePass
  {
    static char ID;
    IncPerfBench() : ModulePass((intptr_t)&ID) {}
    virtual bool runOnModule(Module &M)
    {
      Function *Main = M.getFunction("main");
      if (Main == 0) 
	{
	  errs() << "!!! No Main Function - No Print Sequence File !!!\n";
	  return false;
	}

      LLVMContext &MyContext = M.getContext();
      Constant *FileStart = M.getOrInsertFunction("MBStartPAPI",
						  Type::getInt32Ty(MyContext),
						  NULL);
      Constant *FileStop  = M.getOrInsertFunction("MBStopPAPI",
                                                  Type::getInt32Ty(MyContext),
						  NULL);

      BasicBlock::iterator InsertPos = Main->getEntryBlock().begin();
      CallInst::Create(FileStart, "", InsertPos);

      for (Module::iterator Iter = M.begin(); Iter != M.end(); Iter++)
        {
          if ( (Iter != FileStart) && (Iter != FileStop) )
            {
              for (Function::iterator BB=Iter->begin();
                   BB != Iter->end(); BB++)
                {
		  BasicBlock::iterator InsertPos = BB->end();
                  InsertPos--;
                  if ( (UnreachableInst::classof(InsertPos) == true) &&
		       (InsertPos != BB->begin()) )
                    {
                      InsertPos--;
		      CallInst::Create(FileStop, "", InsertPos);
                    }
                }
            }
        }

      for (Function::iterator BB=Main->begin(); BB != Main->end(); BB++)
        {
	  BasicBlock::iterator InsertPos = BB->end();
	  InsertPos--;
          if ( ((ReturnInst::classof(InsertPos)) == true) ||
               ((UnwindInst::classof(InsertPos)) == true) )
            {
	      CallInst::Create(FileStop, "", InsertPos);
            }
        }

      return true;
    }
  };
  char IncPerfBench::ID = 0;
  RegisterPass<IncPerfBench> X("incperfbench", 
	       "Include Performance Counter Cycles (Benchmark)");
}
