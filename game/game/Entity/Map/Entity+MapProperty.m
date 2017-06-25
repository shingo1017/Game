//
//  Entity+MapProperty.m
//  theEndOfLife
//
//  Created by 尹楠 on 16/12/21.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "Entity+MapProperty.h"
#import <objc/runtime.h>

#define k_northPlace    @"northPlace"
#define k_westPlace     @"westPlace"
#define k_southPlace    @"southPlace"
#define k_eastPlace     @"eastPlace"
//#define k_scenes        @"scenes"
//#define k_entryScene    @"entryScene"

@implementation Entity (MapProperty)

- (Entity *)northPlace {
    
    CGPoint coordinate = CGPointMake(self.coordinate.x, self.coordinate.y - 1);
    return [[MapClass sharedMap] placeAtCoordinate:coordinate];
}

- (Entity *)westPlace {
    
    CGPoint coordinate = CGPointMake(self.coordinate.x - 1, self.coordinate.y);
    return [[MapClass sharedMap] placeAtCoordinate:coordinate];
}

- (Entity *)southPlace {
    
    CGPoint coordinate = CGPointMake(self.coordinate.x, self.coordinate.y + 1);
    return [[MapClass sharedMap] placeAtCoordinate:coordinate];
}

- (Entity *)eastPlace {
    
    CGPoint coordinate = CGPointMake(self.coordinate.x + 1, self.coordinate.y);
    return [[MapClass sharedMap] placeAtCoordinate:coordinate];
}

- (NSString *)landformText {
    
    Landform landform = (Landform)[self intProperty:k_landform];
    if (landform == LandformGrass)
        return @"草地";
    else if (landform == LandformEarth)
        return @"土地";
    else if (landform == LandformWoods)
        return @"树林";
    else if (landform == LandformMountain)
        return @"山脉";
    else if (landform == LandformSnowMountain)
        return @"雪山";
    else if (landform == LandformDesert)
        return @"沙地";
    else if (landform == LandformRivulet)
        return @"小溪";
    else if (landform == LandformRiver)
        return @"河流";
    else if (landform == LandformLake)
        return @"湖泊";
    else if (landform == LandformSea)
        return @"海洋";
    else if (landform == LandformField)
        return @"田地";
    else if (landform == LandformHighway)
        return @"公路";
    else if (landform == LandformBridge)
        return @"桥梁";
    else
        return @"无";
}

- (CGPoint)coordinate {
    
    NSString *coordinateString = [self property:k_coordinate];
    return CGPointFromString(coordinateString);
}

- (void)setCoordinate:(CGPoint)coordinate {
    
    NSString *coordinateString = NSStringFromCGPoint(coordinate);
    [self setProperty:coordinateString forKey:k_coordinate];
}

@end
