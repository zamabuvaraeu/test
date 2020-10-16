COMPILERDIRECTORY=$(ProgramFiles)\FreeBASIC
FREEBASIC_COMPILER="$(ProgramFiles)\FreeBASIC\fbc.exe"
INCLUDEFILESPATH=-i Classes -i Interfaces -i Modules -i Headers
EXETYPEKIND=console
MAXERRORSCOUNT=-maxerr 1
MINWARNINGLEVEL=-w all

# Все флаги:
# DEBUG 0 | 1
# WINDOWS_SERVICE_FLAG=-d WINDOWS_SERVICE
# GUIDS_WITHOUT_MINGW_FLAG=-d GUIDS_WITHOUT_MINGW
# WITHOUT_RUNTIME_FLAG=-d WITHOUT_RUNTIME
# UNICODE_FLAG=-d UNICODE
# WITHOUT_CRITICAL_SECTIONS_FLAG=-d WITHOUT_CRITICAL_SECTIONS
# PERFORMANCE_TESTING

ifeq ($@,WindowsService)
WINDOWS_SERVICE_FLAG=-d WINDOWS_SERVICE
WINDOWS_SERVICE_SUFFIX=Service
else
WINDOWS_SERVICE_FLAG=
WINDOWS_SERVICE_SUFFIX=Console
endif

PERFORMANCE_TESTING_FLAG=
PERFORMANCE_TESTING_SUFFIX=WoPT

GUIDS_WITHOUT_MINGW_FLAG=-d GUIDS_WITHOUT_MINGW
GUIDS_WITHOUT_MINGW_SUFFIX=WoMingw

WITHOUT_RUNTIME_FLAG=-d WITHOUT_RUNTIME
WITHOUT_RUNTIME_SUFFIX=WoRt

WITHOUT_CRITICAL_SECTIONS_FLAG=-d WITHOUT_CRITICAL_SECTIONS
WITHOUT_CRITICAL_SECTIONS_SUFFIX=WoCr

UNICODE_FLAG=-d UNICODE
UNICODE_SUFFIX=W

FILE_SUFFIX=$(WINDOWS_SERVICE_SUFFIX)$(PERFORMANCE_TESTING_SUFFIX)$(GUIDS_WITHOUT_MINGW_SUFFIX)$(WITHOUT_RUNTIME_SUFFIX)$(WITHOUT_CRITICAL_SECTIONS_SUFFIX)$(UNICODE_SUFFIX)

ALL_OBJECT_FILES=$(OBJ_DIR)\EntryPoint$(FILE_SUFFIX).o

ALL_OBJECT_FILES_CONSOLE=$(ALL_OBJECT_FILES)

ALL_OBJECT_FILES_SERVICE=$(ALL_OBJECT_FILES)

ALL_OBJECT_FILES_TEST=$(ALL_OBJECT_FILES)

CODEGENERATIONBACKEND=gcc
# CODEGENERATIONBACKEND=gas
# CODEGENERATIONBACKEND=lvvm
# CODEGENERATIONBACKEND=studious

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
ALL_OBJECT_LIBRARIES=$(WinApiObjectLibraries) $(GMonitorObjectLibraries) $(GccObjectLibraries)

MajorImageVersion=--major-image-version 1
MinorImageVersion=--minor-image-version 0

ifeq ($(PROCESSOR_ARCHITECTURE),AMD64)

# GCC_COMPILER="$(ProgramFiles)\FreeBASIC\bin\win64\gcc.exe"
# GCC_ASSEMBLER="$(ProgramFiles)\FreeBASIC\bin\win64\as.exe"
# GCC_LINKER="$(ProgramFiles)\FreeBASIC\bin\win64\ld.exe"
# ARCHIVE_COMPILER="$(ProgramFiles)\FreeBASIC\bin\win64\ar.exe"
# DLL_TOOL="$(ProgramFiles)\FreeBASIC\bin\win64\dlltool.exe"
GCC_COMPILER="$(ProgramFiles)\mingw-w64\x86_64-8.1.0-posix-seh-rt_v6-rev0\mingw64\bin\gcc.exe"
GCC_ASSEMBLER="$(ProgramFiles)\mingw-w64\x86_64-8.1.0-posix-seh-rt_v6-rev0\mingw64\bin\as.exe"
GCC_LINKER="$(ProgramFiles)\mingw-w64\x86_64-8.1.0-posix-seh-rt_v6-rev0\mingw64\bin\ld.exe"
ARCHIVE_COMPILER="$(ProgramFiles)\mingw-w64\x86_64-8.1.0-posix-seh-rt_v6-rev0\mingw64\bin\ar.exe"
DLL_TOOL="$(ProgramFiles)\mingw-w64\x86_64-8.1.0-posix-seh-rt_v6-rev0\mingw64\bin\dlltool.exe"
RESOURCE_COMPILER="$(ProgramFiles)\FreeBASIC\bin\win64\GoRC.exe"
COMPILER_LIB_PATH="$(ProgramFiles)\FreeBASIC\lib\win64"
FBEXTRA=linkerscript.x

GCC_ARCHITECTURE=-m64 -march=x86-64
TARGET_ASSEMBLER_ARCH=--64
ENTRY_POINT=EntryPoint
PE_FILE_FORMAT=i386pep

BIN_DEBUG_DIR=$(BIN_DEBUG_DIR_64)
BIN_RELEASE_DIR=$(BIN_RELEASE_DIR_64)
OBJ_DEBUG_DIR=$(OBJ_DEBUG_DIR_64)
OBJ_RELEASE_DIR=$(OBJ_RELEASE_DIR_64)

ResourceCompilerBitFlag=/machine X64

else

GCC_COMPILER="$(ProgramFiles)\FreeBASIC\bin\win32\gcc.exe"
GCC_ASSEMBLER="$(ProgramFiles)\FreeBASIC\bin\win32\as.exe"
RESOURCE_COMPILER="$(ProgramFiles)\FreeBASIC\bin\win32\GoRC.exe"
GCC_LINKER="$(ProgramFiles)\FreeBASIC\bin\win32\ld.exe"
ARCHIVE_COMPILER="$(ProgramFiles)\FreeBASIC\bin\win32\ar.exe"
DLL_TOOL="$(ProgramFiles)\FreeBASIC\bin\win32\dlltool.exe"
COMPILER_LIB_PATH="$(ProgramFiles)\FreeBASIC\lib\win32"
FBEXTRA=linkerscript.x

GCC_ARCHITECTURE=
TARGET_ASSEMBLER_ARCH=--32
ENTRY_POINT=_EntryPoint@0
PE_FILE_FORMAT=i386pe

BIN_DEBUG_DIR=$(BIN_DEBUG_DIR_86)
BIN_RELEASE_DIR=$(BIN_RELEASE_DIR_86)
OBJ_DEBUG_DIR=$(OBJ_DEBUG_DIR_86)
OBJ_RELEASE_DIR=$(OBJ_RELEASE_DIR_86)

ResourceCompilerBitFlag=/nw

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

FREEBASIC_PARAMETERS_BASE=-g -r -lib -gen $(CODEGENERATIONBACKEND) $(MAXERRORSCOUNT) $(MINWARNINGLEVEL) $(INCLUDEFILESPATH) $(UNICODE_FLAG) $(WITHOUT_CRITICAL_SECTIONS_FLAG) $(WINDOWS_SERVICE_FLAG) $(WITHOUT_RUNTIME_FLAG) $(GUIDS_WITHOUT_MINGW_FLAG) $(PERFORMANCE_TESTING_FLAG)

# -Werror-implicit-function-declaration
GCC_WARNING=-Werror -Wall -Wno-unused-label -Wno-unused-function -Wno-main
GCC_NOINCLUDE=-nostdlib -nostdinc -mno-stack-arg-probe -fno-stack-check -fno-stack-protector -fno-strict-aliasing -frounding-math -fno-math-errno -fno-exceptions -fno-unwind-tables -fno-asynchronous-unwind-tables -fno-ident

DEFAULT_STACK_SIZE=--stack 1048576,1048576

ifeq ($(DEBUG),1)

ASSEMBLER_STRIP_FLAG=
LINKER_STRIP_FLAG=
BIN_DIR=$(BIN_DEBUG_DIR)
OBJ_DIR=$(OBJ_DEBUG_DIR)
GCC_COMPILER_PARAMETERS=$(GCC_WARNING) $(GCC_ARCHITECTURE) -masm=intel -S -Og -g
FREEBASIC_PARAMETERS=$(FREEBASIC_PARAMETERS_BASE)

else

ASSEMBLER_STRIP_FLAG=--strip-local-absolute
LINKER_STRIP_FLAG=-s
BIN_DIR=$(BIN_RELEASE_DIR)
OBJ_DIR=$(OBJ_RELEASE_DIR)
GCC_COMPILER_PARAMETERS=$(GCC_WARNING) $(GCC_NOINCLUDE) $(GCC_ARCHITECTURE) -masm=intel -S -Ofast
FREEBASIC_PARAMETERS=$(FREEBASIC_PARAMETERS_BASE)

endif

.PHONY: all clean install uninstall configure test

test: $(BIN_DIR)\test.exe

$(BIN_DIR)\test.exe: $(ALL_OBJECT_FILES)
	$(GCC_LINKER) -m $(PE_FILE_FORMAT) -subsystem console -e $(ENTRY_POINT) $(DEFAULT_STACK_SIZE) --no-seh --nxcompat --gc-sections --print-gc-sections $(LINKER_STRIP_FLAG) -L $(COMPILER_LIB_PATH) -L "." $(ALL_OBJECT_FILES) -( $(ALL_OBJECT_LIBRARIES) -) -o "$(BIN_DIR)\test.exe"


$(OBJ_DIR)\EntryPoint$(FILE_SUFFIX).o: $(OBJ_DIR)\EntryPoint$(FILE_SUFFIX).asm
	$(GCC_ASSEMBLER) $(TARGET_ASSEMBLER_ARCH) $(ASSEMBLER_STRIP_FLAG) $(OBJ_DIR)\EntryPoint$(FILE_SUFFIX).asm -o $(OBJ_DIR)\EntryPoint$(FILE_SUFFIX).o

$(OBJ_DIR)\EntryPoint$(FILE_SUFFIX).asm: $(OBJ_DIR)\EntryPoint$(FILE_SUFFIX).c
	$(GCC_COMPILER) $(GCC_COMPILER_PARAMETERS) $(OBJ_DIR)\EntryPoint$(FILE_SUFFIX).c -o $(OBJ_DIR)\EntryPoint$(FILE_SUFFIX).asm

$(OBJ_DIR)\EntryPoint$(FILE_SUFFIX).c: Modules\EntryPoint.bas
	$(FREEBASIC_COMPILER) $(FREEBASIC_PARAMETERS) "Modules\EntryPoint.bas"
	move /y Modules\EntryPoint.c $(OBJ_DIR)\EntryPoint$(FILE_SUFFIX).c


include dependencies.make

clean:
	echo del %AllFileWithExtensionC% %AllFileWithExtensionAsm% %AllObjectFiles%

configure:
	mkdir "$(BIN_DEBUG_DIR_64)"
	mkdir "$(BIN_RELEASE_DIR_64)"
	mkdir "$(OBJ_DEBUG_DIR_64)"
	mkdir "$(OBJ_RELEASE_DIR_64)"
	mkdir "$(BIN_DEBUG_DIR_86)"
	mkdir "$(BIN_RELEASE_DIR_86)"
	mkdir "$(OBJ_DEBUG_DIR_86)"
	mkdir "$(OBJ_RELEASE_DIR_86)"