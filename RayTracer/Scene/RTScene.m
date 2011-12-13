//
//  RTScene.m
//  RayTracer
//
//  Created by Williham Totland on 20111129.
//  Copyright (c) 2011 Eyego. All rights reserved.
//

#import "RTScene.h"
#import "RTCamera.h"

#import "RTSphere.h"
#import "RTLight.h"
#import "RTMaterial.h"
#import "RTRay.h"
#import "RTTransform.h"

#define EPSILON 0.0005

@interface RTScene (RTScenePrivateMethods)

- (NSColor *)colorForRay:(RTRay *)ray ambientColor:(NSColor *)ambientColor fraction:(CGFloat)fraction;

@end

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

    RTSphere *sphere = [[[RTSphere alloc] init] autorelease];
    RTMaterial *blueSpec = [[RTMaterial new] autorelease];
    
    blueSpec.diffuse = [NSColor colorWithDeviceRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    blueSpec.specular = [NSColor colorWithDeviceRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    blueSpec.ambience = [NSColor colorWithDeviceRed:0.4 green:0.5 blue:0.4 alpha:1.0];
    blueSpec.shine = 10.0;
    blueSpec.reflectivity = 0.6;

    [sphere addTransform:[RTTransform transformWithTranslation:RTMakeVector(-0.5, 0.5, -0.5)]];
    [sphere addTransform:[RTTransform transformWithScaling:RTMakeVector(0.2, 0.2, 0.2)]];
    [sphere setMaterial:blueSpec];

    [_objects addObject:sphere];

    sphere = [[[RTSphere alloc] init] autorelease];
    
    [sphere addTransform:[RTTransform transformWithTranslation:RTMakeVector(-0.5, -0.5, 0.0)]];
    sphere.material = blueSpec;
    
    [_objects addObject:sphere];
        
    sphere = [[[RTSphere alloc] init] autorelease];
    
    [sphere addTransform:[RTTransform transformWithTranslation:RTMakeVector(0.5, -0.5, 0.0)]];
    sphere.material = blueSpec;
    
    [_objects addObject:sphere];
    
    RTMaterial *redSpec = [[blueSpec copy] autorelease];
    sphere = [[[RTSphere alloc] init] autorelease];
    
    redSpec.reflectivity = 0.8;
    
    [sphere addTransform:[RTTransform transformWithTranslation:RTMakeVector(0.5, 0.5, 0.0)]];
    sphere.material = redSpec;

    [_objects addObject:sphere];

    RTLight *light = [[[RTLight alloc] init] autorelease];
    RTMaterial *whiteSpec = [[RTMaterial new] autorelease];
    
    whiteSpec.specular = [[NSColor colorWithDeviceWhite:1.0 alpha:1.0] colorUsingColorSpace:[NSColorSpace deviceRGBColorSpace]];
    whiteSpec.diffuse = [[NSColor colorWithDeviceWhite:0.5 alpha:1.0] colorUsingColorSpace:[NSColorSpace deviceRGBColorSpace]];
    whiteSpec.ambience = [[NSColor colorWithDeviceWhite:0.1 alpha:1.0] colorUsingColorSpace:[NSColorSpace deviceRGBColorSpace]];
    
    light.material = whiteSpec;
    [light addTransform:[RTTransform transformWithTranslation:RTMakeVector(0.0, 5.0, -2.5)]];
    [_lights addObject:light];
    
    light = [[[RTLight alloc] init] autorelease];
    
    light.material = whiteSpec;
    [light addTransform:[RTTransform transformWithTranslation:RTMakeVector(0.0, -5.0, -2.5)]];
    [_lights addObject:light];
    
  }
  
  return self;
}

- (BOOL)renderToBitmapImageRep:(NSBitmapImageRep *)_renderBufferRep {  
  NSColor *transparent = [NSColor colorWithDeviceWhite:0.0 alpha:0.0];
  
  // Ambient light components
  CGFloat iar = 0.0;
  CGFloat iag = 0.0;
  CGFloat iab = 0.0;
  
  for (RTLight *light in self.lights) {
    iar += light.material.ambience.redComponent;
    iag += light.material.ambience.greenComponent;
    iab += light.material.ambience.blueComponent;
  }
  
  NSColor *ambientColor = [NSColor colorWithDeviceRed:iar green:iag blue:iab alpha:1.0];
  NSColor *pointColor = nil;

  for (RTRay *ray in self.camera.rayEnumerator) {
    pointColor = [self colorForRay:ray ambientColor:ambientColor fraction:1.0];
    
    if (pointColor) {
      [_renderBufferRep setColor:pointColor atX:ray.x y:ray.y];
    } else {
      [_renderBufferRep setColor:transparent atX:ray.x y:ray.y];
    }
  }
  
  return YES;
}

- (NSColor *)colorForRay:(RTRay *)ray ambientColor:(NSColor *)ambientColor fraction:(CGFloat)fraction {
  CGFloat bestHit = INFINITY;
  RTSceneObject *bestObject = nil;
  
  RTVector intersection, normal;
  RTMaterial *material;

  for (RTSceneObject *object in self.objects) {
    CGFloat t = [object intersectsRay:ray atPoint:NULL normal:NULL material:NULL];
    
    if (t < bestHit && t >= 0.0) {
      bestObject = object;
    }
  }
  
  if (bestObject) {
    [bestObject intersectsRay:ray atPoint:&intersection normal:&normal material:&material];
    
    CGFloat Ir = ambientColor.redComponent * material.ambience.redComponent;
    CGFloat Ig = ambientColor.greenComponent * material.ambience.greenComponent;
    CGFloat Ib = ambientColor.blueComponent * material.ambience.blueComponent;
    
    for (RTLight *light in self.lights) {
      RTVector lightLocation = RTPointMatrixMultiply(RTMakeVector(0.0, 0.0, 0.0), light.transformation);
      RTRay *lightRay = [[RTRay alloc] initWithStart:RTVectorAddition(intersection,RTVectorMultiply(normal, EPSILON)) end:lightLocation];
      
      CGFloat shadow = 0.0;
      
      for (RTSceneObject *object in self.objects) {
        CGFloat t = [object intersectsRay:lightRay atPoint:NULL normal:NULL material:NULL];
        
        if (t >= 0.0) {
          shadow = 10.0;
          break;
        }
      }
      
      if (shadow <= 1.0) {
        RTVector L, N, R, V;
        
        L = RTVectorUnit(lightRay.direction);
        N = normal;
        
        V = RTVectorUnit(ray.trace);
        R = RTVectorUnit(RTVectorSubtraction(RTVectorMultiply(N, 2 * RTVectorDotProduct(L,N)),L));
        
        Ir += material.diffuse.redComponent * light.material.diffuse.redComponent * RTVectorDotProduct(L, N) + material.specular.redComponent * light.material.specular.redComponent * pow(RTVectorDotProduct(R, V),material.shine);
        Ig += material.diffuse.greenComponent * light.material.diffuse.greenComponent * RTVectorDotProduct(L, N) + material.specular.greenComponent * light.material.specular.greenComponent * pow(RTVectorDotProduct(R, V),material.shine);
        Ib += material.diffuse.blueComponent * light.material.diffuse.blueComponent * RTVectorDotProduct(L, N) + material.specular.blueComponent * light.material.specular.blueComponent * pow(RTVectorDotProduct(R, V),material.shine);
      }
    }
    
    NSColor *matColor = [NSColor colorWithDeviceRed:Ir green:Ig blue:Ib alpha:1.0];
    NSColor *pointColor = nil;
    
    if (fraction * material.reflectivity > EPSILON) {
      RTVector R, V, N;
      
      N = normal;
      V = RTVectorUnit(ray.trace);
      
      R = RTVectorUnit(RTVectorSubtraction(RTVectorMultiply(N, 2 * RTVectorDotProduct(V,N)),V));
      
      CGFloat r = material.reflectivity;
      CGFloat r_i = 1.0 - material.reflectivity;
      
      RTRay *reflectionRay = [[RTRay alloc] initWithStart:RTVectorAddition(intersection, RTVectorMultiply(normal, EPSILON)) direction:R];
      
      NSColor *reflectedColor = [self colorForRay:reflectionRay ambientColor:ambientColor fraction:fraction * r];
      
      if (!reflectedColor) {
        reflectedColor = [NSColor colorWithDeviceRed:0.0 green:0.0 blue:0.0 alpha:1.0];
      }
      
      pointColor = [NSColor colorWithDeviceRed:reflectedColor.redComponent * r + matColor.redComponent * r_i
                                         green:reflectedColor.greenComponent * r + matColor.greenComponent * r_i
                                          blue:reflectedColor.blueComponent * r + matColor.blueComponent * r_i
                                         alpha:1.0];
    } else {
      pointColor = matColor;
    }
    
    return pointColor;
  } else {
    return nil;
  }
}

- (void)dealloc {
  [_objects release];
  [_camera release];
  [_lights release];
  
  [super dealloc];
}

@end
