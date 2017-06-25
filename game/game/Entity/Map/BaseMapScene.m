//
//  BaseMapScene.m
//  theEndOfLife
//
//  Created by 尹楠 on 16/12/21.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "BaseMapScene.h"

@interface BaseMapScene () {
    
    UIView *_fogView;
    UIScrollView *_mainScrollView;
    
    CGFloat _zoomScale;
}

@end

@implementation BaseMapScene

+ (BaseMapScene *)sharedScene {
    
    return (BaseMapScene *)[super sharedScene];
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shouldReloadNotification) name:K_SHOULD_RELOAD_MAP_NOTIFICATION object:nil];
        
        self.backgroundColor = [UIColor clearColor];
        
        _fogView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _fogView.backgroundColor = [UIColor blackColor];
        [self addSubview:_fogView];
        
        _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _mainScrollView.showsVerticalScrollIndicator = NO;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.alwaysBounceVertical = NO;
        _mainScrollView.alwaysBounceHorizontal = NO;
        _mainScrollView.bounces = NO;
        [self addSubview:_mainScrollView];
        
        _placeContainerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _placeContainerView.backgroundColor = BLACK_COLOR;
        [_mainScrollView addSubview:_placeContainerView];
        
        _zoomScale = 1.0f;
    }
    return self;
}

- (void)showWithCoordinate:(CGPoint)coordinate {
    
    CGSize mapSize = CGSizeMake([Map sharedMap].size.width * c_i_placeSize, [Map sharedMap].size.height * c_i_placeSize);
    
    _mainScrollView.contentSize = CGSizeMake(self.width + mapSize.width, self.height + mapSize.height);
    
    _placeContainerView.frame = CGRectMake(self.width / 2, self.height / 2, mapSize.width, mapSize.height);
    
    [self reloadPlaces];
    
    _mainScrollView.contentOffset = CGPointMake(coordinate.x * c_i_placeSize + c_i_placeSize / 2, coordinate.y * c_i_placeSize + c_i_placeSize / 2);
    
    [self show];
}

- (void)shouldReloadNotification {
    
    
}

@end
