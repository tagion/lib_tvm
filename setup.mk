REPOROOT?=${shell git rev-parse --show-toplevel}

-include $(REPOROOT)/localsetup.mk

ifndef NOUNITTEST
DCFLAGS+=-unittest
DCFLAGS+=-g
DCFLAGS+=$(DEBUG)
endif

DCFLAGS+=$(DIP1000) # Should support scope c= new C; // is(C == class)
DCFLAGS+=$(DIP25)

SCRIPTROOT:=${REPOROOT}/scripts/


include dstep_setup.mk
IWASM_ROOT:=$(REPOROOT)/../wasm-micro-runtime/
LIBS+=$(IWASM_ROOT)/wamr-compiler/build/libvmlib.a

# DDOC Configuration
#
-include ddoc.mk

BIN:=bin

LIBNAME:=libiwavm.a
LIBRARY:=$(BIN)/$(LIBNAME)

WAYS+=${BIN}

SOURCE:=tagion/vm/iwasm
PACKAGE:=${subst /,.,$(SOURCE)}
REVISION:=$(REPOROOT)/$(SOURCE)/revision.di

-include dstep.mk

TAGION_CORE:=$(REPOROOT)/../tagion_core/

-include core_dfiles.mk
TAGION_DFILES:=${addprefix $(TAGION_CORE), $(TAGION_DFILES)}
INC+=$(TAGION_CORE)
INC+=$(REPOROOT)

include unittest_setup.mk
