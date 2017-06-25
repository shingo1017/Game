//
//  SceneSpaceView.m
//  worldOfZombie
//
//  Created by 尹楠 on 15/6/29.
//  Copyright (c) 2015年 c2y. All rights reserved.
//

#import "SceneSpaceView.h"

@implementation SceneSpaceView

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    baseView = (BaseView *)[UIView viewWithName:@"BaseView"];
    baseView.frame = CGRectMake(0, 0, self.width, self.height - 40);
    baseView.alpha = 1.0f;
    [self addSubview:baseView];
    
    survivorsView = (SurvivorsView *)[UIView viewWithName:@"SurvivorsView"];
    survivorsView.frame = CGRectMake(0, 0, self.width, self.height - 40);
    survivorsView.alpha = 0.0f;
    [self addSubview:survivorsView];
    
//    itemsView = (ItemsView *)[UIView viewWithName:@"ItemsView"];
//    itemsView.frame = CGRectMake(0, 0, self.width, self.height - 40);
//    itemsView.alpha = 0.0f;
//    [self addSubview:itemsView];
}

- (IBAction)baseViewButtonClicked:(id)sender {
    
    [self viewSwitch:baseView];
}

- (IBAction)survivorsViewButtonClicked:(id)sender {
    
    [self viewSwitch:survivorsView];
}

- (IBAction)itemsViewButtonClicked:(id)sender {
    
//    [self viewSwitch:itemsView];
}

- (IBAction)settingViewButtonClicked:(id)sender {
    
    
}

- (void)viewSwitch:(UIView *)view {
    
    baseView.alpha = 0.0f;
    survivorsView.alpha = 0.0f;
//    itemsView.alpha = 0.0f;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    view.alpha = 1.0f;
    [UIView commitAnimations];
}

@end
