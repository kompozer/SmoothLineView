//
//  ENDDrawGestureRecognizer.m
//  Pods
//
//  Created by Andreas Kompanez on 31.05.15.
//
//

#import "ENDDrawGestureRecognizer.h"

#import <UIKit/UIGestureRecognizerSubclass.h>



@interface ENDDrawGestureRecognizer ()

@property (nonatomic, strong, readwrite) NSSet *touches;

@end

@implementation ENDDrawGestureRecognizer

- (void)reset
{
    [super reset];
    self.touches = nil;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    self.touches = [NSSet setWithSet:touches];
    self.state = UIGestureRecognizerStateBegan;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    self.touches = [NSSet setWithSet:touches];
    self.state = UIGestureRecognizerStateChanged;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    self.touches = [NSSet setWithSet:touches];
    self.state = UIGestureRecognizerStateEnded;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    self.state = UIGestureRecognizerStateCancelled;
}

@end
