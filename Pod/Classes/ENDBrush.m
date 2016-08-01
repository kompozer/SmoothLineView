//
//  ENDBrush.m
//  Pods
//
//  Created by Andreas Kompanez on 21.06.15.
//
//

#import "ENDBrush.h"

#import "ENDBrushShadow.h"



@implementation ENDBrush

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.lineWidth = 8.0;
        self.color = [UIColor blackColor];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    ENDBrush *newBrush = [[[self class] allocWithZone:zone] init];
    newBrush.color = self.color;
    newBrush.lineWidth = self.lineWidth;
    newBrush.shadow = self.shadow;
    
    return newBrush;
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[ENDBrush class]]) {
        return NO;
    }
    
    ENDBrush *other = object;
    
    return fabs(other.lineWidth - self.lineWidth) < 0.01 &&
            [other.color isEqual:self.color] &&
            [other.shadow isEqual:self.shadow];
}

@end
