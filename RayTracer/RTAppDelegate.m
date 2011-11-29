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
}

@end
