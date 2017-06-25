//
//  InfoCell.m
//  zombie
//
//  Created by 尹楠 on 17/5/25.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "InfoCell.h"

@interface InfoCell () {
    
//    UILabel *_titleLabel;
    UILabel *_helpLabel;
}

@end

@implementation InfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // 初始化操作
        _displayPropertyWidget = [[DisplayPropertyWidget alloc] initWithFrame:CGRectMake(0, 0, self.width - c_f_padding * 2, self.height)];
        [self.contentView addSubview:_displayPropertyWidget];
        
//        _titleLabel = [UILabel labelWithFontSize:13.0f];
//        _titleLabel.frame = CGRectMake(c_f_padding, 0, self.width - c_f_padding * 2, self.height);
//        [self.contentView addSubview:_titleLabel];
        
//        self.textLabel.font = [UIFont systemFontOfSize:13.0f];
//        self.textLabel.textColor = WHITE_COLOR;
        
        _helpLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.width - 30, (self.height - 15) / 2, 15, 15)];
        [_helpLabel roundStyle];
        _helpLabel.backgroundColor = WHITE_COLOR;
        _helpLabel.textAlignment = NSTextAlignmentCenter;
        _helpLabel.font = [UIFont systemFontOfSize:13.0f];
        _helpLabel.text = @"?";
        _helpLabel.hidden = YES;
        [self.contentView addSubview:_helpLabel];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(_helpLabel.left - 5, 0, _helpLabel.width + 10, self.height);
        [button addTarget:self action:@selector(helpButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setIsDefaultPlace:(BOOL)isDefaultPlace {
    
    _isDefaultPlace = isDefaultPlace;
    
//    _displayPropertyWidget.hidden = !isDefaultPlace;
//    self.textLabel.hidden = isDefaultPlace;
}

- (void)setShouldShowHelp:(BOOL)shouldShowHelp {
    
    _shouldShowHelp = shouldShowHelp;
    
    _helpLabel.hidden = !_shouldShowHelp;
}

- (void)helpButtonClicked {
    
    if (_helpButtonClickedBlock)
        _helpButtonClickedBlock();
}

@end
