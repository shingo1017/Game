//
//  DisplayPropertyWidget.m
//  girl
//
//  Created by 尹楠 on 16/9/3.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "DisplayPropertyWidget.h"

@implementation DisplayPropertyWidget

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        captionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 20)];
        captionLabel.font = [UIFont systemFontOfSize:13.0f];
        [self addSubview:captionLabel];
        
        textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 20)];
        textLabel.font = [UIFont systemFontOfSize:13.0f];
        textLabel.hidden = YES;
        [self addSubview:textLabel];
        
        numberBar = [[NumberBar alloc] initWithFrame:CGRectMake(0, 5, 0, 10)];
        numberBar.hidden = YES;
        [self addSubview:numberBar];
    }
    return self;
}

- (void)setDisplayProperty:(DisplayProperty *)displayProperty {
    
    _displayProperty = displayProperty;
    if (_displayProperty) {
        
        captionLabel.text = [Utility textForKey:_displayProperty.captionKey];
        [captionLabel sizeToFit];
        captionLabel.height = 20;
        captionLabel.textColor = WHITE_COLOR;//_displayProperty.color;
        
        if (_displayProperty.type == DisplayPropertyTypeText) {
            
            if ([displayProperty respondsToSelector:@selector(displayText)])
                textLabel.text = [displayProperty displayText];
            [textLabel sizeToFit];
            textLabel.left = captionLabel.right + 5;
            textLabel.height = 20;
            textLabel.textColor = WHITE_COLOR;//_displayProperty.color;
            textLabel.hidden = NO;
        }
        else if (_displayProperty.type == DisplayPropertyTypeBar) {
            
            numberBar.left = captionLabel.right + 5;
            numberBar.width = self.width - captionLabel.right - 15;
            
            if ([displayProperty respondsToSelector:@selector(maxNumber)])
                numberBar.maxNumber = [displayProperty maxNumber];
            else
                numberBar.maxNumber = 1000;
            
            if ([displayProperty respondsToSelector:@selector(displayNumber)])
                numberBar.number = [displayProperty displayNumber];
            numberBar.hidden = NO;
        }
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadValue) name:_displayProperty.keyPath object:nil];
    }
}

- (void)reloadValue {
    
    if (_displayProperty.type == DisplayPropertyTypeText) {
        
        if ([_displayProperty respondsToSelector:@selector(displayText)])
            textLabel.text = [_displayProperty displayText];
        [textLabel sizeToFit];
        textLabel.height = 20;
    }
    else {
        
        if ([_displayProperty respondsToSelector:@selector(displayNumber)])
            [numberBar setNumber:[_displayProperty displayNumber] animation:YES];
    }
    
    for (NSString *notificationKeyPath in _displayProperty.notificationKeyPaths) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:notificationKeyPath object:nil];
    }
}

@end
