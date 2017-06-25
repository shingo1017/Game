//
//  AI.h
//  girl
//
//  Created by 尹楠 on 16/9/14.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "Entity.h"
#import "Action.h"

@interface AI : Entity

- (void)checkAvailable;
- (void)checkAvailableWithAction:(Action *)action;

@end
