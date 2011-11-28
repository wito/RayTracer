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

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
}

- (IBAction)render:(id)sender {
}

- (IBAction)renderToFile:(id)sender {
}

@end
