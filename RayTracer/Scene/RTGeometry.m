//
//  RTGeometry.m
//  RayTracer
//
//  Created by Williham Totland on 20111129.
//  Copyright (c) 2011 Eyego. All rights reserved.
//

#include <math.h>

#import "RTGeometry.h"

RTMatrix RTMatrixIdentity(void) {
  return RTMatrixCreate((CGFloat[]){
    1.0, 0.0, 0.0, 0.0,
    0.0, 1.0, 0.0, 0.0,
    0.0, 0.0, 1.0, 0.0,
    0.0, 0.0, 0.0, 1.0
  });
}


RTMatrix RTMatrixCreate(CGFloat values[16]) {
  RTMatrix retval;
  
  retval.a1 = values[0];
  retval.a2 = values[1];
  retval.a3 = values[2];
  retval.a4 = values[3];
  
  retval.b1 = values[4];
  retval.b2 = values[5];
  retval.b3 = values[6];
  retval.b4 = values[7];
  
  retval.c1 = values[8];
  retval.c2 = values[9];
  retval.c3 = values[10];
  retval.c4 = values[11];
  
  retval.d1 = values[12];
  retval.d2 = values[13];
  retval.d3 = values[14];
  retval.d4 = values[15];
  
  return retval;
}


RTMatrix RTMatrixAddition(RTMatrix A, RTMatrix B) {
  RTMatrix retval;
  
  retval.a1 = A.a1 + B.a1;
  retval.a2 = A.a2 + B.a2;
  retval.a3 = A.a3 + B.a3;
  retval.a4 = A.a4 + B.a4;
  
  retval.b1 = A.b1 + B.b1;
  retval.b2 = A.b2 + B.b2;
  retval.b3 = A.b3 + B.b3;
  retval.b4 = A.b4 + B.b4;
  
  retval.c1 = A.c1 + B.c1;
  retval.c2 = A.c2 + B.c2;
  retval.c3 = A.c3 + B.c3;
  retval.c4 = A.c4 + B.c4;
  
  retval.d1 = A.d1 + B.d1;
  retval.d2 = A.d2 + B.d2;
  retval.d3 = A.d3 + B.d3;
  retval.d4 = A.d4 + B.d4;
  
  return retval;
}

RTMatrix RTMatrixScalarMultiply(RTMatrix A, CGFloat c) {
  RTMatrix retval;
  
  retval.a1 = c * A.a1;
  retval.a2 = c * A.a2;
  retval.a3 = c * A.a3;
  retval.a4 = c * A.a4;
  
  retval.b1 = c * A.b1;
  retval.b2 = c * A.b2;
  retval.b3 = c * A.b3;
  retval.b4 = c * A.b4;
  
  retval.b1 = c * A.c1;
  retval.b2 = c * A.c2;
  retval.b3 = c * A.c3;
  retval.b4 = c * A.c4;
  
  retval.b1 = c * A.d1;
  retval.b2 = c * A.d2;
  retval.b3 = c * A.d3;
  retval.b4 = c * A.d4;
  
  return retval;
}

RTMatrix RTMatrixTranspose(RTMatrix A) {
  RTMatrix retval;
  
  retval.a1 = A.a1;
  retval.a2 = A.b1;
  retval.a3 = A.c1;
  retval.a4 = A.d1;
  
  retval.b1 = A.a2;
  retval.b2 = A.b2;
  retval.b3 = A.c2;
  retval.b4 = A.d2;
  
  retval.c1 = A.a3;
  retval.c2 = A.b3;
  retval.c3 = A.c3;
  retval.c4 = A.d3;
  
  retval.d1 = A.a4;
  retval.d2 = A.b4;
  retval.d3 = A.c4;
  retval.d4 = A.d4;
  
  return retval;
}


RTMatrix RTMatrixMultiply(RTMatrix A, RTMatrix B) {
  RTMatrix retval;
  
  retval.a1 = A.a1 * B.a1 + A.a2 * B.b1 + A.a3 * B.c1 + A.a4 * B.d1;
  retval.a2 = A.a1 * B.a2 + A.a2 * B.b2 + A.a3 * B.c2 + A.a4 * B.d2;
  retval.a3 = A.a1 * B.a3 + A.a2 * B.b3 + A.a3 * B.c3 + A.a4 * B.d3;
  retval.a4 = A.a1 * B.a4 + A.a2 * B.b4 + A.a3 * B.c4 + A.a4 * B.d4;
  
  retval.b1 = A.b1 * B.a1 + A.b2 * B.b1 + A.b3 * B.c1 + A.b4 * B.d1;
  retval.b2 = A.b1 * B.a2 + A.b2 * B.b2 + A.b3 * B.c2 + A.b4 * B.d2;
  retval.b3 = A.b1 * B.a3 + A.b2 * B.b3 + A.b3 * B.c3 + A.b4 * B.d3;
  retval.b4 = A.b1 * B.a4 + A.b2 * B.b4 + A.b3 * B.c4 + A.b4 * B.d4;
  
  retval.c1 = A.c1 * B.a1 + A.c2 * B.b1 + A.c3 * B.c1 + A.c4 * B.d1;
  retval.c2 = A.c1 * B.a2 + A.c2 * B.b2 + A.c3 * B.c2 + A.c4 * B.d2;
  retval.c3 = A.c1 * B.a3 + A.c2 * B.b3 + A.c3 * B.c3 + A.c4 * B.d3;
  retval.c4 = A.c1 * B.a4 + A.c2 * B.b4 + A.c3 * B.c4 + A.c4 * B.d4;
  
  retval.d1 = A.d1 * B.a1 + A.d2 * B.b1 + A.d3 * B.c1 + A.d4 * B.d1;
  retval.d2 = A.d1 * B.a2 + A.d2 * B.b2 + A.d3 * B.c2 + A.d4 * B.d2;
  retval.d3 = A.d1 * B.a3 + A.d2 * B.b3 + A.d3 * B.c3 + A.d4 * B.d3;
  retval.d4 = A.d1 * B.a4 + A.d2 * B.b4 + A.d3 * B.c4 + A.d4 * B.d4;
  
  return retval;
}

RTVector RTMakeVector(CGFloat x, CGFloat y, CGFloat z) {
  return (RTVector){ x, y, z };
}


CGFloat RTVectorLength(RTVector self) {
  return sqrt(RTVectorDotProduct(self,self));
}

RTVector RTVectorUnit(RTVector self) {
  return RTVectorDivide(self, RTVectorLength(self));
}


RTVector RTVectorAddition(RTVector a,RTVector b) {
  return RTMakeVector(a.x + b.x, a.y + b.y, a.z + b.z);
}

RTVector RTVectorSubtraction(RTVector a, RTVector b) {
  return RTMakeVector(a.x - b.x, a.y - b.y, a.z - b.z);
}

RTVector RTVectorMultiply(RTVector self, CGFloat r) {
  return RTMakeVector(self.x * r, self.y * r, self.z * r);
}

RTVector RTVectorDivide(RTVector self, CGFloat r) {
  return RTMakeVector(self.x / r, self.y / r, self.z / r);
}


RTVector RTVectorCrossProduct(RTVector a, RTVector b) {
  return RTMakeVector(a.y * b.z - a.z * b.y, a.z * b.x - a.x * b.z, a.x * b.y - a.y * b.x);
}

CGFloat RTVectorDotProduct(RTVector a,RTVector b) {
  return a.x * b.x + a.y * b.y + a.z * b.z;
}

RTVector RTVectorCProduct(RTVector a, RTVector b) {
  return RTMakeVector(a.x * b.x, a.y * b.y, a.z * b.z);
}


RTVector RTVectorMatrixMultiply(RTVector self, RTMatrix m) {
  return RTMakeVector(
    self.x * m.a1 + self.y * m.a2 + self.z * m.a3 + m.a4,
    self.x * m.b1 + self.y * m.b2 + self.z * m.b3 + m.b4,
    self.x * m.c1 + self.y * m.c2 + self.z * m.c3 + m.c4
  );
}

RTBounds RTMakeBounds(CGFloat x, CGFloat y, CGFloat z, CGFloat u, CGFloat v, CGFloat w) {
  return RTMakeBoundsV(RTMakeVector(x, y, z),RTMakeVector(u, v, w));
}

RTBounds RTMakeBoundsV(RTVector origin, RTVector size) {
  return (RTBounds){origin,size};
}
