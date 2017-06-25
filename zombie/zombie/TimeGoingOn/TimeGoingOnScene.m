//
//  TimeGoingOnScene.m
//  zombie
//
//  Created by 尹楠 on 17/5/31.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "TimeGoingOnScene.h"
#import "TimeResultScene.h"
#import "TimeGoingOn.h"

static TimeGoingOnScene *_sharedTimeGoingOnScene;

@interface TimeGoingOnScene () {
    
    UILabel *_timeGoingOnLabel;
    NSTimer *_timer;
}

@end

@implementation TimeGoingOnScene

+ (TimeGoingOnScene *)sharedScene {
    
    return _sharedTimeGoingOnScene;
}

+ (void)setSharedScene:(TimeGoingOnScene *)sharedScene {
    
    _sharedTimeGoingOnScene = sharedScene;
}

- (id)init {
    
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        self.contentView.frame = CGRectMake((SCREEN_WIDTH - 200) / 2, (SCREEN_HEIGHT - 80) / 2, 200, 80);
        
        _timeGoingOnLabel = [UILabel captionWithText:@"时间进行中" fontSize:20.0f];
        _timeGoingOnLabel.frame = self.contentView.bounds;
        _timeGoingOnLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_timeGoingOnLabel];
        
        [self.dismissButton removeFromSuperview];
        [self.closeButton removeFromSuperview];
    }
    return self;
}

- (void)show {
    
    [_timeGoingOnLabel.layer addAnimation:[self opacityForever_Animation:2.0] forKey:nil];
    
    [super show];
    
    NSTimeInterval timeInterval = 2 + [PlaceScene sharedScene].place.numberOfWorkingSurvivors * 0.2f;
    
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(timerTicked) userInfo:nil repeats:NO];
}

- (CABasicAnimation *)opacityForever_Animation:(float)time {
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];//必须写opacity才行。
    animation.fromValue = [NSNumber numberWithFloat:1.0f];
    animation.toValue = [NSNumber numberWithFloat:0.0f];//这是透明度。
    animation.autoreverses = YES;
    animation.duration = time;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];///没有的话是均匀的动画。
    return animation;
}

- (void)timerTicked {
    
    [_timer invalidate];
    _timer = nil;
    
    //结算
    [[TimeGoingOn sharedInstance] Settlement];
    
    [self hide];
    
    //显示结算结果
    [[TimeResultScene new] show];
}

@end
