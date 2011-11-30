//
//  RTPrimitive.h
//  RayTracer
//
//  Created by Williham Totland on 20111129.
//  Copyright (c) 2011 Eyego. All rights reserved.
//

#import "RTSceneObject.h"

@class RTMaterial;

@interface RTPrimitive : RTSceneObject

@property (retain) RTMaterial *material;

@end
