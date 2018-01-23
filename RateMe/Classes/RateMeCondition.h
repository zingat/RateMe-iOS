//
//  RateMeCondition.h
//  Expecta
//
//  Created by Kadir Kemal Dursun on 23/01/2018.
//

#import <Foundation/Foundation.h>

@interface RateMeCondition : NSObject

+(RateMeCondition *) rateMeConditionWithTriggerName:(NSString *)triggerName count:(NSInteger) count;
+(RateMeCondition *) rateMeConditionWithTriggerNameList:(NSArray<NSString *> *)triggerNameList count:(NSInteger) count;
+(RateMeCondition *) rateMeConditionWithConditionList:(NSArray<RateMeCondition *> *)conditionList;

-(instancetype) initWithTriggerName:(NSString *)triggerName count:(NSInteger) count;
-(instancetype) initWithTriggerNameList:(NSArray<NSString *> *)triggerNameList count:(NSInteger) count;
-(instancetype) initWithConditionList:(NSArray<RateMeCondition *> *)conditionList;

-(BOOL) checkCondition;

@end
