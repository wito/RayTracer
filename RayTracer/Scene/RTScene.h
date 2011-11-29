//
//  RTScene.h
//  RayTracer
//
//  Created by Williham Totland on 20111129.
//  Copyright (c) 2011 Eyego. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RTCamera;

@interface RTScene : NSObject

@property (readonly,retain) RTCamera *camera;
@property (readonly,retain) NSMutableArray *objects;

@end
