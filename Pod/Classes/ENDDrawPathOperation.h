//
//  ENDDrawPathOperation.h
//  Pods
//
//  Created by Andreas Kompanez on 21.06.15.
//
//

#import <Foundation/Foundation.h>

#import "ENDDrawOperation.h"

@class ENDDrawPathShadow;



@interface ENDDrawPathOperation : NSObject <ENDDrawOperation>

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) CGFloat lineWidth;
/// Per default not set
@property (nonatomic, strong) ENDDrawPathShadow *shadow;

- (void)addSubpath:(UIBezierPath *)subpath;


@end



@interface ENDDrawPathShadow : NSObject

@property (nonatomic, assign) CGSize offset;
@property (nonatomic, assign) CGFloat blur;
@property (nonatomic, strong) UIColor *color;

@end
