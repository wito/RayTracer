//
//  RTPlane.m
//  RayTracer
//
//  Created by Williham Totland on 20111213.
//  Copyright (c) 2011 Eyego. All rights reserved.
//

#import "RTPlane.h"
#import "RTRay.h"

@implementation RTPlane

- (CGFloat)intersectsRay:(RTRay *)worldRay atPoint:(RTVector *)intersection normal:(RTVector *)normal material:(RTMaterial **)material {
  RTVector D_w = worldRay.direction;
  RTVector O_w = worldRay.start;
  
  RTVector D = RTVectorUnit(RTVectorMatrixMultiply(D_w, self.inverseTransformation));
  RTVector O = RTPointMatrixMultiply(O_w, self.inverseTransformation);
  
  RTVector N = RTMakeVector(0.0, 1.0, 0.0);
  RTVector Q = RTMakeVector(0.0, 5.0, 0.0);
  
  CGFloat n = RTVectorDotProduct(N, RTVectorSubtraction(Q, O));
  CGFloat d = RTVectorDotProduct(O, D);
  
  if (d == 0.0) {
    return -1.0;
  }
  
  CGFloat t = n / d;
    
  if (t < 0.0) {
    return -1.0;
  }
  
  if (material) {
    *material = self.material;
  }
  
  if (intersection) {
    RTVector isect_o = RTVectorAddition(O, RTVectorMultiply(D, t));
    
    *intersection = RTPointMatrixMultiply(isect_o, self.transformation);
    
    if (normal) {
      RTVector normal_o = N;
      RTVector normal_w = RTVectorUnit(RTVectorMatrixMultiply(normal_o, RTMatrixTranspose(self.inverseTransformation)));
      
      *normal = normal_w;
    }
  }
  
  return t;
}

@end
