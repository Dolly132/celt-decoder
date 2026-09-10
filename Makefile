# Target OS (windows or linux) and Architecture (x86 or x64)
OS ?= windows
ARCH ?= x86

# Source files
SRCS = src/bands.c src/celt.c src/cwrs.c src/entcode.c \
       src/entdec.c src/entenc.c src/header.c src/kiss_fft.c \
       src/laplace.c src/mathops.c src/mdct.c src/modes.c \
       src/pitch.c src/plc.c src/quant_bands.c src/rate.c \
       src/vq.c

OBJS = $(SRCS:.c=.o)

# Toolchain and Target setup based on OS & ARCH
ifeq ($(OS), windows)
    ifeq ($(ARCH), x64)
        CC = x86_64-w64-mingw32-gcc
        AR = x86_64-w64-mingw32-ar
        TARGET = celt64.lib
        CFLAGS_ARCH = -m64
    else
        CC = i686-w64-mingw32-gcc
        AR = i686-w64-mingw32-ar
        TARGET = celt32.lib
        CFLAGS_ARCH = -m32
    endif
else ifeq ($(OS), linux)
    ifeq ($(ARCH), x64)
        CC = gcc
        AR = ar
        TARGET = libcelt64.a
        CFLAGS_ARCH = -m64 -fPIC
    else
        CC = gcc
        AR = ar
        TARGET = libcelt32.a
        CFLAGS_ARCH = -m32 -fPIC
    endif
endif

CFLAGS = $(CFLAGS_ARCH) -DHAVE_CONFIG_H -Iinclude -Isrc \
         -Wno-parentheses -Wno-tautological-pointer-compare \
         -Wno-implicit-function-declaration -std=gnu89

all: $(TARGET)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

$(TARGET): $(OBJS)
	$(AR) rcs $@ $(OBJS)

clean:
	rm -f $(OBJS)
