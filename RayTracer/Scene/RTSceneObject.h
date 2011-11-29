//
//  RTSceneObject.h
//  RayTracer
//
//  Created by Williham Totland on 20111129.
//  Copyright (c) 2011 Eyego. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RTGeometry.h"

@interface RTSceneObject : NSObject

@property (assign) RTVector scale;
@property (assign) RTVector translate;
@property (assign) RTVector rotate;

- (void)scaleBy:(RTVector)v;
- (void)translateBy:(RTVector)v;
- (void)rotateBy:(RTVector)v;

@property (readonly,assign) RTBounds bounds;

@end
