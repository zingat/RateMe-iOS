//
//  ZngAppDelegate.m
//  RateMe
//
//  Created by kadirkemal on 01/23/2018.
//  Copyright (c) 2018 kadirkemal. All rights reserved.
//

#import "ZngAppDelegate.h"
#import <StoreKit/StoreKit.h>
#import <RateMe/RateMe.h>

@interface ZngAppDelegate()<RateMeDelegate>
@end

@implementation ZngAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [[RateMe sharedInstance] addConditionWithName:@"event1" count:3];
    [[RateMe sharedInstance] addConditionWithName:@"event2" count:5];
    [[RateMe sharedInstance] addConditionWithNameList:@[@"event3", @"event4"] count:5];
    [RateMe sharedInstance].delegate = self;
    
    return YES;
}

-(void)onRateMeTime{
    [SKStoreReviewController requestReview];
}


@end
