//
//  EquipmentCollectionCell.m
//  worldOfZombie
//
//  Created by 尹楠 on 15/2/20.
//  Copyright (c) 2015年 c2y. All rights reserved.
//

#import "EquipmentCollectionCell.h"

@implementation EquipmentCollectionCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
}

- (void)setItem:(Item *)item {
    
    _item = item;
    
    if (_item) {
        
        captionLabel.text = _item.equipOnText;
        [nameButton setTitle:_item.name forState:UIControlStateNormal];
    }
}

@end
