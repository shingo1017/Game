//
//  SurvivorsPickerScene.h
//  zombie
//
//  Created by 尹楠 on 17/5/26.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "LayerScene.h"

@interface SurvivorsPickerScene : LayerScene

- (void)showWithTitleKeys:(NSArray *)titleKeys completion:(void (^)(NSArray<Survivor *> *selectedSurvivors))completion;

- (void)showWithPickNumberOfSurvivors:(NSInteger)numberOfSurvivors
                            titleKeys:(NSArray *)titleKeys
                           completion:(void (^)(NSArray<Survivor *> *selectedSurvivors))completion;

- (void)showWithPickNumberOfSurvivors:(NSInteger)numberOfSurvivors
                            titleKeys:(NSArray *)titleKeys
                     placeConsumables:(NSDictionary *)placeConsumables
                  survivorConsumables:(NSDictionary *)survivorConsumables
                           completion:(void (^)(NSArray<Survivor *> *selectedSurvivors))completion;

@end
