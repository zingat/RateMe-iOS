#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>
#import <RateMe/RateMeCondition.h>

SpecBegin(RateMeConditionTest)

describe(@"BasicRateMeCondition Checking Testing", ^{
    NSString *triggerName = @"test";
    NSString *notRelatedTriggerName = @"not-related";

    RateMeCondition *condition = [RateMeCondition rateMeConditionWithTriggerName:triggerName count:2];

    it(@"return NO when triggerList is nil", ^{
        expect([condition checkCondition:nil]).to.equal(NO);
    });

    it(@"return NO when triggerList is empty", ^{
        expect([condition checkCondition:[NSCountedSet new]]).to.equal(NO);
    });

    it(@"return NO when triggerList contains trigger but the count is lower", ^{
        expect([condition checkCondition:[NSCountedSet setWithArray:@[triggerName]]]).to.equal(NO);
    });
    
    it(@"return NO when triggerList contains trigger but the count is lower with not related triggers", ^{
        expect([condition checkCondition:[NSCountedSet setWithArray:@[triggerName, notRelatedTriggerName, notRelatedTriggerName]]]).to.equal(NO);
    });

    it(@"return YES when triggerList contains trigger but the count is ok", ^{
        expect([condition checkCondition:[NSCountedSet setWithArray:@[triggerName, triggerName]]]).to.equal(YES);
    });

    it(@"return NO when triggerList contains trigger but the count is higher", ^{
        expect([condition checkCondition:[NSCountedSet setWithArray:@[triggerName, triggerName, triggerName]]]).to.equal(NO);
    });

});


describe(@"GroupRateMeCondition Checking Testing For All Same Condition", ^{
    NSString *triggerName1 = @"test1";
    NSString *triggerName2 = @"test2";
    NSString *triggerName3 = @"test3";
    NSString *notRelatedTriggerName = @"not-related";
    
    RateMeCondition *condition = [RateMeCondition rateMeConditionWithTriggerNameList:@[triggerName1, triggerName2, triggerName3] count:2];
    
    it(@"return NO when triggerList is nil", ^{
        expect([condition checkCondition:nil]).to.equal(NO);
    });
    
    it(@"return NO when triggerList is empty", ^{
        expect([condition checkCondition:[NSCountedSet new]]).to.equal(NO);
    });
    
    it(@"return NO when triggerList contains trigger but the count is lower", ^{
        expect([condition checkCondition:[NSCountedSet setWithArray:@[triggerName1]]]).to.equal(NO);
    });
    
    it(@"return NO when triggerList contains trigger but the count is lower with not related triggers", ^{
        expect([condition checkCondition:[NSCountedSet setWithArray:@[triggerName1, notRelatedTriggerName, notRelatedTriggerName]]]).to.equal(NO);
    });
    
    it(@"return YES when triggerList contains trigger but the count is ok", ^{
        expect([condition checkCondition:[NSCountedSet setWithArray:@[triggerName1, triggerName1]]]).to.equal(YES);
    });
    
    it(@"return NO when triggerList contains trigger but the count is higher", ^{
        expect([condition checkCondition:[NSCountedSet setWithArray:@[triggerName1, triggerName1, triggerName1]]]).to.equal(NO);
    });
    
});


describe(@"GroupRateMeCondition Checking Testing For two condition", ^{
    NSString *triggerName1 = @"test1";
    NSString *triggerName2 = @"test2";
    NSString *triggerName3 = @"test3";
    NSString *notRelatedTriggerName = @"not-related";
    
    RateMeCondition *condition = [RateMeCondition rateMeConditionWithTriggerNameList:@[triggerName1, triggerName2, triggerName3] count:3];
    
    it(@"return NO when triggerList contains trigger but the count is lower", ^{
        expect([condition checkCondition:[NSCountedSet setWithArray:@[triggerName1, triggerName2]]]).to.equal(NO);
    });
    
    it(@"return NO when triggerList contains trigger but the count is lower with not related triggers", ^{
        expect([condition checkCondition:[NSCountedSet setWithArray:@[triggerName1, triggerName2, notRelatedTriggerName, notRelatedTriggerName]]]).to.equal(NO);
    });
    
    it(@"return YES when triggerList contains trigger but the count is ok", ^{
        expect([condition checkCondition:[NSCountedSet setWithArray:@[triggerName1, triggerName2, triggerName1]]]).to.equal(YES);
    });
    
    it(@"return NO when triggerList contains trigger but the count is higher", ^{
        expect([condition checkCondition:[NSCountedSet setWithArray:@[triggerName1, triggerName2, triggerName1, triggerName1]]]).to.equal(NO);
    });
    
});


describe(@"GroupRateMeCondition Checking Testing For three condition", ^{
    NSString *triggerName1 = @"test1";
    NSString *triggerName2 = @"test2";
    NSString *triggerName3 = @"test3";
    NSString *notRelatedTriggerName = @"not-related";
    
    RateMeCondition *condition = [RateMeCondition rateMeConditionWithTriggerNameList:@[triggerName1, triggerName2, triggerName3] count:4];
    
    it(@"return NO when triggerList contains trigger but the count is lower", ^{
        expect([condition checkCondition:[NSCountedSet setWithArray:@[triggerName1, triggerName2, triggerName3]]]).to.equal(NO);
    });
    
    it(@"return NO when triggerList contains trigger but the count is lower with not related triggers", ^{
        expect([condition checkCondition:[NSCountedSet setWithArray:@[triggerName1, triggerName2, triggerName3, notRelatedTriggerName, notRelatedTriggerName]]]).to.equal(NO);
    });
    
    it(@"return YES when triggerList contains trigger but the count is ok", ^{
        expect([condition checkCondition:[NSCountedSet setWithArray:@[triggerName3, triggerName1, triggerName2, triggerName1]]]).to.equal(YES);
    });
    
    it(@"return NO when triggerList contains trigger but the count is higher", ^{
        expect([condition checkCondition:[NSCountedSet setWithArray:@[triggerName3, triggerName1, triggerName2, triggerName1, triggerName1]]]).to.equal(NO);
    });
    
});


describe(@"AddRateMeCondition Checking Testing", ^{
    
    RateMeCondition *condition1 = OCMClassMock([RateMeCondition class]);
    OCMStub([condition1 checkCondition:[OCMArg any]]).andReturn(NO);
    
    RateMeCondition *condition2 = OCMClassMock([RateMeCondition class]);
    OCMStub([condition2 checkCondition:[OCMArg any]]).andReturn(NO);
    
    RateMeCondition *condition3 = OCMClassMock([RateMeCondition class]);
    OCMStub([condition3 checkCondition:[OCMArg any]]).andReturn(YES);
    
    RateMeCondition *condition4 = OCMClassMock([RateMeCondition class]);
    OCMStub([condition4 checkCondition:[OCMArg any]]).andReturn(YES);
    
    it(@"return NO when has only only one NO condition", ^{
        expect([[RateMeCondition rateMeConditionWithConditionList:@[condition1]] checkCondition:[NSCountedSet new]]).to.equal(NO);
    });
    
    it(@"return NO when has two NO condition", ^{
        expect([[RateMeCondition rateMeConditionWithConditionList:@[condition1, condition2]] checkCondition:[NSCountedSet new]]).to.equal(NO);
    });
    
    it(@"return NO when has two NO condition & one YES condition", ^{
        expect([[RateMeCondition rateMeConditionWithConditionList:@[condition3 ,condition1, condition2]] checkCondition:[NSCountedSet new]]).to.equal(NO);
        expect([[RateMeCondition rateMeConditionWithConditionList:@[condition1 ,condition3, condition2]] checkCondition:[NSCountedSet new]]).to.equal(NO);
        expect([[RateMeCondition rateMeConditionWithConditionList:@[condition1 ,condition1, condition3]] checkCondition:[NSCountedSet new]]).to.equal(NO);
    });
    
    it(@"return YES when has only only one YES condition", ^{
        expect([[RateMeCondition rateMeConditionWithConditionList:@[condition3]] checkCondition:[NSCountedSet new]]).to.equal(YES);
    });
    
    it(@"return YES when has two YES condition", ^{
        expect([[RateMeCondition rateMeConditionWithConditionList:@[condition3, condition4]] checkCondition:[NSCountedSet new]]).to.equal(YES);
    });
    
    it(@"return NO when has one NO condition & two YES condition", ^{
        expect([[RateMeCondition rateMeConditionWithConditionList:@[condition3 ,condition4, condition2]] checkCondition:[NSCountedSet new]]).to.equal(NO);
        expect([[RateMeCondition rateMeConditionWithConditionList:@[condition1 ,condition3, condition4]] checkCondition:[NSCountedSet new]]).to.equal(NO);
        expect([[RateMeCondition rateMeConditionWithConditionList:@[condition4 ,condition3, condition1]] checkCondition:[NSCountedSet new]]).to.equal(NO);
    });
    
    it(@"return NO when has two NO condition & two YES condition", ^{
        expect([[RateMeCondition rateMeConditionWithConditionList:@[condition3 ,condition4, condition2, condition1]] checkCondition:[NSCountedSet new]]).to.equal(NO);
        expect([[RateMeCondition rateMeConditionWithConditionList:@[condition1 ,condition3, condition2, condition4]] checkCondition:[NSCountedSet new]]).to.equal(NO);
        expect([[RateMeCondition rateMeConditionWithConditionList:@[condition4 ,condition2, condition3, condition1]] checkCondition:[NSCountedSet new]]).to.equal(NO);
    });
});

SpecEnd
