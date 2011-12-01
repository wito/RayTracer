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
    
    blueSpec.diffuse = [NSColor colorWithDeviceRed:1.0 green:0.0 blue:0.0 alpha:1.0];
    blueSpec.specular = [NSColor colorWithDeviceRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    blueSpec.ambience = [NSColor colorWithDeviceRed:0.4 green:0.5 blue:0.4 alpha:1.0];
    blueSpec.shine = 10.0;
    
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
    
    sphere = [[[RTSphere alloc] init] autorelease];
    
    [sphere addTransform:[RTTransform transformWithTranslation:RTMakeVector(0.5, 0.5, 0.0)]];
    sphere.material = blueSpec;
    
    [_objects addObject:sphere];

    RTLight *light = [[[RTLight alloc] init] autorelease];
    RTMaterial *whiteSpec = [[RTMaterial new] autorelease];
    
    whiteSpec.specular = [[NSColor colorWithDeviceWhite:1.0 alpha:1.0] colorUsingColorSpace:[NSColorSpace deviceRGBColorSpace]];
    whiteSpec.diffuse = [[NSColor colorWithDeviceWhite:0.5 alpha:1.0] colorUsingColorSpace:[NSColorSpace deviceRGBColorSpace]];
    whiteSpec.ambience = [[NSColor colorWithDeviceWhite:0.050 alpha:1.0] colorUsingColorSpace:[NSColorSpace deviceRGBColorSpace]];
    
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
  
  RTVector intersection, normal;
  RTMaterial *material;
  
  // Ambient light components
  CGFloat iar = 0.0;
  CGFloat iag = 0.0;
  CGFloat iab = 0.0;
  
  for (RTLight *light in self.lights) {
    iar += light.material.ambience.redComponent;
    iag += light.material.ambience.greenComponent;
    iab += light.material.ambience.blueComponent;
  }

  for (RTRay *ray in self.camera.rayEnumerator) {
    CGFloat bestHit = INFINITY;
    RTSceneObject *bestObject = nil;
    
    for (RTSceneObject *object in self.objects) {
      CGFloat t = [object intersectsRay:ray atPoint:NULL normal:NULL material:NULL];
      
      if (t < bestHit && t >= 0.0) {
        bestObject = object;
      }
    }
    
    if (bestObject) {
      [bestObject intersectsRay:ray atPoint:&intersection normal:&normal material:&material];
      
      CGFloat Ir = iar * material.ambience.redComponent;
      CGFloat Ig = iag * material.ambience.greenComponent;
      CGFloat Ib = iab * material.ambience.blueComponent;

      for (RTLight *light in self.lights) {
        RTVector lightLocation = RTPointMatrixMultiply(RTMakeVector(0.0, 0.0, 0.0), light.transformation);
        RTRay *lightRay = [[RTRay alloc] initWithStart:RTVectorAddition(intersection,RTVectorMultiply(normal, 0.0005)) end:lightLocation];
        
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
      
      [_renderBufferRep setColor:[NSColor colorWithDeviceRed:Ir green:Ig blue:Ib alpha:1.0] atX:ray.x y:ray.y];
    } else {
      [_renderBufferRep setColor:transparent atX:ray.x y:ray.y];
    }
  }
  
  return YES;
}

- (void)dealloc {
  [_objects release];
  [_camera release];
  [_lights release];
  
  [super dealloc];
}

@end
