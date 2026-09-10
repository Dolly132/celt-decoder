@echo off
:: Compile 32-bit (x86)
cl.exe /c /O2 /MD /DHAVE_CONFIG_H /Iinclude /Isrc src/*.c
lib.exe /OUT:celt32.lib *.obj
del *.obj

:: Note: For 64-bit builds, run under the x64 Native Tools Command Prompt to output celt64.lib
