//
//  RTSphere.m
//  RayTracer
//
//  Created by Williham Totland on 20111129.
//  Copyright (c) 2011 Eyego. All rights reserved.
//

#import "RTSphere.h"
#import "RTRay.h"

@implementation RTSphere

- (CGFloat)intersectsRay:(RTRay *)worldRay atPoint:(RTVector *)intersection normal:(RTVector *)normal material:(RTMaterial **)material {
  RTVector D_w = worldRay.direction;
  RTVector O_w = worldRay.start;
  
  RTVector D = RTVectorUnit(RTVectorMatrixMultiply(D_w, self.inverseTransformation));
  RTVector O = RTPointMatrixMultiply(O_w, self.inverseTransformation);
  
  CGFloat A, B, C;
  
  A = RTVectorDotProduct(D, D);
  B = 2 * RTVectorDotProduct(D,O);
  C = RTVectorDotProduct(O, O) - 0.25;
  
  CGFloat BB4AC = B * B - 4 * A * C;
  
  if (BB4AC < 0.0) {
    return -1.0;
  }
  
  CGFloat t0 = (-B - sqrt(BB4AC)) / 2 * A;
  CGFloat t1 = (-B + sqrt(BB4AC)) / 2 * A;
  
  if (t0 > t1) {
    CGFloat tmp = t0;
    t0 = t1;
    t1 = tmp;
  }
  
  if (t1 < 0.0) {
    return -1.0;
  }
  
  CGFloat t;
  
  if (t0 < 0.0) {
    t = t1;
  } else {
    t = t0;
  }
  
  if (material) {
    *material = self.material;
  }
  
  if (intersection) {
    RTVector isect_o = RTVectorAddition(O, RTVectorMultiply(D, t));
    
    *intersection = RTPointMatrixMultiply(isect_o, self.transformation);
    
    if (normal) {
      RTVector normal_o = RTVectorSubtraction(isect_o, RTMakeVector(0.0, 0.0, 0.0));
      RTVector normal_w = RTVectorUnit(RTVectorMatrixMultiply(normal_o, RTMatrixTranspose(self.inverseTransformation)));
      
      *normal = normal_w;
    }
  }
  
  return t;
}

@end
