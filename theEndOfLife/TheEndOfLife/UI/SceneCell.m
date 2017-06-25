//
//  SceneCell.m
//  theEndOfLife
//
//  Created by 尹楠 on 16/10/11.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "SceneCell.h"

@implementation SceneCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    [self borderStyleWithColor:[UIColor whiteColor]];
    [self cornerRadiusStyle];
}

@end
