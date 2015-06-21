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

/// The fill color
@property (nonatomic, strong) UIColor *color;

@end
