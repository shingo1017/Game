//
//  ShopTabCell.m
//  worldOfZombie
//
//  Created by 尹楠 on 15/2/20.
//  Copyright (c) 2015年 c2y. All rights reserved.
//

#import "ShopTabCell.h"

@implementation ShopTabCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    _flagView.width = 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
    if (selected) {
        
        if (_flagView.width == 0) {
            
            CGSize size = [_nameLabel.text sizeWithAttributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:_nameLabel.font.pointSize] }];
            _nameLabel.width = size.width;
            _nameLabel.center = self.contentView.center;
            _flagView.left = _nameLabel.center.x;
            [UIView animateWithDuration:0.3f animations:^{
                
                _flagView.width = _nameLabel.width;
                _flagView.left = _nameLabel.left;
            }];
        }
    }
    else {
        
        if (_flagView.width > 0) {
            
            _flagView.left = _nameLabel.left;
            [UIView animateWithDuration:0.3f animations:^{
                
                _flagView.width = 0;
                _flagView.left = _nameLabel.center.x;
            }];
        }
    }
}

@end
