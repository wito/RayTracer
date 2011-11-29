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
@synthesize x, y;
@dynamic direction;

- (id)initWithStart:(RTVector)s end:(RTVector)e {
  self = [super init];
  
  if (self) {
    _start = s;
    _end = e;
  }
  
  return self;
}

- (id)initWithStart:(RTVector)s direction:(RTVector)d {
  return [self initWithStart:s end:RTVectorAddition(s,d)];
}

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

- (void)lengthen:(CGFloat)factor {
  self.end = RTVectorAddition(self.start, RTVectorMultiply(self.direction, factor));
}

- (NSString *)description {
  return [NSString stringWithFormat:@"%@: {%f, %f, %f}->{%f, %f, %f} ({%f, %f, %f}); x = %lu, y = %lu", [super description], self.start.x, self.start.y, self.start.z, self.end.x, self.end.y, self.end.z, self.direction.x, self.direction.y, self.direction.z, self.x, self.y];
}

@end
