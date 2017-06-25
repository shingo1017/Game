//
//  BaseMapScene.h
//  theEndOfLife
//
//  Created by 尹楠 on 16/12/21.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "BaseScene.h"

#define c_i_placeSize 50

@interface BaseMapScene : BaseScene

@property (nonatomic, strong) UIView *placeContainerView;

+ (BaseMapScene *)sharedScene;

- (void)showWithCoordinate:(CGPoint)coordinate;
- (void)reloadPlaces;

@end
