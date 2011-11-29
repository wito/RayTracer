//
//  RTRay.h
//  RayTracer
//
//  Created by Williham Totland on 20111129.
//  Copyright (c) 2011 Eyego. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RTGeometry.h"

@interface RTRay : NSObject

@property (assign) RTVector start;
@property (assign) RTVector end;

@property (assign) NSUInteger x;
@property (assign) NSUInteger y;

@property (assign,readonly) RTVector direction;

- (id)initWithStart:(RTVector)s end:(RTVector)e;
- (id)initWithStart:(RTVector)s direction:(RTVector)d;

- (RTRay *)rayByTransformingByMatrix:(RTMatrix)transformation;
- (void)transformByMatrix:(RTMatrix)transformation;

- (void)lengthen:(CGFloat)factor;

@end
