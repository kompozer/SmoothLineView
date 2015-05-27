//
//  ENDViewController.m
//  SmoothLineView
//
//  Created by Andreas Kompanez on 05/27/2015.
//  Copyright (c) 2014 Andreas Kompanez. All rights reserved.
//

#import "ENDViewController.h"

#import <SmoothLineView/SmoothLineView.h>
#import <PureLayout/PureLayout.h>
#import <CoreMotion/CoreMotion.h>

@interface ENDViewController ()

@property (nonatomic, strong) LVSmoothLineView *smoothLineView;

@end

@implementation ENDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.smoothLineView = [[LVSmoothLineView alloc] initForAutoLayout];
    [self.view addSubview:self.smoothLineView];
    [self.smoothLineView autoPinEdgesToSuperviewEdgesWithInsets:(ALEdgeInsets){0, 0, 0, 0}];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    [self.smoothLineView undo];
}


@end
