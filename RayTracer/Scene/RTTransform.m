//
//  RTTransform.m
//  RayTracer
//
//  Created by Williham Totland on 11-11-30.
//  Copyright (c) 2011 Eyego. All rights reserved.
//

#import "RTTransform.h"

@interface RTTransform ()

- (id)initWithVector:(RTVector)v;

@end

@interface _RTRotateTransform : RTTransform
@end

@interface _RTScaleTransform : RTTransform
@end

@interface _RTTranslateTransform : RTTransform
@end

@implementation RTTransform

@synthesize matrix = _matrix;
@dynamic inverse;

+ (RTTransform *)transformWithRotation:(RTVector)v {
  return [[[_RTRotateTransform alloc] initWithVector:v] autorelease];
}

+ (RTTransform *)transformWithTranslation:(RTVector)v {
  return [[[_RTTranslateTransform alloc] initWithVector:v] autorelease];
}

+ (RTTransform *)transformWithScaling:(RTVector)v {
  return [[[_RTScaleTransform alloc] initWithVector:v] autorelease];
}

- (RTMatrix)inverse {
  return RTMatrixInvert(self.matrix);
}

- (id)initWithVector:(RTVector)v {
  return [super init];
}

- (RTMatrix)matrixForDisplacement {
  return self.inverse;
}

- (RTMatrix)matrixForNormal {
  return self.matrix;
}

@end

@implementation _RTScaleTransform

- (id)initWithVector:(RTVector)v {
  self = [super initWithVector:v];
  
  if (self) {
    RTMatrix scaleMatrix = RTMatrixIdentity();
    
    scaleMatrix.a1 = v.x;
    scaleMatrix.b2 = v.y;
    scaleMatrix.c3 = v.z;
    
    _matrix = scaleMatrix;
  }
  
  return self;
}

- (RTMatrix)matrixForNormal {
  return self.inverse;
}

@end

@implementation _RTTranslateTransform

- (id)initWithVector:(RTVector)v {
  self = [super initWithVector:v];
  
  if (self) {
    RTMatrix transMatrix = RTMatrixIdentity();
    
    transMatrix.a4 = v.x;
    transMatrix.b4 = v.y;
    transMatrix.c4 = v.z;
    
    _matrix = transMatrix;
  }
  
  return self;
}

- (RTMatrix)matrixForDisplacement {
  return RTMatrixIdentity();
}

- (RTMatrix)matrixForNormal {
  return self.matrixForDisplacement;
}

@end

@implementation _RTRotateTransform

- (id)initWithVector:(RTVector)v {
  self = [super initWithVector:v];

  if (self) {
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
    
    _matrix = rotMatrix;
  }

  return self;
}

@end