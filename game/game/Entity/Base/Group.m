//
//  Group.m
//  girl
//
//  Created by 尹楠 on 16/9/3.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "Group.h"

static NSMutableDictionary *_groups;

@implementation Group

+ (void)setGroup:(Group *)group forClassName:(NSString *)className {
    
    _groups[className] = group;
}

+ (Group *)groupForClassName:(NSString *)className {
    
    return _groups[className];
}

- (void)initialization {
    
    
}

- (NSArray *)displayProperties {
    
    if (!_displayProperties) {
        
        NSArray *resultArray = [_displayProperties sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            
            NSNumber *sort1 = [NSNumber numberWithInteger:[[obj1 valueForKey:@"sort"] integerValue]];
            NSNumber *sort2 = [NSNumber numberWithInteger:[[obj2 valueForKey:@"sort"] integerValue]];
            
            NSComparisonResult result = [sort1 compare:sort2];
            
            return result == NSOrderedDescending; // 升序
        }];
        
        NSMutableArray *displayProperties = [NSMutableArray new];
        for (DisplayProperty *displayProperty in resultArray) {
            
            if ([displayProperty isAvailable])
                [displayProperties addObject:displayProperty];
        }
        
        _displayProperties = displayProperties;
    }
    
    [Group setGroup:self forClassName:NSStringFromClass(self.class)];
 
    return _displayProperties;
}

@end
