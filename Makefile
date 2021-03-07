FREEBASIC_COMPILER="$(ProgramFiles)\FreeBASIC\fbc.exe"
INCLUDEFILESPATH=-i Classes -i Forms -i Headers -i Interfaces -i Modules
EXETYPEKIND=console

# Все флаги:
# WINDOWS_SERVICE_FLAG=-d WINDOWS_SERVICE
# WITHOUT_RUNTIME_FLAG=-d WITHOUT_RUNTIME
# UNICODE_FLAG=-d UNICODE
# WITHOUT_CRITICAL_SECTIONS_FLAG=-d WITHOUT_CRITICAL_SECTIONS
# PERFORMANCE_TESTING

PERFORMANCE_TESTING_FLAG=
PERFORMANCE_TESTING_SUFFIX=WoPT

WITHOUT_RUNTIME_FLAG=-d WITHOUT_RUNTIME
WITHOUT_RUNTIME_SUFFIX=WoRt

WITHOUT_CRITICAL_SECTIONS_FLAG=-d WITHOUT_CRITICAL_SECTIONS
WITHOUT_CRITICAL_SECTIONS_SUFFIX=WoCr

UNICODE_FLAG=-d UNICODE
UNICODE_SUFFIX=W

FILE_SUFFIX=$(PERFORMANCE_TESTING_SUFFIX)$(WITHOUT_RUNTIME_SUFFIX)$(WITHOUT_CRITICAL_SECTIONS_SUFFIX)$(UNICODE_SUFFIX)

CODE_GENERATION_BACKEND=gcc
# CODE_GENERATION_BACKEND=gas
# CODE_GENERATION_BACKEND=gas64
# CODE_GENERATION_BACKEND=llvm

# C_COMPILER=gcc
# C_COMPILER=clang
# C_COMPILER=msvc
# GCC_ASSEMBLER=as
# GCC_ASSEMBLER=fasm
# GCC_ASSEMBLER=masm
# GCC_LINKER=ld

# REM set UseThreadSafeRuntime=-mt
# REM set EnableShowIncludes=-showincludes
# REM set EnableVerbose=-v
# REM set EnableRuntimeErrorChecking=-e
# REM set EnableFunctionProfiling=-profile

# set AllCompiledFiles=%~1
# set ExeTypeKind=%~2
# set OutputFileName=%~3
# set Directory=%~4
# set CompilerParameters=%~5
# set DebugFlag=%~6
# set ProfileFlag=%~7
# set WithoutRuntimeLibraryesFlag=%~8

BIN_DEBUG_DIR_64=bin\Debug\x64
BIN_RELEASE_DIR_64=bin\Release\x64
OBJ_DEBUG_DIR_64=obj\Debug\x64
OBJ_RELEASE_DIR_64=obj\Release\x64

BIN_DEBUG_DIR_86=bin\Debug\x86
BIN_RELEASE_DIR_86=bin\Release\x86
OBJ_DEBUG_DIR_86=obj\Debug\x86
OBJ_RELEASE_DIR_86=obj\Release\x86

UuidObjectLibraries=-luuid
GMonitorObjectLibraries=-lgmon
GccObjectLibraries=-lmoldname -lgcc -lmingw32 -lmingwex -lgcc_eh
WinApiObjectLibraries=-ladvapi32 -lcomctl32 -lcomdlg32 -lcrypt32 -lgdi32 -lgdiplus -limm32 -lkernel32 -lmsimg32 -lmsvcrt -lmswsock -lole32 -loleaut32 -lshell32 -lshlwapi -luser32 -lversion -lwinmm -lwinspool -lws2_32
ALL_OBJECT_LIBRARIES=$(WinApiObjectLibraries) $(UuidObjectLibraries)

ifeq ($(PROCESSOR_ARCHITECTURE),AMD64)
# GCC_COMPILER="$(ProgramFiles)\mingw-w64\x86_64-8.1.0-posix-seh-rt_v6-rev0\mingw64\bin\gcc.exe"
# GCC_ASSEMBLER="$(ProgramFiles)\mingw-w64\x86_64-8.1.0-posix-seh-rt_v6-rev0\mingw64\bin\as.exe"
# GCC_LINKER="$(ProgramFiles)\mingw-w64\x86_64-8.1.0-posix-seh-rt_v6-rev0\mingw64\bin\ld.exe"
# ARCHIVE_COMPILER="$(ProgramFiles)\mingw-w64\x86_64-8.1.0-posix-seh-rt_v6-rev0\mingw64\bin\ar.exe"
# DLL_TOOL="$(ProgramFiles)\mingw-w64\x86_64-8.1.0-posix-seh-rt_v6-rev0\mingw64\bin\dlltool.exe"
# COMPILER_LIB_PATH="$(ProgramFiles)\mingw-w64\x86_64-8.1.0-posix-seh-rt_v6-rev0\mingw64\x86_64-w64-mingw32\lib"
GCC_COMPILER="$(ProgramFiles)\FreeBASIC\bin\win64\gcc.exe"
GCC_ASSEMBLER="$(ProgramFiles)\FreeBASIC\bin\win64\as.exe"
GCC_LINKER="$(ProgramFiles)\FreeBASIC\bin\win64\ld.exe"
ARCHIVE_COMPILER="$(ProgramFiles)\FreeBASIC\bin\win64\ar.exe"
DLL_TOOL="$(ProgramFiles)\FreeBASIC\bin\win64\dlltool.exe"
RESOURCE_COMPILER="$(ProgramFiles)\FreeBASIC\bin\win64\GoRC.exe"
COMPILER_LIB_PATH="$(ProgramFiles)\FreeBASIC\lib\win64"
FB_EXTRA="$(ProgramFiles)\FreeBASIC\lib\win64\fbextra.x"
GCC_ARCHITECTURE=-m64 -march=x86-64
TARGET_ASSEMBLER_ARCH=--64
ENTRY_POINT=EntryPoint
PE_FILE_FORMAT=i386pep
ResourceCompilerBitFlag=/machine X64
BIN_DEBUG_DIR=$(BIN_DEBUG_DIR_64)
BIN_RELEASE_DIR=$(BIN_RELEASE_DIR_64)
OBJ_DEBUG_DIR=$(OBJ_DEBUG_DIR_64)
OBJ_RELEASE_DIR=$(OBJ_RELEASE_DIR_64)
else
GCC_COMPILER="$(ProgramFiles)\FreeBASIC\bin\win32\gcc.exe"
GCC_ASSEMBLER="$(ProgramFiles)\FreeBASIC\bin\win32\as.exe"
RESOURCE_COMPILER="$(ProgramFiles)\FreeBASIC\bin\win32\GoRC.exe"
GCC_LINKER="$(ProgramFiles)\FreeBASIC\bin\win32\ld.exe"
ARCHIVE_COMPILER="$(ProgramFiles)\FreeBASIC\bin\win32\ar.exe"
DLL_TOOL="$(ProgramFiles)\FreeBASIC\bin\win32\dlltool.exe"
COMPILER_LIB_PATH="$(ProgramFiles)\FreeBASIC\lib\win32"
FB_EXTRA="$(ProgramFiles)\FreeBASIC\lib\win32\fbextra.x"
GCC_ARCHITECTURE=
TARGET_ASSEMBLER_ARCH=--32
ENTRY_POINT=_EntryPoint@0
PE_FILE_FORMAT=i386pe
ResourceCompilerBitFlag=/nw
BIN_DEBUG_DIR=$(BIN_DEBUG_DIR_86)
BIN_RELEASE_DIR=$(BIN_RELEASE_DIR_86)
OBJ_DEBUG_DIR=$(OBJ_DEBUG_DIR_86)
OBJ_RELEASE_DIR=$(OBJ_RELEASE_DIR_86)
endif

ifeq ($(RUNTIME_DEFINED),runtime)
WITHOUT_RUNTIME_FLAG=
GUIDS_WITHOUT_MINGW_FLAG=
GUIDS_WITHOUT_MINGW_SUFFIX=Mingw
WITHOUT_RUNTIME_SUFFIX=Rt
else
WITHOUT_RUNTIME_FLAG=-d WITHOUT_RUNTIME
GUIDS_WITHOUT_MINGW_FLAG=-d GUIDS_WITHOUT_MINGW
GUIDS_WITHOUT_MINGW_SUFFIX=WoMingw
WITHOUT_RUNTIME_SUFFIX=WoRt
endif

FREEBASIC_PARAMETERS_BASE=-r -gen $(CODE_GENERATION_BACKEND) -maxerr 1 -w all $(INCLUDEFILESPATH) $(UNICODE_FLAG) $(WITHOUT_CRITICAL_SECTIONS_FLAG) $(WITHOUT_RUNTIME_FLAG) $(GUIDS_WITHOUT_MINGW_FLAG) $(PERFORMANCE_TESTING_FLAG)

# -Werror-implicit-function-declaration
GCC_WARNING=-Werror -Wall -Wno-unused-label -Wno-unused-function -Wno-main -Wno-unused-variable
GCC_NOINCLUDE=-nostdlib -nostdinc -mno-stack-arg-probe -fno-stack-check -fno-stack-protector -fno-strict-aliasing -frounding-math -fno-math-errno -fno-exceptions -fno-unwind-tables -fno-asynchronous-unwind-tables -fno-ident

DEFAULT_STACK_SIZE=--stack 1048576,1048576

FREEBASIC_PARAMETERS_DEGUG=$(FREEBASIC_PARAMETERS_BASE) -g
FREEBASIC_PARAMETERS_RELEASE=$(FREEBASIC_PARAMETERS_BASE) -O 0
GCC_COMPILER_PARAMETERS_DEBUG=$(GCC_WARNING) $(GCC_NOINCLUDE) $(GCC_ARCHITECTURE) -masm=intel -S -g -Og
GCC_COMPILER_PARAMETERS_RELEASE=$(GCC_WARNING) $(GCC_NOINCLUDE) $(GCC_ARCHITECTURE) -masm=intel -S -Ofast
GCC_ASSEMBLER_PARAMETERS_DEBUG=$(TARGET_ASSEMBLER_ARCH)
GCC_ASSEMBLER_PARAMETERS_RELEASE=$(TARGET_ASSEMBLER_ARCH) --strip-local-absolute
GCC_LINKER_PARAMETERS_DEBUG=-m $(PE_FILE_FORMAT) -subsystem $(EXETYPEKIND) $(FB_EXTRA) -e $(ENTRY_POINT) $(DEFAULT_STACK_SIZE) -L $(COMPILER_LIB_PATH) -L "." --no-seh --nxcompat --gc-sections --print-gc-sections $(IMAGE_VERSION_MAJOR) $(IMAGE_VERSION_MINOR)
GCC_LINKER_PARAMETERS_RELEASE=-m $(PE_FILE_FORMAT) -subsystem $(EXETYPEKIND) $(FB_EXTRA) -e $(ENTRY_POINT) $(DEFAULT_STACK_SIZE) -L $(COMPILER_LIB_PATH) -L "." --no-seh --nxcompat --gc-sections --print-gc-sections $(IMAGE_VERSION_MAJOR) $(IMAGE_VERSION_MINOR) -s

.PHONY: debug release all clean install uninstall configure

include dependencies.make

$(BIN_RELEASE_DIR)\$(OUTPUT_FILE_NAME): $(ALL_OBJECT_FILES_RELEASE)
	$(GCC_LINKER) $(GCC_LINKER_PARAMETERS_RELEASE) $(ALL_OBJECT_FILES_RELEASE) -( $(ALL_OBJECT_LIBRARIES) -) -o "$(BIN_RELEASE_DIR)\$(OUTPUT_FILE_NAME)"

$(BIN_DEBUG_DIR)\$(OUTPUT_FILE_NAME):   $(ALL_OBJECT_FILES_DEGUG)
	$(GCC_LINKER) $(GCC_LINKER_PARAMETERS_DEBUG) $(ALL_OBJECT_FILES_DEGUG)   -( $(ALL_OBJECT_LIBRARIES) -) -o "$(BIN_DEBUG_DIR)\$(OUTPUT_FILE_NAME)"


configure:
	mkdir "$(BIN_DEBUG_DIR_64)"
	mkdir "$(BIN_RELEASE_DIR_64)"
	mkdir "$(OBJ_DEBUG_DIR_64)"
	mkdir "$(OBJ_RELEASE_DIR_64)"
	mkdir "$(BIN_DEBUG_DIR_86)"
	mkdir "$(BIN_RELEASE_DIR_86)"
	mkdir "$(OBJ_DEBUG_DIR_86)"
	mkdir "$(OBJ_RELEASE_DIR_86)"
