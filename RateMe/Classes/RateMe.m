//
//  RateMe.m
//  Expecta
//
//  Created by Kadir Kemal Dursun on 23/01/2018.
//

#import "RateMe.h"

@implementation RateMe{
    RateMeService *_rateMeService;
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
        _rateMeService = service;
        _rateMeQueue = dispatch_queue_create("com.zingat.rateme", DISPATCH_QUEUE_SERIAL);
        _conditionList = [NSMutableArray<RateMeCondition *> new];
        _remindMeLaterDuration = 3; //default value is 3 days
        _delayDuration = 10; //default value is 10 seconds
        
        dispatch_async(_rateMeQueue, ^{
            _triggerList = [_rateMeService loadTriggerList];
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
        [_rateMeService saveTriggerList:_triggerList];
        [weakSelf checkConditions];
    });
}

-(void) checkConditions{
    __weak typeof(self) weakSelf = self;
    
    for(RateMeCondition *condition in _conditionList){
        if([condition checkCondition:_triggerList]){
            [weakSelf waitAndCallRateMeDelegate];
            return;
        }
    }
}

-(void) waitAndCallRateMeDelegate{
    if(!_delegate){
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(_rateMeQueue, ^{
        sleep(self.delayDuration);
        [weakSelf.delegate onRateMeTime];
    });
}

-(void) remindMeLater{
    
}


@end
