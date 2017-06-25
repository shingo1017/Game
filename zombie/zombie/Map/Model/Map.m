//
//  Map.m
//  zombie
//
//  Created by 尹楠 on 17/6/8.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "Map.h"

@interface Map () {
    
//    NSInteger _start;
//    NSInteger _end;
//    NSInteger _goCount;
//    NSMutableDictionary *_path;
//    NSInteger _pathTop;
//    NSMutableDictionary *_pre;
//    NSMutableDictionary *_best;
//    NSMutableDictionary *_que;
//    NSMutableDictionary *_map;
//    NSInteger _count;
}

@end

@implementation Map

//int d[4][2]={-1,0, 0,-1, 1,0, 0,1};

+ (void)initKeys {
    
    [Utility addKeys:@[k_landform]
               texts:@[@"地形"]];
}

+ (Map *)sharedMap {
    
    return (Map *)[super sharedMap];
}

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        [self setProperty:[NSString uniqueString] forKey:k_id];
    }
    return self;
}

- (Place *)placeAtCoordinate:(CGPoint)coordinate {
    
    Place *place = nil;
    
    NSMutableDictionary *coordinatesDictionary = [[NSMutableDictionary alloc] initWithDictionary:[[Game sharedGame] property:@"coordinates"]];
    
    NSString *coordinateString = NSStringFromCGPoint(coordinate);
    NSString *placeId = coordinatesDictionary[coordinateString];
    if (placeId) {
        
        place = (Place *)[Place entityWithId:placeId];
    }
    
    return place;
}

- (void)setupPlace:(Entity *)place placeDictionary:(NSDictionary *)placeDictionary {
    
    Landform landform = [placeDictionary[k_landform] integerValue];
    [place setProperty:@(landform) forKey:k_landform];
    
    if (landform != LandformCustom)
        [place setProperty:place.landformText forKey:k_name];
    
    if (landform == LandformGrass) {
        
        [place setProperty:@(random(800, 1500)) forKey:k_landArea];
        [place setProperty:@(random(0, 50)) forKey:k_zombieOutside];
    }
    else if (landform == LandformEarth) {
        
        [place setProperty:@(random(1000, 2000)) forKey:k_landArea];
        [place setProperty:@(random(10, 80)) forKey:k_zombieOutside];
    }
    else if (landform == LandformField) {
        
        [place setProperty:@(random(900, 1200)) forKey:k_landArea];
        [place setProperty:@(random(0, 20)) forKey:k_zombieOutside];
    }
    else if (landform == LandformWoods) {
        
        [place setProperty:@(random(1500, 2500)) forKey:k_landArea];
        [place setProperty:@(random(30, 120)) forKey:k_zombieOutside];
    }
    else if (landform == LandformLake) {
        
        [place setProperty:@(0) forKey:k_landArea];
        [place setProperty:@(0) forKey:k_zombieOutside];
        [place setProperty:@(YES) forKey:k_canNotMove];
    }
    else if (landform == LandformHighway) {
        
        [place setProperty:@(500) forKey:k_landArea];
        [place setProperty:@(random(0, 50)) forKey:k_zombieOutside];
    }
    
    [Place setEntity:place];
}

- (void)moveToPlace:(Place *)place {
    
    [[PlaceScene sharedScene] setProperty:@[] forKey:k_survivorIds];
    
    [[Map sharedMap] discoverPlaceAtCoordinate:place.coordinate];
    [[Game sharedGame] setProperty:place.id forKey:k_myPlaceId];
    [place setProperty:[[Team myTeam] property:k_survivorIds] forKey:k_survivorIds];
    [[PlaceScene sharedScene] showWithPlaceId:place.id];
    [[MapScene sharedScene] showWithCoordinate:place.coordinate];
}

//- (NSInteger)distanceFromCoordinate:(CGPoint)fromCoordinate toCoordinate:(CGPoint)toCoordinate {
//    
//    _path = [NSMutableDictionary new];
//    _pre = [NSMutableDictionary new];
//    _best = [NSMutableDictionary new];
//    _que = [NSMutableDictionary new];
//    _map = [NSMutableDictionary new];
//    
//    if ([self astarSearch] == 0) {
//        
//        NSLog(@"路径不存在");
//        [self newGame];
//    }
//    else {
//        
////        btnGo.hidden = YES;
//        NSLog(@"%li次", _goCount);
//        //[self movePlayer];
//    }
//    return 0;
//}

//- (void)newGame {
//    
////    btnGo.hidden = YES;
//    _goCount = 0;
//    _start = -1;
//    _end = -1;
//    _count = 0;
//    _pathTop = 0;
////    player.hidden = YES;
////    dest.hidden = YES;
////    btnChangeMap.hidden = NO;
////    for (UIView *view in [pathView subviews]) {
////        [view removeFromSuperview];
////    }
//}
//
//- (NSInteger)astarSearch {
//
//    NSInteger mapArea = [Map sharedMap].size.width * [Map sharedMap].size.height;
//    NSInteger mapHeight = [Map sharedMap].size.height;
//    
//    for (int i = 0; i < mapArea; i++) {
//        
//        _best[@(i)] = @(-1);
//    }
//
//    
//    
//    QueData *que0 = [QueData new];
//    que0.step = 0;
//    que0.state = _start;
//    que0.w = 0;
//    que0.x = _start / mapHeight;
//    que0.y = _start % mapHeight;
//    _best[@(_start)] = @(0);
//    QueData *now, *next;
//    int ph = 1;
//    int i;
//    while(ph) {
//        
//        _goCount++;
//        now = que0;
//        [self popHeapWithPa:ph--];
//        if (now.state == _end){
//            [self getPathWithState:now.state];
//            putchar('\n');
//            return 1;
//        }
//        if ([_best[@(now.state)] integerValue] != now.step) {
//            continue;
//        }
//        for(i=0; i<4; i++){
//            next.x=now.x+d[i][0];
//            next.y=now.y+d[i][1];
//            BOOL inside = [self insideWithCoordinate:CGPointMake(next.x, next.y)];
//            NSString *nextKey = [NSString stringWithFormat:@"%ld,%ld",next.x, next.y];
//            if (inside && [_map[nextKey] integerValue] == 0){
//                next.state=next.x * 20 + next.y;
//                next.step=now.step+1;
//                if ([_best[@(next.state)] integerValue] != -1 && [_best[@(next.state)] integerValue] <= next.step) {
//                    
//                    continue;
//                }
//                _best[@(next.state)] = @(next.step);
//                next.w = next.step + [self diffWithCoordinate:CGPointMake(next.x, next.y)];
//                _que[@(ph++)] = next;
//                [self pushHeapWithPa:ph];
//                _pre[@(next.state)] = @(now.state);
//            }
//        }
//    }
//    return 0;
//}
//
//- (void)pushHeapWithPa:(NSInteger)pa {
//
//    NSInteger pos = pa-1;
//    QueData *tmp = _que[@(pa-1)];
//    
//    QueData *quePos1 = _que[@((pos-1)>>1)];
//    
//    while(pos > 0 && (quePos1.w > tmp.w || (quePos1.w == tmp.w && quePos1.step > tmp.step))) {
//        
//        _que[@(pos-1)] = quePos1;
//        pos = (pos-1)>>1;
//    }
//    _que[@(pos)] = tmp;
//}
//
//- (void)popHeapWithPa:(NSInteger)pa {
//    
//    NSInteger pos=1;
//    QueData *tmp = _que[@(pa-1)];
//    
//    QueData *quePos = _que[@(pos)];
//    QueData *quePos1 = _que[@(pos+1)];
//    
//    if (pos + 1 < pa - 1 && (quePos.w > quePos1.w || (quePos.w == quePos1.w && quePos.step > quePos1.step))) {
//        
//        pos++;
//    }
//    while(pos < pa - 1 && (tmp.w > quePos.w || (tmp.w == quePos.w && tmp.step > quePos.step))) {
//        
//        _que[@((pos-1)>>1)] = quePos;
//        pos=(pos<<1)+1;
//        if (pos+1 < pa-1 && (quePos.w > quePos1.w || (quePos.w == quePos1.w && quePos.step > quePos1.step))) {
//            
//            pos++;
//        }
//    }
//    _que[@((pos-1)>>1)] = tmp;
//}
//
//- (BOOL)insideWithCoordinate:(CGPoint)coordinate {
//
//    return coordinate.x >= 0 && coordinate.x < [Map sharedMap].size.width && coordinate.y >= 0 && coordinate.y < [Map sharedMap].size.height;
//}
//
//- (NSInteger)diffWithCoordinate:(CGPoint)coordinate {
//
//    NSInteger height = [Map sharedMap].size.height;
//    return fabs(coordinate.x - _end / height) + fabs(coordinate.y - _end % height);
//}
//
//- (void)getPathWithState:(NSInteger)state {
//    
//    NSInteger height = [Map sharedMap].size.height;
//    if (state==_start) {
//    
//        _path[[NSString stringWithFormat:@"%li,0", _pathTop]] = @(state / height);
//        _pathTop++;
//        _path[[NSString stringWithFormat:@"%li,1", _pathTop]] = @(state % height);
//
//        return;
//    }
//    [self getPathWithState:[_pre[@(state)] integerValue]];
//    NSLog(@"%ld, %ld\n", state / height, state % height);
//    _path[[NSString stringWithFormat:@"%li,0", _pathTop]] = @(state / height);
//    _pathTop++;
//    _path[[NSString stringWithFormat:@"%li,1", _pathTop]] = @(state % height);
//}
//
@end
//
//@implementation QueData
//
//@end
