//
//  RTRay.m
//  RayTracer
//
//  Created by Williham Totland on 20111129.
//  Copyright (c) 2011 Eyego. All rights reserved.
//

#import "RTRay.h"

@implementation RTRay

@synthesize start = _start, end = _end;
@dynamic direction;

- (RTVector)direction {
  return RTVectorSubtraction(self.end, self.start);
}

- (void)transformByMatrix:(RTMatrix)transformation {
  self.start = RTVectorMatrixMultiply(self.start, transformation);
  self.end = RTVectorMatrixMultiply(self.end, transformation);
}

- (RTRay *)rayByTransformingByMatrix:(RTMatrix)transformation {
  RTRay *ray = [[[RTRay alloc] init] autorelease];
  
  ray.start = RTVectorMatrixMultiply(self.start, transformation);
  ray.end = RTVectorMatrixMultiply(self.end, transformation);
  
  return ray;
}

@end
