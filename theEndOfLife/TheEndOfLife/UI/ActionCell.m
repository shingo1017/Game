//
//  ActionCell.m
//  worldOfZombie
//
//  Created by 尹楠 on 15/2/20.
//  Copyright (c) 2015年 c2y. All rights reserved.
//

#import "ActionCell.h"

@implementation ActionCell

- (void)awakeFromNib {
    // Initialization code
    
    [flagView roundWidthStyle];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setAction:(Action *)action level:(NSInteger)level children:(NSInteger)children {
    
    _action = action;
    
    if (children == 0)
        self.backgroundColor = [UIColor clearColor];
    else
        self.backgroundColor = RGBA(0, 0, 0, 0.5);
    
    nameLabel.text = action.name;
    
    /*NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:nameLabel.font.pointSize]};
    nameLabel.attributedText = [[NSAttributedString alloc] initWithString:action.name attributes:attribute];
    CGRect rect = [action.name boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                                    options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                 attributes:attribute
                                    context:nil];
    */
    CGSize size = [nameLabel.text sizeWithAttributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:nameLabel.font.pointSize] }];
    nameLabel.width = size.width;
    nameLabel.top = 0;
    nameLabel.height = 30;
    
    if (level > 0)
        flagView.hidden = YES;
    else
        flagView.hidden = NO;
}

@end
