//
//  BaseAction.m
//  girl
//
//  Created by 尹楠 on 16/9/2.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "BaseAction.h"

static NSMutableArray *_sharedActions;
static NSArray *_allActions;

@implementation BaseAction

+ (NSArray *)sharedActions {
    
    if (!_sharedActions)
        _sharedActions = [[NSMutableArray alloc] init];
    
    return _sharedActions;
}

+ (CGFloat)maxWidthOfActionCell {
    
    CGFloat maxWidth = 0;
    
    for (Action *action in _sharedActions) {
        
        CGSize size = [action.name sizeWithAttributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:13] }];
        
        if (size.width > maxWidth)
            maxWidth = size.width;
    }
    
    return maxWidth + 40;
}

+ (void)appendAction:(BaseAction *)action {
    
    [_sharedActions addObject:action];
    [[NSNotificationCenter defaultCenter] postNotificationName:K_SHOULD_RELOAD_ACTION_NOTIFICATION object:nil];
}

+ (void)appendActions:(NSArray *)actions {
    
    [_sharedActions addObjectsFromArray:actions];
    [[NSNotificationCenter defaultCenter] postNotificationName:K_SHOULD_RELOAD_ACTION_NOTIFICATION object:nil];
}

+ (void)refreshActions {
    
    NSMutableArray *availableActions = [[NSMutableArray alloc] init];
    
    for (Action *level1Action in _sharedActions) {
        
        if ([level1Action isAvailable]) {
            
            if (level1Action.actions.count > 0) {
                
                //有子行动
                NSMutableArray *level2AvailableActions = [[NSMutableArray alloc] init];
                for (Action *level2Action in level1Action.actions) {
                    
                    if ([level2Action isAvailable])
                        [level2AvailableActions addObject:level2Action];
                }
                level1Action.availableActions = level2AvailableActions;
                
                //if (level1Action.actions.count > 0)
                [availableActions addObject:level1Action];
            }
            else {
                
                //无子行动
                [availableActions addObject:level1Action];
            }
        }
    }
    
    _sharedActions = availableActions;
    [[NSNotificationCenter defaultCenter] postNotificationName:K_SHOULD_RELOAD_ACTION_NOTIFICATION object:nil];
}

+ (void)applySceneActions {
    
    _sharedActions = [[NSMutableArray alloc] init];
    //[_sharedActions addObjectsFromArray:[Action availableActionInActions:[[SceneClass currentScene] property:@"actions"]]];
    //[_sharedActions addObjectsFromArray:[Action availableActionInActions:[[SceneClass currentScene] property:@"mutableActions"]]];
    [[NSNotificationCenter defaultCenter] postNotificationName:K_SHOULD_RELOAD_ACTION_NOTIFICATION object:nil];
}

+ (NSArray *)actionsBelongToClassName:(NSString *)className {
    
    NSArray *actions = [Utility getSubClassInstancesWithFatherClassName:@"Action" belongToClassName:className];
    actions = [Utility sortArray:actions];
    
    for (Action *action in actions) {
        
        NSArray *subActions = [Utility getSubClassInstancesWithFatherClassName:@"Action" belongToClassName:NSStringFromClass([action class])];
        subActions = [Utility sortArray:subActions];
        action.actions = subActions;
    }
    return [Action availableActionInActions:actions];
}

+ (void)applyStoryActions {
    
    _sharedActions = [[NSMutableArray alloc] init];
    id storySkipAction = [Utility objectForClassName:@"StorySkipAction"];
    if ([storySkipAction isAvailable])
        [_sharedActions addObject:storySkipAction];
    [[NSNotificationCenter defaultCenter] postNotificationName:K_SHOULD_RELOAD_ACTION_NOTIFICATION object:nil];
}

+ (void)clearActions {
    
    [_sharedActions removeAllObjects];
    [[NSNotificationCenter defaultCenter] postNotificationName:K_SHOULD_RELOAD_ACTION_NOTIFICATION object:nil];
}

+ (NSArray *)allActions {
    
    if (!_allActions) {
        
        NSArray *subClasses = [Utility getSubclassesWithFatherClassName:@"Action"];
        NSLog(@"%@", subClasses);
        
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (Class class in subClasses) {
            
            id obj = [[class alloc] init];
            [array addObject:obj];
        }
        _allActions = array;
    }
    
    return _allActions;
}

+ (NSArray *)availableActionInActions:(NSArray *)actions {
    
    NSMutableArray *availableActions = [[NSMutableArray alloc] init];
    
    for (Action *level1Action in actions) {
        
        if ([level1Action isAvailable]) {
            
            if (level1Action.actions.count > 0) {
                
                //有子行动
                NSMutableArray *level2AvailableActions = [[NSMutableArray alloc] init];
                for (Action *level2Action in level1Action.actions) {
                    
                    if ([level2Action isAvailable])
                        [level2AvailableActions addObject:level2Action];
                }
                level1Action.availableActions = level2AvailableActions;
                
                //if (level1Action.actions.count > 0)
                [availableActions addObject:level1Action];
            }
            else {
                
                //无子行动
                [availableActions addObject:level1Action];
            }
        }
    }
    
    return availableActions;
}

@end
