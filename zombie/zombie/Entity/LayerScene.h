//
//  LayerScene.h
//  zombie
//
//  Created by 尹楠 on 17/5/21.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "Scene.h"

@interface LayerScene : Scene

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIButton *dismissButton;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, assign) CGSize contentAvailableSize;

- (void)show;
- (void)hide;

@end
