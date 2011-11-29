//
//  RTSceneObject.m
//  RayTracer
//
//  Created by Williham Totland on 20111129.
//  Copyright (c) 2011 Eyego. All rights reserved.
//

#import "RTSceneObject.h"

@implementation RTSceneObject

@synthesize scale = _scale;
@synthesize translate = _translate;
@synthesize rotate = _rotate;

@dynamic bounds;

- (id)init {
  self = [super init];

  if (self) {
    _scale = RTMakeVector(1.0, 1.0, 1.0);
    _translate = RTMakeVector(0.0, 0.0, 0.0);
    _rotate = RTMakeVector(0.0, 0.0, 0.0);
  }
  
  return self;
}

- (void)scaleBy:(RTVector)v {
  self.scale = RTVectorAddition(self.scale, v);
}

- (void)translateBy:(RTVector)v {
  self.translate = RTVectorAddition(self.translate, v);
}

- (void)rotateBy:(RTVector)v {
  self.rotate = RTVectorAddition(self.rotate, v);
}

@end
