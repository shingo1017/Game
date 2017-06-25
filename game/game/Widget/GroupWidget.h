//
//  GroupWidget.h
//  girl
//
//  Created by 尹楠 on 16/9/3.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Group.h"
#import "GroupContainerView.h"

@interface GroupWidget : UIView {
    
    GroupContainerView *groupContainerView;
}

@property (nonatomic, strong) Group *group;

@end
