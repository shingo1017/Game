//
//  PersonView.m
//  girl
//
//  Created by 尹楠 on 16/9/3.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "PersonView.h"
#import "GroupWidget.h"

@interface PersonView () {
    
    NSArray *_groups;
    NSArray *_actions;
}

@end

@implementation PersonView

static PersonView *_sharedView;

+ (PersonView *)sharedView {
    
    return _sharedView;
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        _groups = [Utility getSubClassInstancesWithFatherClassName:@"Group" belongToClassName:NSStringFromClass([self class])];
    }
    return self;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    _groups = [Utility getSubClassInstancesWithFatherClassName:@"Group" belongToClassName:NSStringFromClass([self class])];
    
    id closeAction = [Utility objectForClassName:@"PersonViewCloseAction"];
    _actions = [NSArray arrayWithObjects:closeAction, nil];
    
    _sharedView = self;
}

- (void)setPerson:(Person *)person {
    
    _person = person;
    
    for (UIView *view in self.subviews) {
        
        [view removeFromSuperview];
    }
    
    if (_person) {
        
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

- (void)showWithPersion:(Person *)person {
    
    [MainView sharedView].messageContainerView.hidden = YES;
    [Action clearActions];
    [Action appendActions:_actions];
    
    self.right = 0;
    self.person = person;
    [UIView animateWithDuration:0.3 animations:^{
        
        self.left = 0;
        [MainView sharedView].viewMaskView.alpha = 1.0f;
    }];
    
    if (person == [Person me]) {
        
        [[MainView sharedView] hidePartnerImageWithAnimation:YES];
        [[MainView sharedView] showMyImage:@"若叶_平常" animation:YES];
    }
    else {
        
        [[MainView sharedView] hideMyImageWithAnimation:YES];
        [[MainView sharedView] showPartnerImage:@"真吾_平常" animation:YES];
    }
}

- (CGFloat)maxHeight {
    
    CGFloat maxHeight = 0;
    
    for (UIView *view in self.subviews) {
        
        if (view.bottom > maxHeight)
            maxHeight = view.bottom;
    }
    
    return maxHeight;
}

@end
