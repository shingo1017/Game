//
//  ItemView.m
//  girl
//
//  Created by 尹楠 on 16/9/3.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "ItemView.h"
#import "GroupWidget.h"

@interface ItemView () {
    
    NSArray *_groups;
    //NSArray *_actions;
}

@end

@implementation ItemView

static ItemView *_sharedView;

+ (ItemView *)sharedView {
    
    return _sharedView;
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        _groups = [Utility getSubClassInstancesWithFatherClassName:@"Group" belongToClassName:NSStringFromClass([self class])];
        _sharedView = self;
    }
    return self;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    _sharedView = self;
}

- (void)setItem:(Item *)item {
    
    _item = item;
    
    for (UIView *view in self.subviews) {
        
        [view removeFromSuperview];
    }
    
    if (_item) {
        
        Group *group = [Utility objectForClassName:[_item property:@"infoGroupClassName"]];
        _groups = [NSArray arrayWithObject:group];
        
        NSArray *resultArray = [_groups sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            
            NSNumber *sort1 = [NSNumber numberWithInteger:[[obj1 valueForKey:@"sort"] integerValue]];
            NSNumber *sort2 = [NSNumber numberWithInteger:[[obj2 valueForKey:@"sort"] integerValue]];
            
            NSComparisonResult result = [sort1 compare:sort2];
            
            return result == NSOrderedDescending; // 升序
        }];
        
        int y = 10;
        for (Group *group in resultArray) {
            
            GroupWidget *groupWidget = [[GroupWidget alloc] initWithFrame:CGRectMake(10, y, self.width - 20, 0)];
            groupWidget.group = group;
            [self addSubview:groupWidget];
            
            y = groupWidget.bottom + 10;
        }
    }
}

- (void)showWithItem:(Item *)item {
    
    //[[Game sharedGame] setProperty:itemKey forKey:@"currentItemKey" save:NO];
    [Item setCurrentItem:item];
    self.item = [Item currentItem];

    [MainView sharedView].messageContainerView.hidden = YES;
    
    [UIView animateWithDuration:0.1 animations:^{
        
        self.left = SCREEN_WIDTH;
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.1 animations:^{
            
            self.right = SCREEN_WIDTH;
            [MainView sharedView].sceneWidget.alpha = 0.0f;
            [MainView sharedView].viewMaskView.alpha = 1.0f;
        }];
    }];
    
    [[MainView sharedView] hideMyImageWithAnimation:YES];
    [[MainView sharedView] hidePartnerImageWithAnimation:YES];
}

- (void)close {
    
    [UIView animateWithDuration:0.1 animations:^{
        
        self.left = SCREEN_WIDTH;;
    }];
}

- (CGFloat)maxHeight {
    
    CGFloat maxHeight = 0;
    
    for (UIView *view in self.subviews) {
        
        if (view.bottom > maxHeight)
            maxHeight = view.bottom;
    }
    
    return maxHeight;
}

- (void)shouldCloseItemView {
    
    
}

@end
