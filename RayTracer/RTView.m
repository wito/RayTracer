//
//  RTView.m
//  RayTracer
//
//  Created by Williham Totland on 11-11-28.
//  Copyright (c) 2011 Eyego. All rights reserved.
//

#import "RTView.h"
#import "RTScene.h"

#import "RTSphere.h"
#import "RTCamera.h"
#import "RTRay.h"
#import "RTMaterial.h"
#import "RTLight.h"

@implementation RTView

@synthesize renderBuffer = _renderBuffer;
@synthesize scene = _scene;

- (id)initWithFrame:(NSRect)frame {
  self = [super initWithFrame:frame];

  if (self) {
    _renderBuffer = [[NSImage alloc] initWithSize:NSMakeSize(1280.0, 720.0)];
    
    NSBitmapImageRep *_renderBufferRep = [[[NSBitmapImageRep alloc] initWithBitmapDataPlanes:NULL pixelsWide:1280 pixelsHigh:720 bitsPerSample:8 samplesPerPixel:4 hasAlpha:YES isPlanar:NO colorSpaceName:NSDeviceRGBColorSpace bytesPerRow:5120 bitsPerPixel:32] autorelease];
    
    [_renderBuffer addRepresentation:_renderBufferRep];
    
    _scene = [[RTScene alloc] init];
  }
  
  return self;
}

- (void)drawRect:(NSRect)dirtyRect {
  [self.renderBuffer drawInRect:dirtyRect fromRect:dirtyRect operation:NSCompositeSourceIn fraction:1.0];
}

- (IBAction)render:(id)sender {
  RTSphere *sphere = [[[RTSphere alloc] init] autorelease];
  RTMaterial *blueSpec = [[RTMaterial new] autorelease];
  
  blueSpec.diffuse = [NSColor colorWithDeviceRed:1.0 green:0.2 blue:1.0 alpha:1.0];
  blueSpec.specular = [NSColor colorWithDeviceRed:1.0 green:1.0 blue:1.0 alpha:1.0];
  blueSpec.shine = 1.0;
  
  [sphere setMaterial:blueSpec];
  
  RTLight *light = [[[RTLight alloc] init] autorelease];
  RTMaterial *whiteSpec = [[RTMaterial new] autorelease];
  
  whiteSpec.specular = [[NSColor colorWithDeviceWhite:1.0 alpha:1.0] colorUsingColorSpace:[NSColorSpace deviceRGBColorSpace]];
  whiteSpec.diffuse = [[NSColor colorWithDeviceWhite:1.0 alpha:1.0] colorUsingColorSpace:[NSColorSpace deviceRGBColorSpace]];
  
  light.material = whiteSpec;
  light.intensity = 1.0;
  [light translateBy:RTMakeVector(5.0, 5.0, -2.5)];

  NSBitmapImageRep *_renderBufferRep = [[self.renderBuffer representations] objectAtIndex:0];

  NSColor *black = [NSColor colorWithDeviceRed:0.0 green:0.0 blue:0.0 alpha:1.0];

  RTVector intersection, normal;
  
  for (RTRay *ray in self.scene.camera.rayEnumerator) {
    CGFloat t = [sphere intersectsRay:ray atPoint:&intersection normal:&normal];
    
    if (t >= 0.0) { // hit!
      RTVector lightLocation = RTVectorMatrixMultiply(RTMakeVector(0.0, 0.0, 0.0), light.transformation);
      RTRay *lightRay = [[RTRay alloc] initWithStart:RTVectorAddition(intersection,RTVectorMultiply(normal, 0.0005)) end:lightLocation];
      
      if ([sphere intersectsRay:lightRay atPoint:NULL normal:NULL] <= 0.0) {
        RTVector L, N, R, V;
        
        L = RTVectorUnit(lightRay.direction);
        N = normal;
        
        V = RTVectorUnit(ray.trace);
        R = RTVectorUnit(RTVectorSubtraction(RTVectorMultiply(N, 2 * RTVectorDotProduct(L,N)),L));
        
        CGFloat Ir = sphere.material.diffuse.redComponent * light.material.diffuse.redComponent * RTVectorDotProduct(L, N) + sphere.material.specular.redComponent * light.material.specular.redComponent * pow(RTVectorDotProduct(R, V),sphere.material.shine);
        CGFloat Ig = sphere.material.diffuse.greenComponent * light.material.diffuse.greenComponent * RTVectorDotProduct(L, N) + sphere.material.specular.greenComponent * light.material.specular.greenComponent * pow(RTVectorDotProduct(R, V),sphere.material.shine);
        CGFloat Ib = sphere.material.diffuse.blueComponent * light.material.diffuse.blueComponent * RTVectorDotProduct(L, N) + sphere.material.specular.blueComponent * light.material.specular.blueComponent * pow(RTVectorDotProduct(R, V),sphere.material.shine);

        
        [_renderBufferRep setColor:[NSColor colorWithDeviceRed:Ir green:Ig blue:Ib alpha:1.0] atX:ray.x y:ray.y];
      } else {
        // shadow
        [_renderBufferRep setColor:black atX:ray.x y:ray.y];
      }
    }
  }

  [self setNeedsDisplay:YES];
}

- (IBAction)renderToFile:(id)sender {
  NSSavePanel *savePanel = [NSSavePanel savePanel];
  
  [savePanel setAllowedFileTypes:[NSArray arrayWithObject:@"png"]];
  [savePanel setExtensionHidden:NO];
  [savePanel setCanSelectHiddenExtension:YES];
  [savePanel setNameFieldStringValue:@"render.png"];
  
  [savePanel beginSheetModalForWindow:self.window completionHandler:^(NSInteger result){
    if (result == NSOKButton) {
      NSBitmapImageRep *imageRep = [[self.renderBuffer representations] objectAtIndex:0];
      NSData *pngData = [imageRep representationUsingType:NSPNGFileType properties:nil];
      [pngData writeToURL:savePanel.URL atomically:YES];
    }
  }];
}

@end
