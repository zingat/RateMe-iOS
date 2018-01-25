#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>
#import <RateMe/RateMe.h>

SpecBegin(RateMeTest)

describe(@"Add Condition Testing", ^{
    
    __block RateMe *rateMe = nil;
    beforeEach(^{
        //NSCountedSet *mockSet = OCMClassMock([NSCountedSet class]);
        RateMeService *mockService = OCMClassMock([RateMeService class]);
        OCMStub([mockService loadTriggerList]).andReturn([NSCountedSet new]);
        rateMe = [[RateMe alloc] initWithService:mockService];
    });
    
    it(@"Control adding BasicRateMeCondition", ^{
        [rateMe addConditionWithName:@"test" count:5];
        
        NSArray<RateMeCondition *> *arr = [rateMe conditionList];
        expect(arr.count).to.equal(1);
    });
    
    it(@"Control adding GroupRateMeCondition", ^{
        [rateMe addConditionWithNameList:@[@"test", @"test2"] count:5];
        
        NSArray<RateMeCondition *> *arr = [rateMe conditionList];
        expect(arr.count).to.equal(1);
    });

});

describe(@"Trigger Condition Testing", ^{
    
    __block RateMe *rateMe = nil;
    __block id<RateMeDelegate> mockDelegate = nil;
    beforeEach(^{
        //NSCountedSet *mockSet = OCMClassMock([NSCountedSet class]);
        RateMeService *mockService = OCMClassMock([RateMeService class]);
        OCMStub([mockService loadTriggerList]).andReturn([NSCountedSet new]);
        rateMe = [[RateMe alloc] initWithService:mockService];
        
        rateMe.delayDuration = 0;
        
        mockDelegate = OCMProtocolMock(@protocol(RateMeDelegate));
        rateMe.delegate = mockDelegate;
    });
    
    it(@"Control", ^{
        RateMeCondition *mockCondition = OCMClassMock([RateMeCondition class]);
        OCMStub([mockCondition checkCondition:[OCMArg any]]).andReturn(YES);
        
        [rateMe addCondition:mockCondition];
        [rateMe trigger:@"anything"];
        
        sleep(1);
        OCMVerify([rateMe.delegate onRateMeTime]);
        
        //OCMExpect([mockDelegate onRateMeTime]);
        //OCMVerifyAllWithDelay(rateMe.delegate, 1);
    });
    
});


SpecEnd
