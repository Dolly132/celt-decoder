# Default to MinGW 32-bit compiler if not set
CC ?= i686-w64-mingw32-gcc

# Source files
CELT_SRCS = celt/src/bands.c celt/src/celt.c celt/src/cwrs.c celt/src/entcode.c \
            celt/src/entdec.c celt/src/entenc.c celt/src/header.c celt/src/kiss_fft.c \
            celt/src/laplace.c celt/src/mathops.c celt/src/mdct.c celt/src/modes.c \
            celt/src/pitch.c celt/src/plc.c celt/src/quant_bands.c celt/src/rate.c \
            celt/src/vq.c

# Headers for change tracking
CELT_HDRS = $(wildcard celt/include/*.h) $(wildcard celt/src/*.h)

# Compiler flags targeting 32-bit Windows & legacy C support
CFLAGS = -m32 -DHAVE_CONFIG_H -Icelt/include -Icelt/src \
         -Wno-parentheses -Wno-tautological-pointer-compare \
         -Wno-implicit-function-declaration -std=gnu89

# Output target (celt32.dll or celt32.exe)
celt32.dll: $(CELT_SRCS) $(CELT_HDRS)
	$(CC) $(CFLAGS) -shared $(CELT_SRCS) -o $@
