//
//  RTSceneObject.m
//  RayTracer
//
//  Created by Williham Totland on 20111129.
//  Copyright (c) 2011 Eyego. All rights reserved.
//

#import "RTSceneObject.h"

@implementation RTSceneObject

@synthesize transformation = _transformation;

- (id)init {
  self = [super init];

  if (self) {
    _transformation = RTMatrixIdentity();
  }
  
  return self;
}

@end
