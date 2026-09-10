/* config.h — Cleaned for MSVC Static Linkage & SourceEngine Compatibility */

#ifndef CONFIG_H
#define CONFIG_H

/* This is a build of CELT */
#define CELT_BUILD 1

/* Version definitions */
#define CELT_EXTRA_VERSION ""
#define CELT_MAJOR_VERSION 0
#define CELT_MICRO_VERSION 11
#define CELT_MINOR_VERSION 1
#define CELT_VERSION "0.11.4"

/* Custom modes setup (Required for Valve/SourceMod compatibility) */
#define CUSTOM_MODES 1
#define CUSTOM_MODES_ONLY 1
#define OPUS_BUILD 1

/* Floating-point math support */
#define FLOATING_POINT 1

/* Standard C Header Availability for MSVC */
#define HAVE_STDINT_H 1
#define HAVE_STDLIB_H 1
#define HAVE_STRING_H 1
#define HAVE_MEMORY_H 1
#define HAVE_SYS_STAT_H 1
#define HAVE_SYS_TYPES_H 1
#define STDC_HEADERS 1

/* Disable Linux/POSIX headers on MSVC to prevent CRT conflicts */
#ifndef _WIN32
  #define HAVE_ALLOCA_H 1
  #define HAVE_UNISTD_H 1
  #define HAVE_GETOPT_H 1
  #define HAVE_GETOPT_LONG 1
  #define HAVE_DLFCN_H 1
  #define HAVE_INTTYPES_H 1
  #define HAVE_LIBM 1
  #define HAVE_LRINT 1
  #define HAVE_LRINTF 1
#endif

/* Standard Type Sizes for x86 / x64 MSVC */
#define SIZEOF_INT 4
#define SIZEOF_LONG 4
#define SIZEOF_LONG_LONG 8
#define SIZEOF_SHORT 2

/* 
 * CRITICAL FIX: Memory Allocation
 * DO NOT define USE_ALLOCA on Windows.
 * This forces CELT to use dynamic heap allocation (malloc/free)
 * and prevents stack corruption under MSVC.
 */
#ifdef _WIN32
  /* Disable alloca stack allocations on Windows completely */
  #undef USE_ALLOCA
  #undef VAR_ARRAYS
  #define GLOBAL_STACK_SIZE 120000
#else
  #define VAR_ARRAYS 1
#endif

/* MSVC Keyword and Warning Management */
#ifdef _MSC_VER
  #define restrict __restrict
  #define inline __inline

  #pragma warning(disable : 4018) // signed/unsigned mismatch
  #pragma warning(disable : 4244) // conversion loss of data
  #pragma warning(disable : 4267) // size_t to int conversion
  #pragma warning(disable : 4305) // truncation double to float
  #pragma warning(disable : 4311) // pointer truncation
  #pragma warning(disable : 4554) // operator precedence
  #pragma warning(disable : 4996) // POSIX name deprecation
#endif

#endif /* CONFIG_H */
