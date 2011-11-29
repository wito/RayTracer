//
//  RTScene.m
//  RayTracer
//
//  Created by Williham Totland on 20111129.
//  Copyright (c) 2011 Eyego. All rights reserved.
//

#import "RTScene.h"

@implementation RTScene

@synthesize objects = _objects;

- (id)init {
  self = [super init];
  
  if (self) {
    _objects = [[NSMutableArray alloc] init];
  }
  
  return self;
}

- (void)dealloc {
  [_objects release];
  
  [super dealloc];
}

@end
