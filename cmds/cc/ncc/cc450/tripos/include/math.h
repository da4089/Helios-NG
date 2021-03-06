
/* math.h: ANSI draft (X3J11 Oct 86) library header, section 4.5 */
/* Copyright (C) A.C. Norman and A. Mycroft */
/* version 0.01 */

#ifndef __math_h
#define __math_h

/* The (two of the!) following three macros also appear in <stdlib.h> */
#ifndef EDOM
#  define EDOM   1
#endif
#ifndef ERANGE
#  define ERANGE 2
#endif
#ifndef HUGE_VAL
extern const double _huge_val;
#  define HUGE_VAL _huge_val
#endif

#ifndef errno
extern volatile int _errno;
#  define errno _errno
#endif

extern double acos(double x);
extern double asin(double x);
extern double atan(double x);
extern double atan2(double y, double x);

extern double cos(double x);
extern double sin(double x);
extern double tan(double x);

extern double cosh(double x);
extern double sinh(double x);
extern double tanh(double x);

extern double exp(double x);
extern double frexp(double value, int *exp);
extern double ldexp(double x, int exp);
extern double log(double x);
extern double log10(double x);
extern double modf(double value, double *iptr);

extern double pow(double x, double y);
extern double sqrt(double x);

extern double ceil(double x);
extern double fabs(double x);
extern double floor(double d);
extern double fmod(double x, double y);

#endif

/* end of math.h */
