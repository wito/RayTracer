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
  RTRay *objectRay = [worldRay rayByTransformingByMatrix:self.inverseTransformation];
  
  // NSLog(@"\n%@\n%@", worldRay, objectRay);
  
  RTVector D = objectRay.direction;
  RTVector O = objectRay.start;
  
  CGFloat A, B, C;
  
  A = RTVectorDotProduct(D, D);
  B = 2 * RTVectorDotProduct(D,O);
  C = RTVectorDotProduct(O, O) - 0.25;
  
  CGFloat BB4AC = sqrt(B * B - 4 * A * C);
  
  if (BB4AC < 0.0) {
    return -1.0;
  }
  
  CGFloat t0 = (-B - BB4AC) / 2 * A;
  CGFloat t1 = (-B + BB4AC) / 2 * A;
  
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
    [objectRay lengthen:t];
    
    RTVector isect_o = objectRay.end;
    
    *intersection = RTVectorMatrixMultiply(isect_o, self.transformation);
    
    if (normal) {
      *normal = RTVectorUnit(RTVectorMatrixMultiply(RTVectorUnit(RTVectorSubtraction(isect_o, RTMakeVector(0.0, 0.0, 0.0))), self.transformation));
    }
  }
  
  return t;
}

@end
