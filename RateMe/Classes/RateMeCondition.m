//
//  RateMeCondition.m
//  Expecta
//
//  Created by Kadir Kemal Dursun on 23/01/2018.
//

#import "RateMeCondition.h"

@interface BasicRateMeCondition : RateMeCondition
@end

@implementation BasicRateMeCondition{
    NSString *_triggerName;
    NSInteger _count;
}
-(instancetype) initWithTriggerName:(NSString *)triggerName count:(NSInteger) count{
    self = [super init];
    if(self){
        _triggerName = triggerName;
        _count = count;
    }
    return self;
}

-(BOOL) checkCondition:(NSCountedSet *) triggerList{    
    if(triggerList == nil || ![triggerList containsObject:_triggerName]){
        return NO;
    }
    
    return [triggerList countForObject:_triggerName] >= _count;
}
@end

@interface GroupTotalRateMeCondition : RateMeCondition
@end

@implementation GroupTotalRateMeCondition{
    NSArray<NSString *> *_triggerNameList;
    NSInteger _count;
}
-(instancetype) initWithTriggerNameList:(NSArray<NSString *> *)triggerNameList count:(NSInteger) count{
    self = [super init];
    if(self){
        _triggerNameList = triggerNameList;
        _count = count;
    }
    return self;
}

-(BOOL) checkCondition:(NSCountedSet *) triggerList{
    if(triggerList == nil){
        return NO;
    }
    
    int totalCount = 0;
    
    for(NSString *s in _triggerNameList){
        if([triggerList containsObject:s]){
            totalCount += [triggerList countForObject:s];
        }
    }

    return totalCount >= _count;
}
@end

@interface AndListRateMeCondition : RateMeCondition
@end

@implementation AndListRateMeCondition{
    NSArray<RateMeCondition *> *_conditionList;
}
-(instancetype) initWithConditionList:(NSArray<RateMeCondition *> *)conditionList{
    self = [super init];
    if(self){
        _conditionList = conditionList;
    }
    return self;
}

-(BOOL) checkCondition:(NSCountedSet *) triggerList{
    if(triggerList == nil){
        return NO;
    }
    
    for(RateMeCondition *condition in _conditionList){
        if(![condition checkCondition:triggerList]){
            return NO;
        }
    }
    return YES;
}
@end

@implementation RateMeCondition

+(RateMeCondition *) rateMeConditionWithTriggerName:(NSString *)triggerName count:(NSInteger) count{
    return [[BasicRateMeCondition alloc] initWithTriggerName:triggerName count:count];
}

+(RateMeCondition *) rateMeConditionWithTriggerNameList:(NSArray<NSString *> *)triggerNameList count:(NSInteger) count{
    return [[GroupTotalRateMeCondition alloc] initWithTriggerNameList:triggerNameList count:count];
}

+(RateMeCondition *) rateMeConditionWithConditionList:(NSArray<RateMeCondition *> *)conditionList{
    return [[AndListRateMeCondition alloc] initWithConditionList:conditionList];
}

-(instancetype) initWithTriggerName:(NSString *)triggerName count:(NSInteger) count{
    return [[BasicRateMeCondition alloc] initWithTriggerName:triggerName count:count];
}

-(instancetype) initWithTriggerNameList:(NSArray<NSString *> *)triggerNameList count:(NSInteger) count{
    return [[GroupTotalRateMeCondition alloc] initWithTriggerNameList:triggerNameList count:count];
}

-(instancetype) initWithConditionList:(NSArray<RateMeCondition *> *)conditionList{
    return [[AndListRateMeCondition alloc] initWithConditionList:conditionList];
}

-(BOOL) checkCondition:(NSCountedSet *) triggerList{
    //[self doesNotRecognizeSelector:_cmd];
    return NO;
}
@end
