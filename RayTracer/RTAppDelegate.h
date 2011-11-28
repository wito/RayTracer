//
//  RTAppDelegate.h
//  RayTracer
//
//  Created by Williham Totland on 11-11-28.
//  Copyright (c) 2011 Eyego. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class RTView;

@interface RTAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet RTView *renderView;

- (IBAction)saveDocument:(id)sender;

@end
