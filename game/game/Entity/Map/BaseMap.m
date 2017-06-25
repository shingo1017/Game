//
//  BaseMap.m
//  zombie
//
//  Created by 尹楠 on 17/6/8.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "BaseMap.h"

static BaseMap *_sharedMap;

@implementation BaseMap

+ (void)initKeys {
    
    [Utility addKeys:@[k_coordinate, k_canNotMove, k_known]
               texts:@[@"坐标", @"不能移动", @"认知"]];
}

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.

    }
    return self;
}

+ (BaseMap *)sharedMap {
    
    if (!_sharedMap) {
        
        NSString *defaultMapClass = [[GameClass sharedGame] property:@"defaultMapClass"];
        _sharedMap = [Utility objectForClassName:defaultMapClass];
    }
    
    return _sharedMap;
}

- (Entity *)placeAtCoordinate:(CGPoint)coordinate {
    
    Entity *place = nil;
    
    NSMutableDictionary *coordinatesDictionary = [[NSMutableDictionary alloc] initWithDictionary:[[GameClass sharedGame] property:@"coordinates"]];
    
    NSString *coordinateString = NSStringFromCGPoint(coordinate);
    NSString *placeId = coordinatesDictionary[coordinateString];
    if (placeId) {
        
        place = [Entity entityWithId:placeId];
    }
    
    return place;
}

- (void)setupPlace:(Entity *)place placeDictionary:(NSDictionary *)placeDictionary {
    
    
}

- (void)setPlace:(Entity *)place forCoordinate:(CGPoint)coordinate {
    
    NSMutableDictionary *coordinatesDictionary = [[NSMutableDictionary alloc] initWithDictionary:[[GameClass sharedGame] property:@"coordinates"]];
    
    NSString *key = NSStringFromCGPoint(coordinate);
    coordinatesDictionary[key] = place.id;
    [[GameClass sharedGame] setProperty:coordinatesDictionary forKey:@"coordinates"];
}

- (void)visableMap {
    
    NSMutableArray *coordinates = [NSMutableArray new];
    CGSize mapSize = [Map sharedMap].size;
    for (int x = 0; x < mapSize.width; x++) {
        
        for (int y = 0; y < mapSize.height; y++) {
            
            [coordinates addObject:NSStringFromCGPoint(CGPointMake(x, y))];
        }
    }
    
    NSMutableDictionary *coordinatesDictionary = [[NSMutableDictionary alloc] initWithDictionary:[[GameClass sharedGame] property:@"coordinates"]];
    for (NSString *coordinateString in coordinates) {
        
        NSString *placeId = coordinatesDictionary[coordinateString];
        if (!placeId) {
            
            NSString *className = [Map sharedMap].placesDictionary[coordinateString][@"className"];
            Entity *place = [Utility objectForClassName:className];
            [place setProperty:coordinateString forKey:k_coordinate];
            [self setupPlace:place placeDictionary:self.placesDictionary[coordinateString]];
            [Entity setEntity:place];
            coordinatesDictionary[coordinateString] = place.id;
        }
    }
    
    [[GameClass sharedGame] setProperty:coordinatesDictionary forKey:@"coordinates"];
}

- (void)discoverPlaceAtCoordinate:(CGPoint)coordinate {
    
    NSMutableArray *coordinates = [NSMutableArray new];
    [coordinates addObjectsFromArray:[self coordinatesDistance:1 fromCoordinate:coordinate exceptFromCoordinate:NO]];
    
    NSMutableDictionary *coordinatesDictionary = [[NSMutableDictionary alloc] initWithDictionary:[[GameClass sharedGame] property:@"coordinates"]];
    for (NSString *coordinateString in coordinates) {
        
        NSString *placeId = coordinatesDictionary[coordinateString];
        if (!placeId) {
            
            NSString *className = [Map sharedMap].placesDictionary[coordinateString][@"className"];
            Entity *place = [Utility objectForClassName:className];
            [place setProperty:coordinateString forKey:k_coordinate];
            [place setProperty:@YES forKey:k_known];
            [self setupPlace:place placeDictionary:self.placesDictionary[coordinateString]];
            coordinatesDictionary[coordinateString] = place.id;
        }
        else {
            
            Entity *place = [Entity entityWithId:placeId];
            [place setProperty:@YES forKey:k_known];
        }
    }
    
    [[GameClass sharedGame] setProperty:coordinatesDictionary forKey:@"coordinates"];
}

- (NSArray *)coordinatesDistance:(NSInteger)distance fromCoordinate:(CGPoint)coordinate {
    
    return [self coordinatesDistance:distance fromCoordinate:coordinate exceptFromCoordinate:YES];
}

- (NSArray *)coordinatesDistance:(NSInteger)distance fromCoordinate:(CGPoint)coordinate exceptFromCoordinate:(BOOL)except {
    
    NSMutableArray *coordinates = [NSMutableArray new];
    CGSize mapSize = [Map sharedMap].size;
    
    for (int offsetX = -(int)distance; offsetX <= distance; offsetX++) {
        
        NSInteger x = coordinate.x + offsetX;
        if (x >= 0 && x < mapSize.width) {
            
            for (int offsetY = -(int)distance; offsetY <= distance; offsetY++) {
                
                NSInteger y = coordinate.y + offsetY;
                if (y >= 0 && y < mapSize.height && abs(offsetX) + abs(offsetY) <= distance) {
                    
                    if (!(except && offsetX == 0 && offsetY == 0)) {
                        
                        [coordinates addObject:NSStringFromCGPoint(CGPointMake(x, y))];
                    }
                }
            }
        }
    }
    
    return coordinates;
}

- (BOOL)isShorterThanDistance:(NSInteger)distance fromCoordinate:(CGPoint)fromCoordinate toCoordinate:(CGPoint)toCoordinate {
    
    NSInteger offsetX = fabs(toCoordinate.x - fromCoordinate.x);
    NSInteger offsetY = fabs(toCoordinate.y - fromCoordinate.y);
    if (offsetX + offsetY <= distance)
        return YES;
    else
        return NO;
}

- (BOOL)fogEnabled {
    
    return YES;
}

@end
