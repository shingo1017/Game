//
//  BagCell.m
//  theEndOfLife
//
//  Created by 尹楠 on 16/10/11.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "BagCell.h"

@implementation BagCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    [self borderStyleWithColor:[UIColor whiteColor]];
    [self cornerRadiusStyle];
}

@end
