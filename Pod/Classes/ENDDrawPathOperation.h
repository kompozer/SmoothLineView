//
//  ENDDrawPathOperation.h
//  Pods
//
//  Created by Andreas Kompanez on 21.06.15.
//
//

#import <Foundation/Foundation.h>

#import "ENDDrawOperation.h"



@interface ENDDrawPathOperation : NSObject <ENDDrawOperation>

@property (nonatomic, copy) UIColor *color;
@property (nonatomic, assign) CGFloat lineWidth;

- (void)addSubpath:(UIBezierPath *)subpath;


@end
