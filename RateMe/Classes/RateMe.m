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
        _rateMeQueue = dispatch_queue_create("com.zingat.rateme", DISPATCH_QUEUE_SERIAL);
        _conditionList = [NSMutableArray<RateMeCondition *> new];
        _remindMeLaterDuration = 3; //default value is 3 days
        _delayDuration = 10; //default value is 10 seconds
        
        __weak typeof(self) weakSelf = self;
        dispatch_async(_rateMeQueue, ^{
            weakSelf.triggerList = [weakSelf.rateMeService loadTriggerList];
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
        [weakSelf.triggerList addObject:triggerName];
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
    });
}

-(void) remindMeLater{
    [self.rateMeService updateRemindMeLaterTime];
}

-(void) controlRemindMeLater{
    if(!self.delegate){
        return;
    }
    
    NSDate *date = [self.rateMeService remindMeLaterTime];
    if(!date){
        return;
    }
    
    NSTimeInterval secondsBetween = [[NSDate date] timeIntervalSinceDate:date];
    if(secondsBetween > self.remindMeLaterDuration * 86400){
        [self.delegate onRateMeTime];
    }
}


@end
