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

@interface ENDViewController () <LVSmoothLineViewDelegate>

@property (nonatomic, strong) LVSmoothLineView *smoothLineView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@end

@implementation ENDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.smoothLineView = [[LVSmoothLineView alloc] initForAutoLayout];
    self.smoothLineView.delegate = self;
    [self.view addSubview:self.smoothLineView];
    
    [self.smoothLineView autoPinEdgesToSuperviewEdgesWithInsets:(ALEdgeInsets){0, 0, self.toolbar.frame.size.height, 0}];
    
    [self pickRedColor:nil];
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

- (void)smoothLineViewLongPressed:(LVSmoothLineView *)view
{
    [self.smoothLineView fillWithColor:self.smoothLineView.lineColor];
}

- (IBAction)undo:(id)sender
{
    [self.smoothLineView undo];
}

- (IBAction)redo:(id)sender
{
    [self.smoothLineView redo];
}

- (IBAction)pickRedColor:(id)sender
{
    self.smoothLineView.lineColor = [UIColor redColor];
}

- (IBAction)pickGreenColor:(id)sender
{
    self.smoothLineView.lineColor = [UIColor greenColor];
}

- (IBAction)pickBlueColor:(id)sender
{
    self.smoothLineView.lineColor = [UIColor blueColor];
}

@end
