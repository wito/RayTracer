//
//  RTView.m
//  RayTracer
//
//  Created by Williham Totland on 11-11-28.
//  Copyright (c) 2011 Eyego. All rights reserved.
//

#import "RTView.h"
#import "RTScene.h"

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
  NSBitmapImageRep *_renderBufferRep = [[self.renderBuffer representations] objectAtIndex:0];
  [self.scene renderToBitmapImageRep:_renderBufferRep];

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
