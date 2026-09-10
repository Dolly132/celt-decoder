# Target 32-bit MinGW cross-compiler
CC = i686-w64-mingw32-gcc
AR = i686-w64-mingw32-ar

# Source files (all inside src/)
SRCS = src/bands.c src/celt.c src/cwrs.c src/entcode.c \
       src/entdec.c src/entenc.c src/header.c src/kiss_fft.c \
       src/laplace.c src/mathops.c src/mdct.c src/modes.c \
       src/pitch.c src/plc.c src/quant_bands.c src/rate.c \
       src/vq.c

# Object files
OBJS = $(SRCS:.c=.o)

# Compiler flags targeting 32-bit Windows & legacy C
CFLAGS = -m32 -DHAVE_CONFIG_H -Iinclude -Isrc \
         -Wno-parentheses -Wno-tautological-pointer-compare \
         -Wno-implicit-function-declaration -std=gnu89

# Output static library target
TARGET = celt32.lib

all: $(TARGET)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

$(TARGET): $(OBJS)
	$(AR) rcs $@ $(OBJS)

clean:
	rm -f $(OBJS) $(TARGET)
