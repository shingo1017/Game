//
//  HelpButton.m
//  zombie
//
//  Created by 尹楠 on 2017/6/22.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "HelpButton.h"

@interface HelpButton () {
    
    UILabel *_helpCaption;
    UILabel *_helpLabel;
    
    void (^_helpbuttonClicked)();
}

@end

@implementation HelpButton

- (id)initWithText:(NSString *)text helpbuttonClicked:(void (^)())helpbuttonClicked {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        _helpbuttonClicked = helpbuttonClicked;
        
        _helpCaption = [UILabel captionWithText:text fontSize:11];
        [_helpCaption sizeToFit];
        _helpCaption.left = 5;
        _helpCaption.top = 5;
        _helpCaption.height = 11;
        [self addSubview:_helpCaption];
        
        CGFloat height = _helpCaption.height + 10;
        
        _helpLabel = [[UILabel alloc] initWithFrame:CGRectMake(_helpCaption.right + 5, (height - 15) / 2, 15, 15)];
        [_helpLabel roundStyle];
        _helpLabel.backgroundColor = WHITE_COLOR;
        _helpLabel.textAlignment = NSTextAlignmentCenter;
        _helpLabel.font = [UIFont systemFontOfSize:13.0f];
        _helpLabel.text = @"?";
        [self addSubview:_helpLabel];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, _helpLabel.right + 5, height);
        [button addTarget:self action:@selector(helpButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        self.width = button.width;
        self.height = button.height;
    }
    return self;
}

- (void)helpButtonClicked {
    
    if (_helpbuttonClicked)
        _helpbuttonClicked();
}

@end
