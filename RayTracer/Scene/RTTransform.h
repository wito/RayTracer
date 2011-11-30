//
//  RTTransform.h
//  RayTracer
//
//  Created by Williham Totland on 11-11-30.
//  Copyright (c) 2011 Eyego. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RTGeometry.h"

@interface RTTransform : NSObject {
  @protected
  RTMatrix _matrix;
}

@property (assign,readonly) RTMatrix matrix;
@property (assign,readonly) RTMatrix inverse;

+ (RTTransform *)transformWithRotation:(RTVector)v;
+ (RTTransform *)transformWithTranslation:(RTVector)v;
+ (RTTransform *)transformWithScaling:(RTVector)v;

- (RTMatrix)matrixForNormal;
- (RTMatrix)matrixForDisplacement;

@end
