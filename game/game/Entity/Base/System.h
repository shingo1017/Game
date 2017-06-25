//
//  System.h
//  destroy
//
//  Created by 尹楠 on 16/9/23.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "Entity.h"

@interface System : Entity

+ (void)setSystem:(System *)system;
+ (System *)system;

- (CGFloat)messageSpeed;

+ (void)loadSystem;

@end
