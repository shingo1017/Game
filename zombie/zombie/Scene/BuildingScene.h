//
//  BuildingOutsideScene.h
//  girl
//
//  Created by 尹楠 on 16/9/3.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "Scene.h"

@interface BuildingScene : Scene

+ (NSArray *)buildingScenes;

@end

@interface ResidenceScene : BuildingScene

@end

@interface HotelScene : BuildingScene

@end
