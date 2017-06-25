//
//  Breast.h
//  girl
//
//  Created by 尹楠 on 16/9/2.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "Part.h"

@interface Breast : Part

@property (nonatomic, assign) NSInteger tactility;
@property (nonatomic, assign) NSInteger sensitive;

+ (Part *)randomPart;

- (void)initialization;

@end
