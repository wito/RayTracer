//
//  RTMaterial.h
//  RayTracer
//
//  Created by Williham Totland on 20111130.
//  Copyright (c) 2011 Eyego. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTMaterial : NSObject <NSCopying>

@property (retain) NSColor *specular;
@property (retain) NSColor *diffuse;
@property (retain) NSColor *ambience;
@property (assign) CGFloat shine;
@property (assign) CGFloat reflectivity;

@end
