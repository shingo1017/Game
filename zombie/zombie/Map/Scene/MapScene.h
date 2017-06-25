//
//  MapScene.h
//  zombie
//
//  Created by 尹楠 on 17/6/8.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "Scene.h"
#import "PlaceView.h"

#define c_i_placeSize 50

@interface MapScene : Scene

+ (MapScene *)sharedScene;

- (void)showWithCoordinate:(CGPoint)coordinate;

@end
