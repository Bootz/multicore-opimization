//=====-- X86MCAsmInfo.h - X86 asm properties -----------------*- C++ -*--====//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file contains the declaration of the X86MCAsmInfo class.
//
//===----------------------------------------------------------------------===//

#ifndef X86TARGETASMINFO_H
#define X86TARGETASMINFO_H

#include "llvm/MC/MCAsmInfo.h"
#include "llvm/MC/MCAsmInfoCOFF.h"
#include "llvm/MC/MCAsmInfoDarwin.h"

namespace llvm {
  class Triple;

  struct X86MCAsmInfoDarwin : public MCAsmInfoDarwin {
    explicit X86MCAsmInfoDarwin(const Triple &Triple);
  };

  struct X86_64MCAsmInfoDarwin : public X86MCAsmInfoDarwin {
    explicit X86_64MCAsmInfoDarwin(const Triple &Triple);
    virtual const MCExpr *
    getExprForPersonalitySymbol(const MCSymbol *Sym,
                                unsigned Encoding,
                                MCStreamer &Streamer) const;
  };

  struct X86ELFMCAsmInfo : public MCAsmInfo {
    explicit X86ELFMCAsmInfo(const Triple &Triple);
    virtual const MCSection *getNonexecutableStackSection(MCContext &Ctx) const;
  };

  struct X86MCAsmInfoMicrosoft : public MCAsmInfoMicrosoft {
    explicit X86MCAsmInfoMicrosoft(const Triple &Triple);
  };

  struct X86MCAsmInfoGNUCOFF : public MCAsmInfoGNUCOFF {
    explicit X86MCAsmInfoGNUCOFF(const Triple &Triple);
  };
} // namespace llvm

#endif
