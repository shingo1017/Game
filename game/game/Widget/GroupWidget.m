//
//  GroupWidget.m
//  girl
//
//  Created by 尹楠 on 16/9/3.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "GroupWidget.h"
#import "DisplayProperty.h"
#import "DisplayPropertyWidget.h"

@implementation GroupWidget

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        [self borderStyleWithColor:WHITE_COLOR];
        [self cornerRadiusStyle];
        //groupContainerView = [[GroupContainerView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        //[self addSubview:groupContainerView];
    }
    return self;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor clearColor];
    
    //groupContainerView = [[GroupContainerView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    //[self addSubview:groupContainerView];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:[NSString stringWithFormat:@"shouldReload%@", NSStringFromClass([_group class])] object:nil];
}

- (void)setGroup:(Group *)group {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:[NSString stringWithFormat:@"shouldReload%@", NSStringFromClass([_group class])] object:nil];
    
    _group = group;
    if (_group) {
        
        [self reloadData];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:[NSString stringWithFormat:@"shouldReload%@", NSStringFromClass([_group class])] object:nil];
    }
}

- (void)reloadData {
    
    for (UIView *view in self.subviews) {
        
        [view removeFromSuperview];
    }
    
    NSArray *resultArray = [_group.displayProperties sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        NSNumber *sort1 = [NSNumber numberWithInteger:[[obj1 valueForKey:@"sort"] integerValue]];
        NSNumber *sort2 = [NSNumber numberWithInteger:[[obj2 valueForKey:@"sort"] integerValue]];
        
        NSComparisonResult result = [sort1 compare:sort2];
        
        return result == NSOrderedDescending; // 升序
    }];
    
    int i = 0;
    for (DisplayProperty *displayProperty in resultArray) {
        
        DisplayPropertyWidget *displayPropertyWidget = [[DisplayPropertyWidget alloc] initWithFrame:CGRectMake(5, 10 + i * 20, self.width - 10, 20)];
        displayPropertyWidget.displayProperty = displayProperty;
        if (![displayProperty respondsToSelector:@selector(isAvailable)] || [displayProperty isAvailable]) {
            
            [self addSubview:displayPropertyWidget];
            i++;
        }
    }
    
    if (self.subviews.count > 0)
        self.height = 10 + 20 * self.subviews.count + 10;
    else
        self.height = 0;
}

@end
