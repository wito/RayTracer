//
//  RTAppDelegate.m
//  RayTracer
//
//  Created by Williham Totland on 11-11-28.
//  Copyright (c) 2011 Eyego. All rights reserved.
//

#import "RTAppDelegate.h"
#import "RTView.h"

@implementation RTAppDelegate

@synthesize window = _window;
@synthesize renderView = _renderView;

- (void)dealloc
{
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
  // Insert code here to initialize your application
}

- (IBAction)saveDocument:(id)sender {
  NSSavePanel *savePanel = [NSSavePanel savePanel];
  
  [savePanel setAllowedFileTypes:[NSArray arrayWithObject:@"png"]];
  [savePanel setExtensionHidden:NO];
  [savePanel setCanSelectHiddenExtension:YES];
  [savePanel setNameFieldStringValue:@"render.png"];
  
  [savePanel beginSheetModalForWindow:self.window completionHandler:^(NSInteger result){
    if (result == NSOKButton) {
      NSBitmapImageRep *imageRep = [[self.renderView.renderBuffer representations] objectAtIndex:0];
      NSData *pngData = [imageRep representationUsingType:NSPNGFileType properties:nil];
      [pngData writeToURL:savePanel.URL atomically:YES];
    }
  }];
}

@end
