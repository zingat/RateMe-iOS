//
//  RateMe.m
//  Expecta
//
//  Created by Kadir Kemal Dursun on 23/01/2018.
//

#import "RateMe.h"

@implementation RateMe{
    NSMutableArray<RateMeCondition *> *_conditionList;
    NSCountedSet *_triggerList;
    dispatch_queue_t _rateMeQueue;
}

+(RateMe *) sharedInstance{
    static RateMe* _sharedInstance;
    static dispatch_once_t token;
    
    dispatch_once(&token, ^{
        _sharedInstance = [[RateMe alloc] initWithService:[RateMeService new]];
    });
    
    return _sharedInstance;
}

-(instancetype) initWithService:(RateMeService *) service{
    self = [super init];
    if(self){
        _rateMeQueue = dispatch_queue_create("com.zingat.rateme", DISPATCH_QUEUE_SERIAL);
        _conditionList = [NSMutableArray<RateMeCondition *> new];
        _remindMeLaterDuration = 3; //default value is 3 days
        _delayDuration = 10; //default value is 10 seconds
        
        dispatch_async(_rateMeQueue, ^{
            _triggerList = [NSCountedSet new];
        });
    }
    return self;
}

-(void) addConditionWithName:(NSString *)triggerName count:(int)triggerCount{
    [_conditionList addObject:[RateMeCondition rateMeConditionWithTriggerName:triggerName count:triggerCount]];
}

-(void) addConditionWithNameList:(NSArray<NSString *> *)triggerNameList count:(int)triggerCount{
    [_conditionList addObject:[RateMeCondition rateMeConditionWithTriggerNameList:triggerNameList count:triggerCount]];
}

-(void) addCondition:(RateMeCondition *) condition{
    [_conditionList addObject:condition];
}

-(void) trigger:(NSString *)triggerName{
    __weak typeof(self) weakSelf = self;
    
    dispatch_async(_rateMeQueue, ^{
        [_triggerList addObject:triggerName];
        [weakSelf checkConditions];
    });
}

-(void) checkConditions{
    for(RateMeCondition *condition in _conditionList){
        if([condition checkCondition]){
            //delagate
            return;
        }
    }
}

-(void) remindMeLater{
    
}


@end
