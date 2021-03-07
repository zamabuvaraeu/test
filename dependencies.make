OUTPUT_FILE_NAME=test.exe

IMAGE_VERSION_MAJOR=--major-image-version 1
IMAGE_VERSION_MINOR=--minor-image-version 0

release: $(BIN_RELEASE_DIR)\$(OUTPUT_FILE_NAME)

debug: $(BIN_DEBUG_DIR)\$(OUTPUT_FILE_NAME)

clean:
	echo del %AllFileWithExtensionC% %AllFileWithExtensionAsm% %AllObjectFiles%

# ALL_OBJECT_FILES_RELEASE=$(OBJ_RELEASE_DIR)\EntryPoint$(FILE_SUFFIX).o $(OBJ_RELEASE_DIR)\GetCompositions$(FILE_SUFFIX).o $(OBJ_RELEASE_DIR)\ArrayListOfInteger$(FILE_SUFFIX).o $(OBJ_RELEASE_DIR)\ArrayListOfArrayListOfInteger$(FILE_SUFFIX).o
ALL_OBJECT_FILES_RELEASE=$(OBJ_RELEASE_DIR)\EntryPoint$(FILE_SUFFIX).o

# ALL_OBJECT_FILES_DEGUG=$(OBJ_DEBUG_DIR)\EntryPoint$(FILE_SUFFIX).o $(OBJ_DEBUG_DIR)\GetCompositions$(FILE_SUFFIX).o $(OBJ_DEBUG_DIR)\ArrayListOfInteger$(FILE_SUFFIX).o $(OBJ_DEBUG_DIR)\ArrayListOfArrayListOfInteger$(FILE_SUFFIX).o
ALL_OBJECT_FILES_DEGUG=$(OBJ_DEBUG_DIR)\EntryPoint$(FILE_SUFFIX).o



$(OBJ_RELEASE_DIR)\EntryPoint$(FILE_SUFFIX).o: $(OBJ_RELEASE_DIR)\EntryPoint$(FILE_SUFFIX).asm
	$(GCC_ASSEMBLER) $(GCC_ASSEMBLER_PARAMETERS_RELEASE) $(OBJ_RELEASE_DIR)\EntryPoint$(FILE_SUFFIX).asm -o $(OBJ_RELEASE_DIR)\EntryPoint$(FILE_SUFFIX).o

$(OBJ_DEBUG_DIR)\EntryPoint$(FILE_SUFFIX).o:   $(OBJ_DEBUG_DIR)\EntryPoint$(FILE_SUFFIX).asm
	$(GCC_ASSEMBLER) $(GCC_ASSEMBLER_PARAMETERS_DEBUG) $(OBJ_DEBUG_DIR)\EntryPoint$(FILE_SUFFIX).asm -o $(OBJ_DEBUG_DIR)\EntryPoint$(FILE_SUFFIX).o


$(OBJ_RELEASE_DIR)\EntryPoint$(FILE_SUFFIX).asm: $(OBJ_RELEASE_DIR)\EntryPoint$(FILE_SUFFIX).c
	$(GCC_COMPILER) $(GCC_COMPILER_PARAMETERS_RELEASE) $(OBJ_RELEASE_DIR)\EntryPoint$(FILE_SUFFIX).c -o $(OBJ_RELEASE_DIR)\EntryPoint$(FILE_SUFFIX).asm

$(OBJ_DEBUG_DIR)\EntryPoint$(FILE_SUFFIX).asm:   $(OBJ_DEBUG_DIR)\EntryPoint$(FILE_SUFFIX).c
	$(GCC_COMPILER) $(GCC_COMPILER_PARAMETERS_DEBUG) $(OBJ_DEBUG_DIR)\EntryPoint$(FILE_SUFFIX).c -o $(OBJ_DEBUG_DIR)\EntryPoint$(FILE_SUFFIX).asm


$(OBJ_RELEASE_DIR)\EntryPoint$(FILE_SUFFIX).c: Modules\EntryPoint.bas Modules\EntryPoint.bi
	$(FREEBASIC_COMPILER) $(FREEBASIC_PARAMETERS_RELEASE) "Modules\EntryPoint.bas"
	move /y Modules\EntryPoint.c $(OBJ_RELEASE_DIR)\EntryPoint$(FILE_SUFFIX).c

$(OBJ_DEBUG_DIR)\EntryPoint$(FILE_SUFFIX).c:   Modules\EntryPoint.bas Modules\EntryPoint.bi
	$(FREEBASIC_COMPILER) $(FREEBASIC_PARAMETERS_DEGUG) "Modules\EntryPoint.bas"
	move /y Modules\EntryPoint.c $(OBJ_DEBUG_DIR)\EntryPoint$(FILE_SUFFIX).c



$(OBJ_RELEASE_DIR)\IntegerArrayList$(FILE_SUFFIX).o: $(OBJ_RELEASE_DIR)\IntegerArrayList$(FILE_SUFFIX).asm
	$(GCC_ASSEMBLER) $(GCC_ASSEMBLER_PARAMETERS_RELEASE) $(OBJ_RELEASE_DIR)\IntegerArrayList$(FILE_SUFFIX).asm -o $(OBJ_RELEASE_DIR)\IntegerArrayList$(FILE_SUFFIX).o

$(OBJ_DEBUG_DIR)\IntegerArrayList$(FILE_SUFFIX).o:   $(OBJ_DEBUG_DIR)\IntegerArrayList$(FILE_SUFFIX).asm
	$(GCC_ASSEMBLER) $(GCC_ASSEMBLER_PARAMETERS_DEBUG) $(OBJ_DEBUG_DIR)\IntegerArrayList$(FILE_SUFFIX).asm -o $(OBJ_DEBUG_DIR)\IntegerArrayList$(FILE_SUFFIX).o


$(OBJ_RELEASE_DIR)\IntegerArrayList$(FILE_SUFFIX).asm: $(OBJ_RELEASE_DIR)\IntegerArrayList$(FILE_SUFFIX).c
	$(GCC_COMPILER) $(GCC_COMPILER_PARAMETERS_RELEASE) $(OBJ_RELEASE_DIR)\IntegerArrayList$(FILE_SUFFIX).c -o $(OBJ_RELEASE_DIR)\IntegerArrayList$(FILE_SUFFIX).asm

$(OBJ_DEBUG_DIR)\IntegerArrayList$(FILE_SUFFIX).asm:   $(OBJ_DEBUG_DIR)\IntegerArrayList$(FILE_SUFFIX).c
	$(GCC_COMPILER) $(GCC_COMPILER_PARAMETERS_DEBUG) $(OBJ_DEBUG_DIR)\IntegerArrayList$(FILE_SUFFIX).c -o $(OBJ_DEBUG_DIR)\IntegerArrayList$(FILE_SUFFIX).asm


$(OBJ_RELEASE_DIR)\IntegerArrayList$(FILE_SUFFIX).c: Classes\IntegerArrayList.bas Classes\IntegerArrayList.bi Interfaces\IIntegerArrayList.bi
	$(FREEBASIC_COMPILER) $(FREEBASIC_PARAMETERS_RELEASE) "Classes\IntegerArrayList.bas"
	move /y Classes\IntegerArrayList.c $(OBJ_RELEASE_DIR)\IntegerArrayList$(FILE_SUFFIX).c

$(OBJ_DEBUG_DIR)\IntegerArrayList$(FILE_SUFFIX).c:   Classes\IntegerArrayList.bas Classes\IntegerArrayList.bi Interfaces\IIntegerArrayList.bi
	$(FREEBASIC_COMPILER) $(FREEBASIC_PARAMETERS_DEGUG) "Classes\IntegerArrayList.bas"
	move /y Classes\IntegerArrayList.c $(OBJ_DEBUG_DIR)\IntegerArrayList$(FILE_SUFFIX).c



$(OBJ_RELEASE_DIR)\GetCompositions$(FILE_SUFFIX).o: $(OBJ_RELEASE_DIR)\GetCompositions$(FILE_SUFFIX).asm
	$(GCC_ASSEMBLER) $(GCC_ASSEMBLER_PARAMETERS_RELEASE) $(OBJ_RELEASE_DIR)\GetCompositions$(FILE_SUFFIX).asm -o $(OBJ_RELEASE_DIR)\GetCompositions$(FILE_SUFFIX).o

$(OBJ_DEBUG_DIR)\GetCompositions$(FILE_SUFFIX).o:   $(OBJ_DEBUG_DIR)\GetCompositions$(FILE_SUFFIX).asm
	$(GCC_ASSEMBLER) $(GCC_ASSEMBLER_PARAMETERS_DEBUG) $(OBJ_DEBUG_DIR)\GetCompositions$(FILE_SUFFIX).asm -o $(OBJ_DEBUG_DIR)\GetCompositions$(FILE_SUFFIX).o


$(OBJ_RELEASE_DIR)\GetCompositions$(FILE_SUFFIX).asm: $(OBJ_RELEASE_DIR)\GetCompositions$(FILE_SUFFIX).c
	$(GCC_COMPILER) $(GCC_COMPILER_PARAMETERS_RELEASE) $(OBJ_RELEASE_DIR)\GetCompositions$(FILE_SUFFIX).c -o $(OBJ_RELEASE_DIR)\GetCompositions$(FILE_SUFFIX).asm

$(OBJ_DEBUG_DIR)\GetCompositions$(FILE_SUFFIX).asm:   $(OBJ_DEBUG_DIR)\GetCompositions$(FILE_SUFFIX).c
	$(GCC_COMPILER) $(GCC_COMPILER_PARAMETERS_DEBUG) $(OBJ_DEBUG_DIR)\GetCompositions$(FILE_SUFFIX).c -o $(OBJ_DEBUG_DIR)\GetCompositions$(FILE_SUFFIX).asm


$(OBJ_RELEASE_DIR)\GetCompositions$(FILE_SUFFIX).c: Modules\GetCompositions.bas Modules\GetCompositions.bi Modules\ArrayListOfArrayListOfInteger.bi Modules\ArrayListOfInteger.bi
	$(FREEBASIC_COMPILER) $(FREEBASIC_PARAMETERS_RELEASE) "Modules\GetCompositions.bas"
	move /y Modules\GetCompositions.c $(OBJ_RELEASE_DIR)\GetCompositions$(FILE_SUFFIX).c

$(OBJ_DEBUG_DIR)\GetCompositions$(FILE_SUFFIX).c:   Modules\GetCompositions.bas Modules\GetCompositions.bi Modules\ArrayListOfArrayListOfInteger.bi Modules\ArrayListOfInteger.bi
	$(FREEBASIC_COMPILER) $(FREEBASIC_PARAMETERS_DEGUG) "Modules\GetCompositions.bas"
	move /y Modules\GetCompositions.c $(OBJ_DEBUG_DIR)\GetCompositions$(FILE_SUFFIX).c



$(OBJ_RELEASE_DIR)\ArrayListOfInteger$(FILE_SUFFIX).o: $(OBJ_RELEASE_DIR)\ArrayListOfInteger$(FILE_SUFFIX).asm
	$(GCC_ASSEMBLER) $(GCC_ASSEMBLER_PARAMETERS_RELEASE) $(OBJ_RELEASE_DIR)\ArrayListOfInteger$(FILE_SUFFIX).asm -o $(OBJ_RELEASE_DIR)\ArrayListOfInteger$(FILE_SUFFIX).o

$(OBJ_DEBUG_DIR)\ArrayListOfInteger$(FILE_SUFFIX).o:   $(OBJ_DEBUG_DIR)\ArrayListOfInteger$(FILE_SUFFIX).asm
	$(GCC_ASSEMBLER) $(GCC_ASSEMBLER_PARAMETERS_DEBUG) $(OBJ_DEBUG_DIR)\ArrayListOfInteger$(FILE_SUFFIX).asm -o $(OBJ_DEBUG_DIR)\ArrayListOfInteger$(FILE_SUFFIX).o


$(OBJ_RELEASE_DIR)\ArrayListOfInteger$(FILE_SUFFIX).asm: $(OBJ_RELEASE_DIR)\ArrayListOfInteger$(FILE_SUFFIX).c
	$(GCC_COMPILER) $(GCC_COMPILER_PARAMETERS_RELEASE) $(OBJ_RELEASE_DIR)\ArrayListOfInteger$(FILE_SUFFIX).c -o $(OBJ_RELEASE_DIR)\ArrayListOfInteger$(FILE_SUFFIX).asm

$(OBJ_DEBUG_DIR)\ArrayListOfInteger$(FILE_SUFFIX).asm:   $(OBJ_DEBUG_DIR)\ArrayListOfInteger$(FILE_SUFFIX).c
	$(GCC_COMPILER) $(GCC_COMPILER_PARAMETERS_DEBUG) $(OBJ_DEBUG_DIR)\ArrayListOfInteger$(FILE_SUFFIX).c -o $(OBJ_DEBUG_DIR)\ArrayListOfInteger$(FILE_SUFFIX).asm


$(OBJ_RELEASE_DIR)\ArrayListOfInteger$(FILE_SUFFIX).c: Modules\ArrayListOfInteger.bas Modules\ArrayListOfInteger.bi
	$(FREEBASIC_COMPILER) $(FREEBASIC_PARAMETERS_RELEASE) "Modules\ArrayListOfInteger.bas"
	move /y Modules\ArrayListOfInteger.c $(OBJ_RELEASE_DIR)\ArrayListOfInteger$(FILE_SUFFIX).c

$(OBJ_DEBUG_DIR)\ArrayListOfInteger$(FILE_SUFFIX).c:   Modules\ArrayListOfInteger.bas Modules\ArrayListOfInteger.bi
	$(FREEBASIC_COMPILER) $(FREEBASIC_PARAMETERS_DEGUG) "Modules\ArrayListOfInteger.bas"
	move /y Modules\ArrayListOfInteger.c $(OBJ_DEBUG_DIR)\ArrayListOfInteger$(FILE_SUFFIX).c



$(OBJ_RELEASE_DIR)\ArrayListOfArrayListOfInteger$(FILE_SUFFIX).o: $(OBJ_RELEASE_DIR)\ArrayListOfArrayListOfInteger$(FILE_SUFFIX).asm
	$(GCC_ASSEMBLER) $(GCC_ASSEMBLER_PARAMETERS_RELEASE) $(OBJ_RELEASE_DIR)\ArrayListOfArrayListOfInteger$(FILE_SUFFIX).asm -o $(OBJ_RELEASE_DIR)\ArrayListOfArrayListOfInteger$(FILE_SUFFIX).o

$(OBJ_DEBUG_DIR)\ArrayListOfArrayListOfInteger$(FILE_SUFFIX).o:   $(OBJ_DEBUG_DIR)\ArrayListOfArrayListOfInteger$(FILE_SUFFIX).asm
	$(GCC_ASSEMBLER) $(GCC_ASSEMBLER_PARAMETERS_DEBUG) $(OBJ_DEBUG_DIR)\ArrayListOfArrayListOfInteger$(FILE_SUFFIX).asm -o $(OBJ_DEBUG_DIR)\ArrayListOfArrayListOfInteger$(FILE_SUFFIX).o


$(OBJ_RELEASE_DIR)\ArrayListOfArrayListOfInteger$(FILE_SUFFIX).asm: $(OBJ_RELEASE_DIR)\ArrayListOfArrayListOfInteger$(FILE_SUFFIX).c
	$(GCC_COMPILER) $(GCC_COMPILER_PARAMETERS_RELEASE) $(OBJ_RELEASE_DIR)\ArrayListOfArrayListOfInteger$(FILE_SUFFIX).c -o $(OBJ_RELEASE_DIR)\ArrayListOfArrayListOfInteger$(FILE_SUFFIX).asm

$(OBJ_DEBUG_DIR)\ArrayListOfArrayListOfInteger$(FILE_SUFFIX).asm:   $(OBJ_DEBUG_DIR)\ArrayListOfArrayListOfInteger$(FILE_SUFFIX).c
	$(GCC_COMPILER) $(GCC_COMPILER_PARAMETERS_DEBUG) $(OBJ_DEBUG_DIR)\ArrayListOfArrayListOfInteger$(FILE_SUFFIX).c -o $(OBJ_DEBUG_DIR)\ArrayListOfArrayListOfInteger$(FILE_SUFFIX).asm


$(OBJ_RELEASE_DIR)\ArrayListOfArrayListOfInteger$(FILE_SUFFIX).c: Modules\ArrayListOfArrayListOfInteger.bas Modules\ArrayListOfArrayListOfInteger.bi Modules\ArrayListOfInteger.bi
	$(FREEBASIC_COMPILER) $(FREEBASIC_PARAMETERS_RELEASE) "Modules\ArrayListOfArrayListOfInteger.bas"
	move /y Modules\ArrayListOfArrayListOfInteger.c $(OBJ_RELEASE_DIR)\ArrayListOfArrayListOfInteger$(FILE_SUFFIX).c

$(OBJ_DEBUG_DIR)\ArrayListOfArrayListOfInteger$(FILE_SUFFIX).c:   Modules\ArrayListOfArrayListOfInteger.bas Modules\ArrayListOfArrayListOfInteger.bi Modules\ArrayListOfInteger.bi
	$(FREEBASIC_COMPILER) $(FREEBASIC_PARAMETERS_DEGUG) "Modules\ArrayListOfArrayListOfInteger.bas"
	move /y Modules\ArrayListOfArrayListOfInteger.c $(OBJ_DEBUG_DIR)\ArrayListOfArrayListOfInteger$(FILE_SUFFIX).c



$(OBJ_RELEASE_DIR)\wMain$(FILE_SUFFIX).o: $(OBJ_RELEASE_DIR)\wMain$(FILE_SUFFIX).asm
	$(GCC_ASSEMBLER) $(GCC_ASSEMBLER_PARAMETERS_RELEASE) $(OBJ_RELEASE_DIR)\wMain$(FILE_SUFFIX).asm -o $(OBJ_RELEASE_DIR)\wMain$(FILE_SUFFIX).o

$(OBJ_DEBUG_DIR)\wMain$(FILE_SUFFIX).o:   $(OBJ_DEBUG_DIR)\wMain$(FILE_SUFFIX).asm
	$(GCC_ASSEMBLER) $(GCC_ASSEMBLER_PARAMETERS_DEBUG) $(OBJ_DEBUG_DIR)\wMain$(FILE_SUFFIX).asm -o $(OBJ_DEBUG_DIR)\wMain$(FILE_SUFFIX).o


$(OBJ_RELEASE_DIR)\wMain$(FILE_SUFFIX).asm: $(OBJ_RELEASE_DIR)\wMain$(FILE_SUFFIX).c
	$(GCC_COMPILER) $(GCC_COMPILER_PARAMETERS_RELEASE) $(OBJ_RELEASE_DIR)\wMain$(FILE_SUFFIX).c -o $(OBJ_RELEASE_DIR)\wMain$(FILE_SUFFIX).asm

$(OBJ_DEBUG_DIR)\wMain$(FILE_SUFFIX).asm:   $(OBJ_DEBUG_DIR)\wMain$(FILE_SUFFIX).c
	$(GCC_COMPILER) $(GCC_COMPILER_PARAMETERS_DEBUG) $(OBJ_DEBUG_DIR)\wMain$(FILE_SUFFIX).c -o $(OBJ_DEBUG_DIR)\wMain$(FILE_SUFFIX).asm


$(OBJ_RELEASE_DIR)\wMain$(FILE_SUFFIX).c: Modules\wMain.bas Modules\wMain.bi
	$(FREEBASIC_COMPILER) $(FREEBASIC_PARAMETERS_RELEASE) "Modules\wMain.bas"
	move /y Modules\wMain.c $(OBJ_RELEASE_DIR)\wMain$(FILE_SUFFIX).c

$(OBJ_DEBUG_DIR)\wMain$(FILE_SUFFIX).c:   Modules\wMain.bas Modules\wMain.bi
	$(FREEBASIC_COMPILER) $(FREEBASIC_PARAMETERS_DEGUG) "Modules\wMain.bas"
	move /y Modules\wMain.c $(OBJ_DEBUG_DIR)\wMain$(FILE_SUFFIX).c



# $(OBJ_RELEASE_DIR)\EntryPoint$(FILE_SUFFIX).asm: Modules\EntryPoint.bas
# $(FREEBASIC_COMPILER) $(FREEBASIC_PARAMETERS) "Modules\EntryPoint.bas"
# move /y Modules\EntryPoint.asm $(OBJ_RELEASE_DIR)\EntryPoint$(FILE_SUFFIX).asm

# $(OBJ_RELEASE_DIR)\EntryPoint$(FILE_SUFFIX).a64: Modules\EntryPoint.bas
# $(FREEBASIC_COMPILER) $(FREEBASIC_PARAMETERS) "Modules\EntryPoint.bas"
# move /y Modules\EntryPoint.a64 $(OBJ_RELEASE_DIR)\EntryPoint$(FILE_SUFFIX).a64

# $(OBJ_RELEASE_DIR)\EntryPoint$(FILE_SUFFIX).ll: Modules\EntryPoint.bas
# $(FREEBASIC_COMPILER) $(FREEBASIC_PARAMETERS) "Modules\EntryPoint.bas"
# move /y Modules\EntryPoint.ll $(OBJ_RELEASE_DIR)\EntryPoint$(FILE_SUFFIX).ll
