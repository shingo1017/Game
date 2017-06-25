//
//  GroupContainerView.m
//  worldOfZombie
//
//  Created by 尹楠 on 15/6/23.
//  Copyright (c) 2015年 c2y. All rights reserved.
//

#import "GroupContainerView.h"

@interface GroupContainerView ()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UILabel *groupNameLabel;

@end

@implementation GroupContainerView

- (void)setFrame:(CGRect)frame {
    
    [super setFrame:frame];
    
    _containerView.height = frame.size.height;
}

- (void)createContainerView {
    
    if (!_containerView) {
        
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.size.width, self.size.height)];
        [_containerView cornerRadiusStyle];
        [_containerView borderStyleWithColor:GROUP_CONTAINER_BORDER_COLOR];
        _containerView.backgroundColor = RGBA(0, 0, 0, 0.7);
        [self insertSubview:_containerView atIndex:0];
    }
}

- (UILabel *)groupNameLabel {
    
    if (!_groupNameLabel) {
        
        _groupNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 0.0f, 0.0f, 0.0f)];
        _groupNameLabel.backgroundColor = BLACK_COLOR;
        _groupNameLabel.textColor = GROUP_CONTAINER_BORDER_COLOR;
        _groupNameLabel.textAlignment = NSTextAlignmentCenter;
        _groupNameLabel.font = [UIFont systemFontOfSize:13.0f];
        [self insertSubview:_groupNameLabel atIndex:1];
    }
    
    return _groupNameLabel;
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        [self createContainerView];
        
        _containerView.top = 0;
    }
    return self;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor clearColor];
    
    [self createContainerView];
}

- (void)setGroupName:(NSString *)groupName {
    
    _groupName = groupName;
    
    self.groupNameLabel.text = _groupName;
    [self.groupNameLabel sizeToFit];
    self.groupNameLabel.width += 15.0f;
}

@end
