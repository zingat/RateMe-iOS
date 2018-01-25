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

-(void) updateRemindMeLaterTime;
-(NSDate *) remindMeLaterTime;

@end
