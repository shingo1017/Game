//
//  MoveConfirmationScene.h
//  zombie
//
//  Created by 尹楠 on 17/6/14.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "LayerScene.h"

@interface MoveConfirmationScene : LayerScene

- (void)showWithTargetPlaceId:(NSString *)targetPlaceId completion:(void (^)(BOOL isConfirmed))completion;

@end
