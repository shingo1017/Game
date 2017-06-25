//
//  Hair.h
//  girl
//
//  Created by 尹楠 on 16/9/2.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "Part.h"

@interface Hair : Part

@property (nonatomic, assign) NSInteger color;
@property (nonatomic, assign) NSInteger tactility;

+ (Part *)randomPart;
- (void)initialization;

@end
