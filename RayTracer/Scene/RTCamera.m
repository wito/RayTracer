//
//  RTCamera.m
//  RayTracer
//
//  Created by Williham Totland on 20111129.
//  Copyright (c) 2011 Eyego. All rights reserved.
//

#import "RTCamera.h"

@interface _RTCameraRayEnumerator : NSEnumerator {
@private
  RTCamera *_camera;
  RTResolution _resolution;
  NSUInteger _u;
  NSUInteger _v;
}

+ (_RTCameraRayEnumerator *)enumeratorWithCamera:(RTCamera *)r;

@end

@implementation RTCamera

@synthesize resolution = _resolution;

- (id)init {
  self = [super init];
  
  if (self) {
    _resolution = (RTResolution){1280, 720};
    [self scaleBy:RTMakeVector(1.280, 0.720, 1.0)];
  }
  
  return self;
}

- (NSEnumerator *)rayEnumerator {
  return [_RTCameraRayEnumerator enumeratorWithCamera:self];
}

- (RTRay *)rayAtX:(NSUInteger)x y:(NSUInteger)y {
  return nil;
}

@end

@implementation _RTCameraRayEnumerator

+ (_RTCameraRayEnumerator *)enumeratorWithCamera:(RTCamera *)r {
  _RTCameraRayEnumerator *enumerator = [[[self alloc] init] autorelease];
  
  enumerator->_camera = [r retain];
  enumerator->_resolution = r.resolution;
  
  return enumerator;
}

- (id)init {
  self = [super init];

  if (self) {
    _u = 0;
    _v = 0;
  }

  return self;
}

- (void)dealloc {
  [_camera release];
  
  [super dealloc];
}

- (id)nextObject {
  if (_v == _resolution.v) {
    return nil;
  }
  
  id retval = [_camera rayAtX:_u y:_v];

  ++_u;
  
  if (_u == _resolution.u) {
    _u = 0;
    ++_v;
  }
  
  return retval;
}

@end