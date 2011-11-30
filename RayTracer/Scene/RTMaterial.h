//
//  RTMaterial.h
//  RayTracer
//
//  Created by Williham Totland on 20111130.
//  Copyright (c) 2011 Eyego. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTMaterial : NSObject

@property (retain) NSColor *specular;
@property (retain) NSColor *diffuse;
@property (assign) CGFloat shine;

@end
