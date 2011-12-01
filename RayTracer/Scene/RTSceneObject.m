//
//  RTSceneObject.m
//  RayTracer
//
//  Created by Williham Totland on 20111129.
//  Copyright (c) 2011 Eyego. All rights reserved.
//

#import "RTSceneObject.h"
#import "RTTransform.h"

@implementation RTSceneObject

@synthesize transforms = _transforms;
@synthesize transformation = _transformation;
@dynamic inverseTransformation;

- (id)init {
  self = [super init];

  if (self) {
    _transforms = [[NSMutableArray alloc] init];
    _transformation = RTMatrixIdentity();
  }
  
  return self;
}

- (void)addTransform:(RTTransform *)t {
  [self.transforms addObject:t];
  _transformation = RTMatrixMultiply(_transformation, t.matrix);
}

/*
- (void)perspectiveBy:(RTVector)v {
  RTMatrix perpMatrix = RTMatrixIdentity();
  
  perpMatrix.d1 = v.x;
  perpMatrix.d2 = v.y;
  perpMatrix.d3 = v.z;
  
  self.transformation = RTMatrixMultiply(self.transformation, perpMatrix);
}
*/

- (CGFloat)intersectsRay:(RTRay *)ray atPoint:(RTVector *)intersection normal:(RTVector *)normal material:(RTMaterial **)material {
  return -1.0;
}

- (RTMatrix)inverseTransformation {
  return RTMatrixInvert(self.transformation);
}

@end
