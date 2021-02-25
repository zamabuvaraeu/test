OUTPUT_FILE_NAME=test.exe

release: $(BIN_RELEASE_DIR)\$(OUTPUT_FILE_NAME)

debug: $(BIN_DEBUG_DIR)\$(OUTPUT_FILE_NAME)

IMAGE_VERSION_MAJOR=--major-image-version 1
IMAGE_VERSION_MINOR=--minor-image-version 0

ALL_OBJECT_FILES_RELEASE=$(OBJ_RELEASE_DIR)\EntryPoint$(FILE_SUFFIX).o

ALL_OBJECT_FILES_DEGUG=$(OBJ_DEBUG_DIR)\EntryPoint$(FILE_SUFFIX).o



$(BIN_RELEASE_DIR)\$(OUTPUT_FILE_NAME): $(ALL_OBJECT_FILES_RELEASE)
	$(GCC_LINKER) $(GCC_LINKER_PARAMETERS) -s $(ALL_OBJECT_FILES_RELEASE) -( $(ALL_OBJECT_LIBRARIES) -) -o "$(BIN_RELEASE_DIR)\$(OUTPUT_FILE_NAME)"

$(BIN_DEBUG_DIR)\$(OUTPUT_FILE_NAME):   $(ALL_OBJECT_FILES_DEGUG)
	$(GCC_LINKER) $(GCC_LINKER_PARAMETERS)    $(ALL_OBJECT_FILES_DEGUG)   -( $(ALL_OBJECT_LIBRARIES) -) -o "$(BIN_DEBUG_DIR)\$(OUTPUT_FILE_NAME)"



$(OBJ_RELEASE_DIR)\EntryPoint$(FILE_SUFFIX).o: $(OBJ_RELEASE_DIR)\EntryPoint$(FILE_SUFFIX).asm
	$(GCC_ASSEMBLER) $(TARGET_ASSEMBLER_ARCH) --strip-local-absolute $(OBJ_RELEASE_DIR)\EntryPoint$(FILE_SUFFIX).asm -o $(OBJ_RELEASE_DIR)\EntryPoint$(FILE_SUFFIX).o

$(OBJ_DEBUG_DIR)\EntryPoint$(FILE_SUFFIX).o:   $(OBJ_DEBUG_DIR)\EntryPoint$(FILE_SUFFIX).asm
	$(GCC_ASSEMBLER) $(TARGET_ASSEMBLER_ARCH)                          $(OBJ_DEBUG_DIR)\EntryPoint$(FILE_SUFFIX).asm -o $(OBJ_DEBUG_DIR)\EntryPoint$(FILE_SUFFIX).o



$(OBJ_RELEASE_DIR)\EntryPoint$(FILE_SUFFIX).asm: $(OBJ_RELEASE_DIR)\EntryPoint$(FILE_SUFFIX).c
	$(GCC_COMPILER) $(GCC_COMPILER_PARAMETERS) -Ofast $(OBJ_RELEASE_DIR)\EntryPoint$(FILE_SUFFIX).c -o $(OBJ_RELEASE_DIR)\EntryPoint$(FILE_SUFFIX).asm

$(OBJ_DEBUG_DIR)\EntryPoint$(FILE_SUFFIX).asm:   $(OBJ_DEBUG_DIR)\EntryPoint$(FILE_SUFFIX).c
	$(GCC_COMPILER) $(GCC_COMPILER_PARAMETERS) -g -Og $(OBJ_DEBUG_DIR)\EntryPoint$(FILE_SUFFIX).c -o $(OBJ_DEBUG_DIR)\EntryPoint$(FILE_SUFFIX).asm



$(OBJ_RELEASE_DIR)\EntryPoint$(FILE_SUFFIX).c: Modules\EntryPoint.bas
	$(FREEBASIC_COMPILER) $(FREEBASIC_PARAMETERS)    "Modules\EntryPoint.bas"
	move /y Modules\EntryPoint.c $(OBJ_RELEASE_DIR)\EntryPoint$(FILE_SUFFIX).c

$(OBJ_DEBUG_DIR)\EntryPoint$(FILE_SUFFIX).c:   Modules\EntryPoint.bas
	$(FREEBASIC_COMPILER) $(FREEBASIC_PARAMETERS) -g "Modules\EntryPoint.bas"
	move /y Modules\EntryPoint.c $(OBJ_DEBUG_DIR)\EntryPoint$(FILE_SUFFIX).c



# $(OBJ_RELEASE_DIR)\EntryPoint$(FILE_SUFFIX).asm: Modules\EntryPoint.bas
# $(FREEBASIC_COMPILER) $(FREEBASIC_PARAMETERS) "Modules\EntryPoint.bas"
# move /y Modules\EntryPoint.asm $(OBJ_RELEASE_DIR)\EntryPoint$(FILE_SUFFIX).asm

# $(OBJ_RELEASE_DIR)\EntryPoint$(FILE_SUFFIX).a64: Modules\EntryPoint.bas
# $(FREEBASIC_COMPILER) $(FREEBASIC_PARAMETERS) "Modules\EntryPoint.bas"
# move /y Modules\EntryPoint.a64 $(OBJ_RELEASE_DIR)\EntryPoint$(FILE_SUFFIX).a64

# $(OBJ_RELEASE_DIR)\EntryPoint$(FILE_SUFFIX).ll: Modules\EntryPoint.bas
# $(FREEBASIC_COMPILER) $(FREEBASIC_PARAMETERS) "Modules\EntryPoint.bas"
# move /y Modules\EntryPoint.ll $(OBJ_RELEASE_DIR)\EntryPoint$(FILE_SUFFIX).ll

Modules\EntryPoint.bas: Modules\EntryPoint.bi
Modules\EntryPoint.bi:
