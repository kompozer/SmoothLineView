//
//  ENDBrushShadow.m
//  Pods
//
//  Created by Andreas Kompanez on 21.06.15.
//
//

#import "ENDBrushShadow.h"



@implementation ENDBrushShadow

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.blur = 0.6;
        self.color = [UIColor grayColor];
        self.offset = (CGSize){0.5, 0.5};
    }
    return self;
}


@end
