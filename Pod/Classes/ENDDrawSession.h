//
//  DrawSession.h
//  Smooth Line View
//
//  Created by Andreas Kompanez on 26.05.15.
//  Copyright (c) 2015 culturezoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DrawOperation;

@interface DrawSession : NSObject

@property (nonatomic, strong, readonly) DrawOperation *operation;
@property (nonatomic, copy, readonly) NSArray *operations;

- (void)beginOperation;
- (void)endOperation;

/// Has operaions YES/NO
- (BOOL)isEmpty;

- (void)removeLastOperation;

@end
