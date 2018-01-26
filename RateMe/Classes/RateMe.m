//
//  RateMe.m
//  Expecta
//
//  Created by Kadir Kemal Dursun on 23/01/2018.
//

#import "RateMe.h"

@interface RateMe()

@property (strong, nonatomic) RateMeService *rateMeService;
@property (strong, nonatomic) NSCountedSet *triggerList;

@end

@implementation RateMe{
    NSMutableArray<RateMeCondition *> *_conditionList;
    dispatch_queue_t _rateMeQueue;
}

+(RateMe *) sharedInstance{
    static RateMe* _sharedInstance;
    static dispatch_once_t _token;
    
    dispatch_once(&_token, ^{
        _sharedInstance = [[RateMe alloc] initWithService:[RateMeService new]];
    });
    
    return _sharedInstance;
}

-(NSArray<RateMeCondition *> *)conditionList{
    return [_conditionList copy];
}

-(instancetype) initWithService:(RateMeService *) service{
    self = [super init];
    if(self){
        self.rateMeService = service;
        _isWorking = YES;
        _rateMeQueue = dispatch_queue_create("com.zingat.rateme", DISPATCH_QUEUE_SERIAL);
        _conditionList = [NSMutableArray<RateMeCondition *> new];
        _remindMeLaterDuration = 3; //default value is 3 days
        _delayDuration = 10; //default value is 10 seconds
        //_maximumNumberOfRateMeTimeEvent = 1;
        
        __weak typeof(self) weakSelf = self;
        dispatch_async(_rateMeQueue, ^{
            [weakSelf stopRateMeIfDone];
            weakSelf.triggerList = [weakSelf.rateMeService loadTriggerList];
            if(weakSelf.isWorking){
                [weakSelf checkConditions];
            }
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
    if(!_isWorking){
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    NSString *tName = triggerName;
    dispatch_async(_rateMeQueue, ^{
        [weakSelf.triggerList addObject:tName];
        [weakSelf.rateMeService saveTriggerList:weakSelf.triggerList];
        [weakSelf checkConditions];
    });
}

-(void) checkConditions{
    __weak typeof(self) weakSelf = self;
    
    for(RateMeCondition *condition in _conditionList){
        if([condition checkCondition:weakSelf.triggerList]){
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
        
        [weakSelf.rateMeService increaseOnRateMeTimeCounter];
        [weakSelf stopRateMeIfDone];
    });
}

-(void) stopRateMeIfDone{
    NSInteger counter = [self.rateMeService onRateMeTimeCounter];
    //if(counter >= self.maximumNumberOfRateMeTimeEvent){
    if(counter >= 1){
        _isWorking = NO;
    }
}

//-(void) remindMeLater{
//    [self.rateMeService updateRemindMeLaterTime];
//}
//
//-(void) controlRemindMeLater{
//    if(!self.delegate){
//        return;
//    }
//
//    NSDate *date = [self.rateMeService remindMeLaterTime];
//    if(!date){
//        return;
//    }
//
//    NSTimeInterval secondsBetween = [[NSDate date] timeIntervalSinceDate:date];
//    if(secondsBetween > self.remindMeLaterDuration * 86400){
//        [self.rateMeService increaseOnRateMeTimeCounter];
//        [self.rateMeService clearRemindMeLaterTime];
//        [self.delegate onRateMeTime];
//    }
//}

@end
