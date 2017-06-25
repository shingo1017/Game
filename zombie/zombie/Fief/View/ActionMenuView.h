//
//  ActionMenuView.h
//  zombie
//
//  Created by 尹楠 on 17/5/24.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LayerScene.h"

@interface ActionMenuView : UIView <UITableViewDataSource, UITableViewDelegate>

- (void)showWithActions:(NSArray *)actions atPoint:(CGPoint)point;
- (void)hide;

@end
