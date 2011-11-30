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

- (id)init {
  self = [super init];

  if (self) {
    _transforms = [[NSMutableArray alloc] init];
  }
  
  return self;
}

- (void)addTransform:(RTTransform *)t {
  [self.transforms addObject:t];
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

- (RTMatrix)transformation {
  RTMatrix retval = RTMatrixIdentity();
  
  for (RTTransform *transform in [self.transforms objectEnumerator]) {
    retval = RTMatrixMultiply(retval, transform.matrix);
  }
  
  return retval;
}

- (RTMatrix)inverseTransformation {
  RTMatrix retval = RTMatrixIdentity();
  
  for (RTTransform *transform in [self.transforms reverseObjectEnumerator]) {
    retval = RTMatrixMultiply(retval, transform.inverse);
  }
  
  return retval;
}

- (RTMatrix)transformationForNormal {
  RTMatrix retval = RTMatrixIdentity();
  
  for (RTTransform *transform in [self.transforms objectEnumerator]) {
    retval = RTMatrixMultiply(retval, transform.matrixForNormal);
  }
  
  return retval;
}

- (RTMatrix)transformationForDisplacement {
  RTMatrix retval = RTMatrixIdentity();
  
  for (RTTransform *transform in [self.transforms reverseObjectEnumerator]) {
    retval = RTMatrixMultiply(retval, transform.matrixForDisplacement);
  }
  
  return retval;
}

@end
