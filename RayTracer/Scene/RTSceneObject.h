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
@property (assign,readonly) RTMatrix transformation;
@property (assign,readonly) RTMatrix inverseTransformation;

- (CGFloat)intersectsRay:(RTRay *)ray atPoint:(RTVector *)intersection normal:(RTVector *)normal material:(RTMaterial **)material;

- (void)addTransform:(RTTransform *)t;

@end
