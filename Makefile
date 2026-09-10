# Default to MinGW 32-bit compiler if not set
CC ?= i686-w64-mingw32-gcc

# Source files inside src/
CELT_SRCS = src/bands.c src/celt.c src/cwrs.c src/entcode.c \
            src/entdec.c src/entenc.c src/header.c src/kiss_fft.c \
            src/laplace.c src/mathops.c src/mdct.c src/modes.c \
            src/pitch.c src/plc.c src/quant_bands.c src/rate.c \
            src/vq.c

# Headers for change tracking
CELT_HDRS = $(wildcard src/*.h)

# Compiler flags for 32-bit Windows & legacy C support
CFLAGS = -m32 -DHAVE_CONFIG_H -I. -Isrc \
         -Wno-parentheses -Wno-tautological-pointer-compare \
         -Wno-implicit-function-declaration -std=gnu89

# Output binary target
celt32.dll: $(CELT_SRCS) $(CELT_HDRS)
	$(CC) $(CFLAGS) -shared $(CELT_SRCS) -o $@
