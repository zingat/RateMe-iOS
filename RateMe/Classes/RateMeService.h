//
//  RateMeService.h
//  Expecta
//
//  Created by Kadir Kemal Dursun on 23/01/2018.
//

#import <Foundation/Foundation.h>

@interface RateMeService : NSObject

-(void) saveTriggerList:(NSCountedSet *) triggerList;
-(NSCountedSet *) loadTriggerList;
-(void) clearTriggerList;

-(void) updateRemindMeLaterTime;
-(NSDate *) remindMeLaterTime;
-(void) clearRemindMeLaterTime;

-(void) increaseOnRateMeTimeCounter;
-(NSInteger) onRateMeTimeCounter;

@end
