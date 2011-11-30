//
//  RTSceneObject.h
//  RayTracer
//
//  Created by Williham Totland on 20111129.
//  Copyright (c) 2011 Eyego. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RTGeometry.h"

@class RTRay;
@class RTMaterial;
@class RTTransform;

@interface RTSceneObject : NSObject

@property (retain,readonly) NSMutableArray *transforms;

- (CGFloat)intersectsRay:(RTRay *)ray atPoint:(RTVector *)intersection normal:(RTVector *)normal material:(RTMaterial **)material;

- (void)addTransform:(RTTransform *)t;

- (RTMatrix)transformation;
- (RTMatrix)inverseTransformation;

- (RTMatrix)transformationForNormal;
- (RTMatrix)transformationForDisplacement;

@end
