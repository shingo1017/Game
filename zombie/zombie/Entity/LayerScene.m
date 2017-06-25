//
//  LayerScene.m
//  zombie
//
//  Created by 尹楠 on 17/5/21.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "LayerScene.h"

@interface LayerScene ()

@end

@implementation LayerScene

- (id)init {
    
    self = [super init];
    if (self) {
        
        self.backgroundColor = RGBA(0, 0, 0, 0);
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        
        self.dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.dismissButton.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self.dismissButton addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.dismissButton];
        
        self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        self.contentView.backgroundColor = BLACK_COLOR;
        [self.contentView borderStyleWithColor:WHITE_COLOR];
        [self addSubview:self.contentView];
        
        self.closeButton = [Button buttonWithTitle:@"关闭"];
        self.closeButton.frame = CGRectMake(0, 0, 70, 30);
        [self.closeButton addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.closeButton];
    }
    return self;
}

- (CGSize)contentAvailableSize {
    
    return CGSizeMake(self.contentView.width, self.contentView.height - self.closeButton.height - c_f_padding * 2);
}

- (void)show {
    
    self.closeButton.right = self.contentView.width - c_f_padding;
    self.closeButton.bottom = self.contentView.height - c_f_padding;
    
    [super show];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.backgroundColor = RGBA(0, 0, 0, 0.7);
    }];
}

- (void)hide {
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.contentView.alpha = 0.0f;
        self.backgroundColor = RGBA(0, 0, 0, 0);
    } completion:^(BOOL finished) {
        
        [super hide];
    }];
}

@end
