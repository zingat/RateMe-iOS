//
//  RateMeService.m
//  Expecta
//
//  Created by Kadir Kemal Dursun on 23/01/2018.
//

#import "RateMeService.h"

static NSString *const triggerListKey = @"com.zingat.rateme.triggerlist";
static NSString *const remindMeLaterTimeKey = @"com.zingat.rateme.remindmelatertime";
static NSString *const onRateMeTimeCounterKey = @"com.zingat.rateme.onratemetimecounter";

@implementation RateMeService

-(void) saveTriggerList:(nonnull NSCountedSet *) triggerList{
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    
    NSData * serializedSet = [NSKeyedArchiver archivedDataWithRootObject:triggerList];
    [preferences setObject:serializedSet forKey:triggerListKey];
    
    [preferences synchronize];
}

-(nonnull NSCountedSet *) loadTriggerList{
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    
    NSData *r = [preferences objectForKey:triggerListKey];
    if(r == nil){
        return [NSCountedSet new];
    }
    
    NSCountedSet *countedSet = [NSKeyedUnarchiver unarchiveObjectWithData:r];
    return countedSet;
}

-(void) clearTriggerList{
    [self saveTriggerList:[NSCountedSet new]];
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

-(void)clearRemindMeLaterTime{
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    [preferences removeObjectForKey:remindMeLaterTimeKey];
    [preferences synchronize];
}

-(void) increaseOnRateMeTimeCounter{
    NSInteger counter = [self onRateMeTimeCounter];
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    [preferences setInteger:counter+1 forKey:onRateMeTimeCounterKey];
    [preferences synchronize];
}

-(NSInteger) onRateMeTimeCounter{
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    return [preferences integerForKey:onRateMeTimeCounterKey];
}

@end
