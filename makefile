# This is makefile for Lena compiler + Llibs

# Compiler --------------------->
CC = gcc

# Flags --------------------->
LENAUP_CFLAGS = -O3 -Wall -MMD -std=c17 -Iinclude -D USE_LINGUA

# OS --------------------->
OS := $(shell node scripts/os.js)

# Add flags based on OS --------------------->
LENAUP_CFLAGS += $(shell node scripts/os-flags.js $(OS))

# And based on CPU arch --------------------->
LENAUP_CFLAGS += $(shell node scripts/arch-flags.js)

# Add current time for Lena build information --------------------->
LENAUP_CFLAGS += $(shell node scripts/date.js)

# LENAUP_OUT --------------------->
LENAUP_OUT := $(shell node scripts/out.js $(OS))

# Llibs path --------------------->

LLIBS_PATH = external/llibs

# Llibs build ------------------------------------------>

LLIBS_CFLAGS = -O3 -Wall -MMD -std=c17 -Iinclude -I$(LLIBS_PATH)/cross/include

# Use Lingua framework ------------------------------------------>
LLIBS_CFLAGS += -D USE_LINGUA

LLIBS_NATIVE_PATH := $(shell node $(LLIBS_PATH)/scripts/native.js $(OS))

# Different files --------------------->
LLIBS_SRC_FILES := $(shell node scripts/find.js $(LLIBS_PATH)/$(LLIBS_NATIVE_PATH) .c)\
	$(shell node scripts/find.js $(LLIBS_PATH)/cross/ .c)\
	$(shell node scripts/find.js $(LLIBS_PATH)/external/lingua/src .c)
LLIBS_OBJ_FILES := $(LLIBS_SRC_FILES:.c=.o)
LLIBS_DEP_FILES := $(LLIBS_OBJ_FILES:.o=.d)

# Lena build ------------------------------------------>

# Llibs framework --------------------->
LENAUP_CFLAGS += -I$(LLIBS_PATH)/cross/include

# Different files --------------------->
LENAUP_SRC_FILES := $(shell node scripts/find.js src .c)
LENAUP_OBJ_FILES := $(LENAUP_SRC_FILES:.c=.o)
LENAUP_DEP_FILES := $(LENAUP_OBJ_FILES:.o=.d)
LENAUP_ASM_FILES := $(LENAUP_SRC_FILES:.c=.s)

# Default Target --------------------->
all: $(LENAUP_OUT) $(LENAUP_ASM_FILES)

# Linking Llibs and Lena together --------------------->
$(LENAUP_OUT): $(LENAUP_OBJ_FILES) $(LLIBS_OBJ_FILES)
	$(CC) $(LENAUP_CFLAGS) -o $@ $^

# Compiling Lena object files --------------------->
%.o: %.c
	$(CC) $(LENAUP_CFLAGS) -c $< -o $@

# Compiling Lena Assembler files --------------------->
%.s: %.c
	$(CC) $(LENAUP_CFLAGS) -Wa,-adhln -S -fverbose-asm $< -o $@

# Compiling Llibs object files --------------------->
$(LLIBS_NATIVE_PATH)/src/%.o: $(LLIBS_NATIVE_PATH)/src/%.c
	$(CC) $(LLIBS_CFLAGS) -c $< -o $@

$(LLIBS_PATH)/cross/src/%.o: $(LLIBS_PATH)/cross/src/%.c
	$(CC) $(LLIBS_CFLAGS) -c $< -o $@

$(LLIBS_PATH)/external/lingua/src/%.o: $(LLIBS_PATH)/external/lingua/src/%.c
	$(CC) $(LLIBS_CFLAGS) -c $< -o $@

# Include generated dependencies --------------------->
-include $(LENAUP_DEP_FILES) $(LLIBS_DEP_FILES)

# Clean --------------------->
clean:
	$(shell node scripts/clean.js $(LENAUP_OBJ_FILES) $(LENAUP_DEP_FILES) $(LLIBS_OBJ_FILES) $(LLIBS_DEP_FILES) $(LENAUP_ASM_FILES) ) 
