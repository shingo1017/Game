//
//  ResourceReorganizationScene.h
//  zombie
//
//  Created by 尹楠 on 17/6/14.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "LayerScene.h"

@interface ResourceReorganizationScene : LayerScene

- (void)showForMoveWithCompletion:(void (^)(BOOL isConfirmed, NSDictionary *takeResourceDictionary))completion;

@end
