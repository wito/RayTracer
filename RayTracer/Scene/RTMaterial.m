//
//  RTMaterial.m
//  RayTracer
//
//  Created by Williham Totland on 20111130.
//  Copyright (c) 2011 Eyego. All rights reserved.
//

#import "RTMaterial.h"

@implementation RTMaterial

@synthesize specular, diffuse, shine, ambience, reflectivity;

- (id)copyWithZone:(NSZone *)zone {
  RTMaterial *retval = [[RTMaterial allocWithZone:zone] init];
  
  retval.specular = self.specular;
  retval.diffuse = self.diffuse;
  retval.ambience = self.ambience;

  retval.shine = self.shine;
  retval.reflectivity = self.reflectivity;
  
  return retval;
}

@end
