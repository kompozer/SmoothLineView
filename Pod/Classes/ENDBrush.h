//
//  ENDBrush.h
//  Pods
//
//  Created by Andreas Kompanez on 21.06.15.
//
//

#import <UIKit/UIKit.h>

@class ENDBrushShadow;



@interface ENDBrush : NSObject <NSCopying>

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) CGFloat lineWidth;
/// Per default not set
@property (nonatomic, strong) ENDBrushShadow *shadow;

@end
