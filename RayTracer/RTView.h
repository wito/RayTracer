//
//  RTView.h
//  RayTracer
//
//  Created by Williham Totland on 11-11-28.
//  Copyright (c) 2011 Eyego. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class RTScene;

@interface RTView : NSView

@property (copy) NSImage *renderBuffer;
@property (retain) RTScene *scene;

- (IBAction)render:(id)sender;
- (IBAction)renderToFile:(id)sender;

@end
