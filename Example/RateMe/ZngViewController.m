//
//  ZngViewController.m
//  RateMe
//
//  Created by kadirkemal on 01/23/2018.
//  Copyright (c) 2018 kadirkemal. All rights reserved.
//

#import "ZngViewController.h"
#import <RateMe/RateMe.h>

@interface ZngViewController ()

@end

@implementation ZngViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onClickedEvent1:(id)sender {
    [[RateMe sharedInstance] trigger:@"event1"];
}

- (IBAction)onClickedEvent2:(id)sender {
    [[RateMe sharedInstance] trigger:@"event2"];
}

- (IBAction)onClickedEvent3:(id)sender {
    [[RateMe sharedInstance] trigger:@"event3"];
}

- (IBAction)onClickedEvent4:(id)sender {
    [[RateMe sharedInstance] trigger:@"event4"];
}


@end
