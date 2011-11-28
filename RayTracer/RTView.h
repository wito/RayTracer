//
//  RTView.h
//  RayTracer
//
//  Created by Williham Totland on 11-11-28.
//  Copyright (c) 2011 Eyego. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface RTView : NSView

@property (copy) NSImage *renderBuffer;

- (IBAction)render:(id)sender;
- (IBAction)renderToFile:(id)sender;

@end
