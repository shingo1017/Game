//
//  Townlet.m
//  zombie
//
//  Created by 尹楠 on 17/6/8.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "Townlet.h"

static NSDictionary *_placeDictionary;

@implementation Townlet

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        self.placesDictionary = @{
                                  @"{0, 0}" : @{ @"className":@"TownHospital", k_landform:@(LandformCustom) },
                                  @"{1, 0}" : @{ @"className":@"Place", k_landform:@(LandformLake) },
                                  @"{2, 0}" : @{ @"className":@"Place", k_landform:@(LandformEarth) },
                                  @"{3, 0}" : @{ @"className":@"Place", k_landform:@(LandformEarth) },
                                  @"{4, 0}" : @{ @"className":@"Place", k_landform:@(LandformEarth) },
                                  @"{5, 0}" : @{ @"className":@"Place", k_landform:@(LandformEarth) },
                                  @"{0, 1}" : @{ @"className":@"Place", k_landform:@(LandformEarth) },
                                  @"{1, 1}" : @{ @"className":@"Place", k_landform:@(LandformLake) },
                                  @"{2, 1}" : @{ @"className":@"Place", k_landform:@(LandformEarth) },
                                  @"{3, 1}" : @{ @"className":@"Place", k_landform:@(LandformEarth) },
                                  @"{4, 1}" : @{ @"className":@"Place", k_landform:@(LandformEarth) },
                                  @"{5, 1}" : @{ @"className":@"Place", k_landform:@(LandformEarth) },
                                  @"{0, 2}" : @{ @"className":@"Place", k_landform:@(LandformHighway) },
                                  @"{1, 2}" : @{ @"className":@"Place", k_landform:@(LandformHighway) },
                                  @"{2, 2}" : @{ @"className":@"Place", k_landform:@(LandformHighway) },
                                  @"{3, 2}" : @{ @"className":@"Place", k_landform:@(LandformEarth) },
                                  @"{4, 2}" : @{ @"className":@"Place", k_landform:@(LandformEarth) },
                                  @"{5, 2}" : @{ @"className":@"Place", k_landform:@(LandformEarth) },
                                  };
    }
    return self;
}

- (CGSize)size {
    
    return CGSizeMake(6, 3);
}

- (CGPoint)startCoordinate {
    
    return CGPointMake(0, 0);
}

- (BOOL)fogEnabled {
    
    return NO;
}

@end
