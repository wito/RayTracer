//
//  RTCamera.h
//  RayTracer
//
//  Created by Williham Totland on 20111129.
//  Copyright (c) 2011 Eyego. All rights reserved.
//

#import "RTSceneObject.h"

@class RTRay;

typedef struct {
  NSUInteger u;
  NSUInteger v;
} RTResolution;

@interface RTCamera : RTSceneObject

@property (assign) RTResolution resolution;

- (NSEnumerator *)rayEnumerator;
- (RTRay *)rayAtX:(NSUInteger)x y:(NSUInteger)y;

@end
