#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "RateMe.h"
#import "RateMeCondition.h"
#import "RateMeService.h"

FOUNDATION_EXPORT double RateMeVersionNumber;
FOUNDATION_EXPORT const unsigned char RateMeVersionString[];

