//
//  GridCell.m
//  zombie
//
//  Created by 尹楠 on 17/5/25.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "GridCell.h"

@interface GridCell () {
    
    NSMutableArray *_labels;
}

@end

@implementation GridCell

- (void)layoutSubviews {
    
    [super layoutSubviews];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // 初始化操作
        _labels = [NSMutableArray new];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTexts:(NSArray *)texts {
    
    _texts = texts;
    
    [self initSubViewsWithColumnCount:_texts.count];
    
    NSInteger i = 0;
    for (UILabel *label in _labels) {
        
        label.text = _texts[i];
        i++;
    }
    
    [self refreshUI];
}

- (void)setWidthLimits:(NSArray *)widthLimits {
    
    _widthLimits = widthLimits;
    
    [self initSubViewsWithColumnCount:_widthLimits.count];
    
    [self refreshUI];
}

- (void)setColors:(NSArray *)colors {
    
    _colors = colors;
    
    [self refreshUI];
}

- (void)initSubViewsWithColumnCount:(NSInteger)columnCount {
    
    if (_labels.count == 0) {
        
        for (int i = 0; i < columnCount; i++) {
            
            UILabel *label = [UILabel new];
            label.font = [UIFont systemFontOfSize:13];
            [self.contentView addSubview:label];
            [_labels addObject:label];
        }
    }
}

- (void)refreshUI {
    
    if (_isTitle || _style == GridCellStyleHighlight)
        self.backgroundColor = WHITE_COLOR;
    else
        self.backgroundColor = BLACK_COLOR;
    
    if (_widthLimits.count > 0) {
        
        NSInteger i = 0;
        CGFloat left = 10;
        for (UILabel *label in _labels) {
            
            label.frame = CGRectMake(left, 0, [_widthLimits[i] floatValue], 30);
            left = label.right;
            
            if (_style == GridCellStyleDisabled)
                label.textColor = GRAY_COLOR;
            else if (_isTitle || _style == GridCellStyleHighlight)
                label.textColor = BLACK_COLOR;
            else {
                
                label.textColor = _colors[i];
            }
            
            i++;
        }
    }
}

- (void)setIsTitle:(BOOL)isTitle {
    
    _isTitle = isTitle;
    
    [self refreshUI];
}

- (void)setStyle:(GridCellStyle)style {
    
    _style = style;
    
    [self refreshUI];
}

@end
