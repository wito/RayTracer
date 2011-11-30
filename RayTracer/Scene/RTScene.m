//
//  RTScene.m
//  RayTracer
//
//  Created by Williham Totland on 20111129.
//  Copyright (c) 2011 Eyego. All rights reserved.
//

#import "RTScene.h"
#import "RTCamera.h"

@implementation RTScene

@synthesize objects = _objects;
@synthesize camera = _camera;
@synthesize lights = _lights;

- (id)init {
  self = [super init];
  
  if (self) {
    _objects = [[NSMutableArray alloc] init];
    _camera = [RTCamera new];
    _lights = [[NSMutableArray alloc] init];
  }
  
  return self;
}

- (void)dealloc {
  [_objects release];
  [_camera release];
  [_lights release];
  
  [super dealloc];
}

@end
