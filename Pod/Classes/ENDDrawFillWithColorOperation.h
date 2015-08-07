//
//  ENDDrawFillWithColorOperation.h
//  Pods
//
//  Created by Andreas Kompanez on 21.06.15.
//
//

#import <Foundation/Foundation.h>

#import "ENDDrawOperation.h"



@interface ENDDrawFillWithColorOperation : NSObject <ENDDrawOperation>

@property (nonatomic, assign) CGRect fillRect;

/// The fill color
@property (nonatomic, strong) UIColor *color;

@end
