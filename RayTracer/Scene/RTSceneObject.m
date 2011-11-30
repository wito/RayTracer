//
//  RTSceneObject.m
//  RayTracer
//
//  Created by Williham Totland on 20111129.
//  Copyright (c) 2011 Eyego. All rights reserved.
//

#import "RTSceneObject.h"

@implementation RTSceneObject

@synthesize transformation = _transformation;
@dynamic inverseTransformation;

- (id)init {
  self = [super init];

  if (self) {
    _transformation = RTMatrixIdentity();
  }
  
  return self;
}

- (void)scaleBy:(RTVector)v {
  RTMatrix scaleMatrix = RTMatrixIdentity();
  
  scaleMatrix.a1 = v.x;
  scaleMatrix.b2 = v.y;
  scaleMatrix.c3 = v.z;
  
  self.transformation = RTMatrixMultiply(self.transformation, scaleMatrix);
}

- (void)translateBy:(RTVector)v {
  RTMatrix transMatrix = RTMatrixIdentity();
  
  transMatrix.a4 = v.x;
  transMatrix.b4 = v.y;
  transMatrix.c4 = v.z;
  
  self.transformation = RTMatrixMultiply(self.transformation, transMatrix);
}

- (void)rotateBy:(RTVector)v {
  RTMatrix rotMatrix = RTMatrixIdentity();
  
  rotMatrix.a1 = cos(v.y) * cos(v.z);
  rotMatrix.a2 = -cos(v.x) * sin(v.z) + sin(v.x) * sin(v.y) * cos(v.z);
  rotMatrix.a3 = sin(v.x) * sin(v.z) + cos(v.x) * sin(v.y) * sin(v.z);
  
  rotMatrix.b1 = cos(v.y) * sin(v.z);
  rotMatrix.b2 = cos(v.x) * cos(v.z) + sin(v.x) * sin(v.y) * sin(v.z);
  rotMatrix.b3 = -sin(v.x) * cos(v.z) + cos(v.x) * sin(v.y) * sin(v.z);
  
  rotMatrix.c1 = -sin(v.y);
  rotMatrix.c2 = sin(v.x) * cos(v.y);
  rotMatrix.c3 = cos(v.x) * cos(v.y);
  
  self.transformation = RTMatrixMultiply(self.transformation, rotMatrix);
}

- (void)perspectiveBy:(RTVector)v {
  RTMatrix perpMatrix = RTMatrixIdentity();
  
  perpMatrix.d1 = v.x;
  perpMatrix.d2 = v.y;
  perpMatrix.d3 = v.z;
  
  self.transformation = RTMatrixMultiply(self.transformation, perpMatrix);
}

- (CGFloat)intersectsRay:(RTRay *)ray atPoint:(RTVector *)intersection normal:(RTVector *)normal material:(RTMaterial **)material {
  return -1.0;
}

- (RTMatrix)inverseTransformation {
  return RTMatrixInvert(self.transformation);
}

@end
