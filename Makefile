# Default to 64-bit MinGW compiler (matches your MSVC x64 build)
# Change to i686-w64-mingw32-gcc if you are building an x86/32-bit extension
CC ?= x86_64-w64-mingw32-gcc

# Source files inside src/
CELT_SRCS = src/bands.c src/celt.c src/cwrs.c src/entcode.c \
            src/entdec.c src/entenc.c src/header.c src/kiss_fft.c \
            src/laplace.c src/mathops.c src/mdct.c src/modes.c \
            src/pitch.c src/plc.c src/quant_bands.c src/rate.c \
            src/vq.c

# Headers for change tracking
CELT_HDRS = $(wildcard include/*.h) $(wildcard src/*.h)

# Compiler flags for Windows & legacy C support
CFLAGS = -DHAVE_CONFIG_H -Iinclude -Isrc \
         -Wno-parentheses -Wno-tautological-pointer-compare \
         -Wno-implicit-function-declaration -std=gnu89

# Output targets: DLL + Import Library for MSVC
TARGET_DLL = celt32.dll
TARGET_LIB = libcelt32.lib

all: $(TARGET_DLL)

$(TARGET_DLL): config.h $(CELT_SRCS) $(CELT_HDRS)
	$(CC) $(CFLAGS) -shared $(CELT_SRCS) \
		-Wl,--out-implib,$(TARGET_LIB) \
		-o $@

# Generate a minimal config.h if missing
config.h:
	@echo "Creating static config.h for Windows..."
	@echo "#ifndef CONFIG_H" > config.h
	@echo "#define CONFIG_H" >> config.h
	@echo "#define inline __inline" >> config.h
	@echo "#define USE_ALLOCA 1" >> config.h
	@echo "#endif" >> config.h

clean:
	rm -f $(TARGET_DLL) $(TARGET_LIB) config.h
