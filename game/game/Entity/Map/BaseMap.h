//
//  BaseMap.h
//  zombie
//
//  Created by 尹楠 on 17/6/8.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "Entity.h"

#define MapClass [Utility subClassForFatherClass:BaseMap.class]

#define k_coordinate            @"coordinate"
#define k_canNotMove            @"canNotMove"
#define k_known                 @"known"

@interface BaseMap : Entity

@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint startCoordinate;
@property (nonatomic, strong) NSDictionary *placesDictionary;

+ (BaseMap *)sharedMap;

- (Entity *)placeAtCoordinate:(CGPoint)coordinate;
- (void)setupPlace:(Entity *)place placeDictionary:(NSDictionary *)placeDictionary;

- (void)setPlace:(Entity *)place forCoordinate:(CGPoint)coordinate;
- (void)visableMap;
- (void)discoverPlaceAtCoordinate:(CGPoint)coordinate;

- (NSArray *)coordinatesDistance:(NSInteger)distance fromCoordinate:(CGPoint)coordinate;
- (NSArray *)coordinatesDistance:(NSInteger)distance fromCoordinate:(CGPoint)coordinate exceptFromCoordinate:(BOOL)except;
- (BOOL)isShorterThanDistance:(NSInteger)distance fromCoordinate:(CGPoint)fromCoordinate toCoordinate:(CGPoint)toCoordinate;

- (BOOL)fogEnabled;

@end
