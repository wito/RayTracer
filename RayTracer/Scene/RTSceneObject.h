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

@interface RTSceneObject : NSObject

@property (assign) RTMatrix transformation;
@property (readonly) RTMatrix inverseTransformation;

- (void)scaleBy:(RTVector)v;
- (void)translateBy:(RTVector)v;
- (void)rotateBy:(RTVector)v;
- (void)perspectiveBy:(RTVector)v;

- (CGFloat)intersectsRay:(RTRay *)ray atPoint:(RTVector *)intersection normal:(RTVector *)normal;

@end
