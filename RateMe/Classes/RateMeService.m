//
//  RateMeService.m
//  Expecta
//
//  Created by Kadir Kemal Dursun on 23/01/2018.
//

#import "RateMeService.h"

static NSString *const triggerListKey = @"com.zingat.rateme.triggerlist";
static NSString *const remindMeLaterTimeKey = @"com.zingat.rateme.remindmelatertime";

@implementation RateMeService

-(void) saveTriggerList:(NSCountedSet *) triggerList{
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    [preferences setObject:triggerList forKey:triggerListKey];
    [preferences synchronize];
}

-(nonnull NSCountedSet *) loadTriggerList{
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    NSCountedSet *r = [preferences objectForKey:triggerListKey];
    if(r == nil){
        return [NSCountedSet new];
    }
    return r;
}

-(void) updateRemindMeLaterTime{
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    [preferences setObject:[NSDate date] forKey:remindMeLaterTimeKey];
    [preferences synchronize];
}

-(nullable NSDate *) remindMeLaterTime{
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    return [preferences objectForKey:remindMeLaterTimeKey];
}

@end
