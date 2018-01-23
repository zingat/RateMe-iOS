//
//  RateMe.h
//  Expecta
//
//  Created by Kadir Kemal Dursun on 23/01/2018.
//

#import <Foundation/Foundation.h>
#import "RateMeCondition.h"
#import "RateMeService.h"

@protocol RateMeDelegate<NSObject>

@end

@interface RateMe : NSObject

+(RateMe *) sharedInstance;

@property (weak) id<RateMeDelegate> delegate;
@property (nonatomic) NSInteger delayDuration;
@property (nonatomic) NSInteger remindMeLaterDuration;

-(instancetype) initWithService:(RateMeService *) service;

-(void) addConditionWithName:(NSString *)triggerName count:(int)triggerCount;
-(void) addConditionWithNameList:(NSArray<NSString *> *)triggerNameList count:(int)triggerCount;
-(void) addCondition:(RateMeCondition *) condition;

-(void) trigger:(NSString *)triggerName;

-(void) remindMeLater;

@end
