//
//  SceneWidget.m
//  girl
//
//  Created by 尹楠 on 16/9/3.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "SceneWidget.h"
#import "GroupWidget.h"

@implementation SceneWidget

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setScene:(Scene *)scene {
    
    _scene = scene;
    
    for (UIView *view in self.subviews) {
        
        [view removeFromSuperview];
    }
    
    if (_scene) {
        
        NSArray *resultArray = [((NSArray *)[[Scene currentScene] property:@"groups"]) sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            
            NSNumber *sort1 = [NSNumber numberWithInteger:[[obj1 valueForKey:@"sort"] integerValue]];
            NSNumber *sort2 = [NSNumber numberWithInteger:[[obj2 valueForKey:@"sort"] integerValue]];
            
            NSComparisonResult result = [sort1 compare:sort2];
            
            return result == NSOrderedDescending; // 升序
        }];
        
        int y = 0;
        for (Group *group in resultArray) {
            
            GroupWidget *groupWidget = [[GroupWidget alloc] initWithFrame:CGRectMake(0, y, self.width, 0)];
            groupWidget.backgroundColor = RGBA(0, 0, 0, 0.7);
            groupWidget.group = group;
            [self addSubview:groupWidget];
            
            y = groupWidget.bottom + 10;
        }
    }
}

- (void)fitSizeWithHeight:(CGFloat)height {
    
    
}

@end
