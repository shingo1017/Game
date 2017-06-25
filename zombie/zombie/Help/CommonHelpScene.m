//
//  CommonHelpScene.m
//  zombie
//
//  Created by 尹楠 on 17/5/21.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "CommonHelpScene.h"

@interface CommonHelpScene () {
    
    UILabel *summaryLabel;
}

@property (nonatomic, assign) CGFloat number;

@end

@implementation CommonHelpScene

- (id)init {
    
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        
        summaryLabel = [[UILabel alloc] initWithFrame:CGRectMake(c_f_padding, c_f_padding, 0, 0)];
        summaryLabel.font = [UIFont systemFontOfSize:13.0f];
        summaryLabel.textColor = WHITE_COLOR;
        summaryLabel.numberOfLines = 0;
        [self.contentView addSubview:summaryLabel];
    }
    return self;
}

- (void)showWithText:(NSString *)text {
    
    if (text.length < 100)
        self.contentView.frame = CGRectMake((SCREEN_WIDTH - 300) / 2, (SCREEN_HEIGHT - 200) / 2, 300, 200);
    else if (text.length < 300) {
        
        self.contentView.frame = CGRectMake((SCREEN_WIDTH - 400) / 2, (SCREEN_HEIGHT - 300) / 2, 400, 300);
    }
    else
        self.contentView.frame = CGRectMake((SCREEN_WIDTH - 500) / 2, (SCREEN_HEIGHT - 350) / 2, 500, 350);
    
    summaryLabel.width = self.contentView.width - c_f_padding * 2;
    summaryLabel.attributedText = [text attributedStringForSummary];
    CGFloat height = [text heightOfAttributedText:summaryLabel.attributedText width:self.contentView.width - c_f_padding * 2];
    summaryLabel.height = height;
    summaryLabel.top = (self.contentView.height - 50 - summaryLabel.height) / 2;
    
    [self show];
}

@end
