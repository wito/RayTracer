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

@end
