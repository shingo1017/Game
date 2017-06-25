//
//  Map.h
//  zombie
//
//  Created by 尹楠 on 17/6/8.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "BaseMap.h"

#define k_landform              @"landform"

typedef NS_ENUM(NSInteger, Landform) {
    
    LandformNone = 0,
    LandformGrass = 10,
    LandformEarth = 20,
    LandformWoods = 30,
    LandformMountain = 40,
    LandformSnowMountain = 50,
    LandformDesert = 60,
    LandformRivulet = 70,
    LandformRiver = 80,
    LandformLake = 90,
    LandformSea = 100,
    LandformField = 110,
    LandformHighway = 120,
    LandformBridge = 130,
    LandformCustom = 999,
};

@interface Map : BaseMap

+ (Map *)sharedMap;

- (Place *)placeAtCoordinate:(CGPoint)coordinate;
- (void)moveToPlace:(Place *)place;

@end

//@interface QueData : NSObject
//
//@property (nonatomic, assign) NSInteger w;
//@property (nonatomic, assign) NSInteger step;
//@property (nonatomic, assign) NSInteger state;
//@property (nonatomic, assign) NSInteger x;
//@property (nonatomic, assign) NSInteger y;
//
//@end
