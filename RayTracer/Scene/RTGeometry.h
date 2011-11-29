//
//  RTGeometry.h
//  RayTracer
//
//  Created by Williham Totland on 20111129.
//  Copyright (c) 2011 Eyego. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct {
  CGFloat a1;
  CGFloat a2;
  CGFloat a3;
  CGFloat a4;
  
  CGFloat b1;
  CGFloat b2;
  CGFloat b3;
  CGFloat b4;
  
  CGFloat c1;
  CGFloat c2;
  CGFloat c3;
  CGFloat c4;
  
  CGFloat d1;
  CGFloat d2;
  CGFloat d3;
  CGFloat d4;
} RTMatrix;

RTMatrix RTMatrixIdentity(void);

RTMatrix RTMatrixCreate(CGFloat[16]);

RTMatrix RTMatrixAddition(RTMatrix, RTMatrix);
RTMatrix RTMatrixScalarMultiply(RTMatrix, CGFloat);
RTMatrix RTMatrixTranspose(RTMatrix);

RTMatrix RTMatrixMultiply(RTMatrix,RTMatrix);

CGFloat RTMatrixDeterminant(RTMatrix);
RTMatrix RTMatrixInvert(RTMatrix);

typedef struct {
  CGFloat x;
  CGFloat y;
  CGFloat z;
} RTVector;

RTVector RTMakeVector(CGFloat, CGFloat, CGFloat);

CGFloat RTVectorLength(RTVector);
RTVector RTVectorUnit(RTVector);

RTVector RTVectorAddition(RTVector,RTVector);
RTVector RTVectorSubtraction(RTVector,RTVector);
RTVector RTVectorMultiply(RTVector,CGFloat);
RTVector RTVectorDivide(RTVector,CGFloat);

RTVector RTVectorCrossProduct(RTVector,RTVector);
CGFloat RTVectorDotProduct(RTVector,RTVector);

RTVector RTVectorCProduct(RTVector,RTVector);

RTVector RTVectorMatrixMultiply(RTVector,RTMatrix);

typedef struct {
  RTVector origin;
  RTVector size;
} RTBounds;

RTBounds RTMakeBounds(CGFloat x, CGFloat y, CGFloat z, CGFloat u, CGFloat v, CGFloat w);
RTBounds RTMakeBoundsV(RTVector origin, RTVector size);
