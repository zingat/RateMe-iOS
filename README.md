# AndVersion

[![CI Status](http://img.shields.io/travis/kadirkemal/RateMe.svg?style=flat)](https://travis-ci.org/kadirkemal/RateMe)
[![Version](https://img.shields.io/cocoapods/v/RateMe.svg?style=flat)](http://cocoapods.org/pods/RateMe)
[![License](https://img.shields.io/cocoapods/l/RateMe.svg?style=flat)](http://cocoapods.org/pods/RateMe)
[![Platform](https://img.shields.io/cocoapods/p/RateMe.svg?style=flat)](http://cocoapods.org/pods/RateMe)

Getting five star comments are very important for every application. RateMe helps you to track your users and warn you when the application is used by a satisfied user.

## Installation

RateMe is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```
pod 'RateMe'
```
## Thread Safety
RateMe uses GCD to avoid blocking the UI. RateMe uses a serial GCD queue to avoid race conditions.

## Usage

### Sample 1
Think that you want to warn the users who open the product detail page 4 times.

Initiaze RateMe in the AppDelegate
```objectivec
#import <RateMe/RateMe.h>

@interface ZngAppDelegate()<RateMeDelegate>
@end

@implementation ZngAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
// Override point for customization after application launch.
[[RateMe sharedInstance] addConditionWithName:@"VisitDetailPage" count:4];
[RateMe sharedInstance].delegate = self;

return YES;
}

-(void)onRateMeTime{
[SKStoreReviewController requestReview];
}

@end
```

Send trigger to RateMe in viewDidLoad of the ProductDetailViewController
```objectivec
- (void)viewDidLoad
{
[super viewDidLoad];
// Do any additional setup after loading the view, typically from a nib.

[[RateMe sharedInstance] trigger:@"VisitDetailPage"];
}
```

### Sample 2
Think that you want to warn the users who open the product detail page 4 times OR who login once.

Initiaze RateMe in the AppDelegate
```objectivec
#import <RateMe/RateMe.h>

@interface ZngAppDelegate()<RateMeDelegate>
@end

@implementation ZngAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
// Override point for customization after application launch.
[[RateMe sharedInstance] addConditionWithName:@"VisitDetailPage" count:4];
[[RateMe sharedInstance] addConditionWithName:@"Login" count:1];
[RateMe sharedInstance].delegate = self;

return YES;
}

-(void)onRateMeTime{
[SKStoreReviewController requestReview];
}

@end
```

Send trigger to RateMe in viewDidLoad of the ProductDetailViewController
```objectivec
- (void)viewDidLoad
{
[super viewDidLoad];
// Do any additional setup after loading the view, typically from a nib.

[[RateMe sharedInstance] trigger:@"VisitDetailPage"];
}
```

Send trigger to RateMe when the user loggin
```objectivec
[[RateMe sharedInstance] trigger:@"Login"];
```

You can add infinitive OR statement by using addConditionWithName or addConditionWithNameList or addCondition methods.

### Sample 4
You can use addConditionWithNameList method when the total number of some triggers reaches to wanted count.
```objectivec
#import <RateMe/RateMe.h>

@interface ZngAppDelegate()<RateMeDelegate>
@end

@implementation ZngAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
// Override point for customization after application launch.
[[RateMe sharedInstance] addConditionWithNameList:@[@"trigger1", @"trigger2"] count:5];
[RateMe sharedInstance].delegate = self;

return YES;
}

-(void)onRateMeTime{
[SKStoreReviewController requestReview];
}

@end
```
When the total number of trigger1 and trigger2 reaches to 5, onRateMe events will be called.

### Sample 5
For AND conditions you need to create your own conditions.

```objectivec

#import <RateMe/RateMe.h>

@interface ZngAppDelegate()<RateMeDelegate>
@end

@implementation ZngAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
// Override point for customization after application launch.
RateMeCondition *condition1 = [RateMeCondition rateMeConditionWithTriggerName:@"trigger1" count:3];
RateMeCondition *condition2 = [RateMeCondition rateMeConditionWithTriggerName:@"trigger2" count:4];
RateMeCondition *condition3 = [RateMeCondition rateMeConditionWithTriggerNameList:@[@"trigger3", @"trigger4" , @"trigger5"]  count:5];

RateMeCondition *andConditions = [RateMeCondition rateMeConditionWithConditionList:@[condition1, condition2, condition3]];
[[RateMe sharedInstance] addCondition:andConditions];

[RateMe sharedInstance].delegate = self;

return YES;
}

-(void)onRateMeTime{
[SKStoreReviewController requestReview];
}

@end

```

onRateMe events will be called when trigger1 is occurred 3 times, trigger2 is occured 4 times and the total occuring number of trigger3,trigger4 and trigger5 reaches to 5.


### Changing Delay Time
When trigger count reach to wanted number, RateMe waits delayDuration seconds (default is 10 seconds) and then call the onRateMeTime method. If you want to change this duration;

```objectivec
[RateMe sharedInstance].delayDuration = 5; //now delayDuration is 5 seconds
```

## Author

Zingat Mobile Team
+ Kadir Kemal Dursun, https://github.com/KadirKemal

## License

AndVersion is available under the MIT license. See the LICENSE file for more info.

