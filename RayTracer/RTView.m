//
//  RTView.m
//  RayTracer
//
//  Created by Williham Totland on 11-11-28.
//  Copyright (c) 2011 Eyego. All rights reserved.
//

#import "RTView.h"

@implementation RTView

@synthesize renderBuffer = _renderBuffer;

- (id)initWithFrame:(NSRect)frame {
  self = [super initWithFrame:frame];

  if (self) {
    _renderBuffer = [[NSImage alloc] initWithSize:NSMakeSize(1280.0, 720.0)];
    
    NSBitmapImageRep *_renderBufferRep = [[NSBitmapImageRep alloc] initWithBitmapDataPlanes:NULL pixelsWide:1280 pixelsHigh:720 bitsPerSample:8 samplesPerPixel:4 hasAlpha:YES isPlanar:NO colorSpaceName:NSDeviceRGBColorSpace bytesPerRow:5120 bitsPerPixel:32];
    [_renderBufferRep autorelease];
    
    [_renderBuffer addRepresentation:_renderBufferRep];
  }
  
  return self;
}

- (void)drawRect:(NSRect)dirtyRect {
  [self.renderBuffer drawInRect:dirtyRect fromRect:dirtyRect operation:NSCompositeSourceIn fraction:1.0];
}

- (IBAction)render:(id)sender {
}

- (IBAction)renderToFile:(id)sender {
}

@end
