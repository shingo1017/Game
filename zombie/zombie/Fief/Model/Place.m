//
//  Place.m
//  carManager
//
//  Created by Shingo on 13-7-22.
//  Copyright (c) 2013年 Shingo. All rights reserved.
//

#import "Place.h"
#import "Story.h"
//#import "Event.h"
#import "UIColor+Additions.h"

@implementation Place

+ (void)initKeys {
    
    [Utility addKeys:@[k_landArea, k_buildingArea, k_defence, k_trap, k_peace, k_zombieOutside, k_zombieInside, k_food, k_water, k_medicine, k_ammunition, k_material, k_nattiness, k_sanitation]
               texts:@[@"土地面积", @"建筑面积", @"防御", @"陷阱", @"治安", @"附近丧尸", @"建筑内丧尸", @"食物", @"饮用水", @"药品", @"弹药", @"建材", @"整洁", @"卫生"]];
}

+ (BOOL)allowSaveArray {
    
    return YES;
}

+ (CGFloat)burdenOfFood:(NSInteger)food {
    
    return food * 0.5;
}

+ (NSInteger)foodOfBurden:(CGFloat)burden {
    
    return floorf(burden / 0.5);
}

+ (CGFloat)burdenOfWater:(NSInteger)water {
    
    return water * 0.5;
}

+ (NSInteger)waterOfBurden:(CGFloat)burden {
    
    return floorf(burden / 0.5);
}

+ (CGFloat)burdenOfMedicine:(NSInteger)medicine {
    
    return medicine * 0.01;
}

+ (NSInteger)medicineOfBurden:(CGFloat)burden {
    
    return floorf(burden / 0.01);
}

+ (CGFloat)burdenOfAmmunition:(NSInteger)ammunition {
    
    return ammunition * 0.01;
}

+ (NSInteger)ammunitionOfBurden:(CGFloat)burden {
    
    return floorf(burden / 0.01);
}

+ (CGFloat)burdenOfMaterial:(NSInteger)material {
    
    return material * 2;
}

+ (NSInteger)materialOfBurden:(CGFloat)burden {
    
    return floorf(burden / 2);
}

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        [self setProperty:[NSString uniqueString] forKey:k_id];
        [self setProperty:@100 forKey:@"nattiness_max"];
        [self setProperty:@100 forKey:@"sanitation_max"];
    }
    return self;
}

- (NSArray *)survivors {
    
    //if (!_survivors) {
        
        NSMutableArray *survivors = [NSMutableArray new];
        for (NSString *survivorId in [self property:k_survivorIds]) {
            
            [survivors addObject:[Survivor entityWithId:survivorId]];
        }
        _survivors = survivors;
    //}
    
    return _survivors;
}

- (NSInteger)numberOfWorkingSurvivors {
    
    NSInteger numberOfSurvivors = 0;
    for (Survivor *survivor in self.survivors) {
        
        NSString *excutiveClassName = [survivor property:k_excutiveClassName];
        if (excutiveClassName.length > 0) {
            
            numberOfSurvivors++;
        }
    }
    return numberOfSurvivors;
}

- (NSInteger)numberOfSurvivorsWorkingOnExcutiveClassName:(NSString *)excutiveClassName {
    
    NSInteger numberOfSurvivors = 0;
    for (Survivor *survivor in self.survivors) {
        
        NSString *className = [survivor property:k_excutiveClassName];
        if ([className isEqualToString:excutiveClassName]) {
            
            numberOfSurvivors++;
        }
    }
    return numberOfSurvivors;
}

- (CGFloat)resourceBurden {
    
    return [Place burdenOfFood:[self intProperty:k_food]] + [Place burdenOfFood:[self intProperty:k_water]] + [Place burdenOfFood:[self intProperty:k_medicine]] + [Place burdenOfFood:[self intProperty:k_material]] + [Place burdenOfFood:[self intProperty:k_ammunition]];
}

- (CGFloat)survivorsBurden {
    
    CGFloat burden = 0;
    for (Survivor *survivor in self.survivors) {
        
        burden += survivor.burden;
    }
    return burden;
}

//- (void)setPeace:(CGFloat)peace {
//    
//    if (peace < 0)
//        _peace = 0;
//    else if (peace > 100)
//        _peace = 100;
//    else
//        _peace = peace;
//    
//    [self save];
//}

//- (UIColor *)peaceColor {
//    
//    return [UIColor colorWithValue:self.peace mid:80 low:50];
//}
//
//- (NSArray *)commands {
//    
//    if (!_commands) {
//        
//        NSMutableArray *commands = [[NSMutableArray alloc] init];
//        FMResultSet *results = [DB executeQuery:@"select id from BaseEvent where belongToClass = ? and isSystem = ?", @"Base", @(YES), nil];
//        while ([results next]) {
//            
//            Event *event = [Event baseEventWithId:[results intForColumn:@"id"]];
//            [commands addObject:event];
//        }
//        
//        _commands = commands;
//    }
//
//    return _commands;
//}
//
//- (NSArray *)events {
//    
//    if (_events) {
//        
//        NSMutableArray *events = [[NSMutableArray alloc] init];
//        FMResultSet *results = [DB executeQuery:@"select id from Event as e join BaseEvent as be on be.id = e.baseEventId where be.belongToClass = ?", @"Base", nil];
//        while ([results next]) {
//            
//            Event *event = [Event eventWithId:[results intForColumn:@"id"]];
//            [events addObject:event];
//        }
//        
//        _events = events;
//    }
//    
//    return _events;
//}
//
//#pragma mark 成员方法
//
//- (void)save {
//    
//    [super save];
//    
//    [DB executeUpdate:@"update Space set leaderId = ?, peace = ? where id = ?", @(self.leaderId), @(self.peace), @(self.id), nil];
//}
//
//- (void)addObserverForBaseProperties {
//    
//    [self addObserver:self forKeyPath:k_PEACE options:NSKeyValueObservingOptionNew context:NULL];
//}
//
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
//    
//    if ([keyPath isEqualToString:k_HOURSING_AREA]) {
//        
//        CGFloat newValue = [[change objectForKey:@"new"] floatValue];
//        [[NSNotificationCenter defaultCenter] postNotificationName:K_SHOULD_RELOAD_HOURSING_AREA_NOTIFICATION object:@(newValue)];
//    }
//    else if ([keyPath isEqualToString:k_DEFENCE]) {
//        
//        CGFloat newValue = [[change objectForKey:@"new"] floatValue];
//        [[NSNotificationCenter defaultCenter] postNotificationName:K_SHOULD_RELOAD_DEFENCE_NOTIFICATION object:@(newValue)];
//    }
//    else if ([keyPath isEqualToString:k_PEACE]) {
//        
//        CGFloat newValue = [[change objectForKey:@"new"] floatValue];
//        [[NSNotificationCenter defaultCenter] postNotificationName:K_SHOULD_RELOAD_PEACE_NOTIFICATION object:@(newValue)];
//    }
//    else if ([keyPath isEqualToString:k_NATTINESS]) {
//        
//        CGFloat newValue = [[change objectForKey:@"new"] floatValue];
//        [[NSNotificationCenter defaultCenter] postNotificationName:K_SHOULD_RELOAD_NATTINESS_NOTIFICATION object:@(newValue)];
//        [[NSNotificationCenter defaultCenter] postNotificationName:K_SHOULD_RELOAD_AVAILABLE_HOURSING_AREA_NOTIFICATION object:@(newValue)];
//    }
//    else if ([keyPath isEqualToString:k_SANITATION]) {
//        
//        CGFloat newValue = [[change objectForKey:@"new"] floatValue];
//        [[NSNotificationCenter defaultCenter] postNotificationName:K_SHOULD_RELOAD_SANITATION_NOTIFICATION object:@(newValue)];
//    }
//    else if ([keyPath isEqualToString:k_THREAT]) {
//        
//        CGFloat newValue = [[change objectForKey:@"new"] floatValue];
//        [[NSNotificationCenter defaultCenter] postNotificationName:K_SHOULD_RELOAD_THREAT_NOTIFICATION object:@(newValue)];
//    }
//}

//- (void)addBaseTimers {
//    
//    peaceTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(peaceTimerTicked:) userInfo:nil repeats:YES];
//}

//- (void)peaceTimerTicked:(NSTimer *)timer {
//    
//    if (self.survivors.count > 1) {
//        
//        self.peace -= [CalculationServiceEngine peaceDeclineWithBase:self];
//    }
//    
////    NSString *typeOfClass = @"Base";
////    if ([NSStringFromClass([self class]) isEqualToString:typeOfClass]) {
////        
////        NSString *filters = @"name == '瑞克的家' && sanitation > 30";
////        NSPredicate *p = [NSPredicate predicateWithFormat:filters];
////        if ([p evaluateWithObject:self]) {
////            
////            NSLog(@"YES");
////        }
////        else {
////            
////            NSLog(@"NO");
////        }
////    }
//}

//- (void)startTimerWithName:(NSString *)name {
//    
//    if ([name isEqualToString:k_DEFENCE]) {
//        
//        defenceTimerEnabled = YES;
//    }
//    else if ([name isEqualToString:k_PEACE]) {
//        
//        peaceTimerEnabled = YES;
//    }
//    else if ([name isEqualToString:k_NATTINESS]) {
//        
//        nattinessTimerEnabled = YES;
//    }
//    else if ([name isEqualToString:k_SANITATION]) {
//        
//        sanitationTimerEnabled = YES;
//    }
//    else if ([name isEqualToString:k_THREAT]) {
//        
//        threatTimerEnabled = YES;
//    }
//}
//
//- (void)pauseTimerWithName:(NSString *)name {
//    
//    if ([name isEqualToString:k_DEFENCE]) {
//        
//        defenceTimerEnabled = NO;
//    }
//    else if ([name isEqualToString:k_PEACE]) {
//        
//        peaceTimerEnabled = NO;
//    }
//    else if ([name isEqualToString:k_NATTINESS]) {
//        
//        nattinessTimerEnabled = NO;
//    }
//    else if ([name isEqualToString:k_SANITATION]) {
//        
//        sanitationTimerEnabled = NO;
//    }
//    else if ([name isEqualToString:k_THREAT]) {
//        
//        threatTimerEnabled = NO;
//    }
//}

#pragma mark 指令方法

//- (void)outSurvivor:(Survivor *)survivor {
//    
//    BOOL canOut = NO;
//    for (Survivor *baseSurvivor in super.survivors) {
//        
//        if (baseSurvivor == survivor) {
//            
//            canOut = YES;
//        }
//    }
//    
//    if (canOut) {
//        
//        [super.survivors removeObject:survivor];
//        [_outingSurvivors addObject:survivor];
//    }
//}
//
//- (void)returnSurvivor:(Survivor *)survivor {
//    
//    BOOL canReturn = NO;
//    for (Survivor *outingSurvivor in _outingSurvivors) {
//        
//        if (outingSurvivor == survivor) {
//            
//            canReturn = YES;
//        }
//    }
//    
//    if (canReturn) {
//        
//        [_outingSurvivors removeObject:survivor];
//        [super.survivors addObject:survivor];
//    }
//}

@end
