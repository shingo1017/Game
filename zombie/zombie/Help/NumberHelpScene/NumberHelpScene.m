//
//  NumberHelpScene.m
//  zombie
//
//  Created by 尹楠 on 17/5/21.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "NumberHelpScene.h"
#import "NumberBar.h"

@interface NumberHelpScene () {
    
    UILabel *_nameLabel;
    UIView *_nameLine;
    
//    UILabel *numberLabel;
//    NumberBar *numberBar;
//    UILabel *expLabel;
    
//    UIView *summaryGroupContainerView;
    UILabel *summaryLabel;
}

@property (nonatomic, assign) CGFloat number;

@end

@implementation NumberHelpScene

- (id)init {
    
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.contentView.frame = CGRectMake((SCREEN_WIDTH - 400) / 2, (SCREEN_HEIGHT - 300) / 2, 400, 300);
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 0, 0)];
        _nameLabel.font = [UIFont systemFontOfSize:20.0f];
        _nameLabel.textColor = WHITE_COLOR;
        [self.contentView addSubview:_nameLabel];
        
        _nameLine = [[UIView alloc] initWithFrame:CGRectMake(_nameLabel.left, 0, self.contentView.width - _nameLabel.left * 2, 1)];
        _nameLine.backgroundColor = WHITE_COLOR;
        [self.contentView addSubview:_nameLine];
        
//        numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(_nameLabel.left, 27, self.contentView.width - _nameLabel.left * 2, 0)];
//        numberLabel.font = [UIFont systemFontOfSize:13.0f];
//        numberLabel.textColor = WHITE_COLOR;
//        [self.contentView addSubview:numberLabel];
        
//        summaryGroupContainerView = [[UIView alloc] initWithFrame:CGRectMake(_nameLabel.left, 0, self.contentView.width - _nameLabel.left * 2, 0)];
//        summaryGroupContainerView.backgroundColor = [UIColor clearColor];
////        [summaryGroupContainerView borderStyle];
//        [self.contentView addSubview:summaryGroupContainerView];
        
        summaryLabel = [[UILabel alloc] initWithFrame:CGRectMake(_nameLabel.left, 10, self.contentView.width - _nameLabel.left * 2, 0)];
        summaryLabel.font = [UIFont systemFontOfSize:13.0f];
        summaryLabel.textColor = WHITE_COLOR;
        summaryLabel.numberOfLines = 0;
        [self.contentView addSubview:summaryLabel];
    }
    return self;
}

- (void)showWithNumber:(CGFloat)number key:(NSString *)key {
    
    _number = number;
    
    NSDictionary *helpDictionaries = [NSDictionary dictionaryWithContentsOfFile:FILE_BUNDLE_PATH(@"HelpData.plist")];
    NSDictionary *helpDictionary = helpDictionaries[key];
    
    _nameLabel.text = helpDictionary[k_name];
    [_nameLabel sizeToFit];
    
    _nameLine.top = _nameLabel.bottom + 10;
    
//    numberLabel.top = _nameLine.bottom + 10;
//    numberLabel.text = FLOAT02String(_number);
//    [numberLabel sizeToFit];
    
    //CGFloat exp = (_number - floor(_number)) * 100;
    //numberBar.maxNumber = 100.0f;
    //numberBar.number = exp;
    //expLabel.text = [NSString stringWithFormat:@"%.0f%%", exp];
    
    summaryLabel.top = _nameLine.bottom + 10;
    summaryLabel.attributedText = [helpDictionary[@"summary"] attributedStringForSummary];
    CGFloat height = [helpDictionary[@"summary"] heightOfAttributedText:summaryLabel.attributedText width:summaryLabel.width];
    summaryLabel.height = height;
//    summaryGroupContainerView.height = height + 50.0f;
    
    [self show];
}

- (void)reloadNumber:(CGFloat)number {
    
    _number = number;
//    numberLabel.text = FLOAT02String(_number);
    
//    CGFloat exp = (_number - floor(_number)) * 100;
//    numberBar.maxNumber = 100.0f;
//    numberBar.number = exp;
//    expLabel.text = [NSString stringWithFormat:@"%.0f%%", exp];
}

- (void)shouldReloadNumberNotification:(NSNotification *)notification {
    
    [self reloadNumber:[notification.object floatValue]];
}

@end
