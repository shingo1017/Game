//
//  DisplayPropertyWidget.h
//  girl
//
//  Created by 尹楠 on 16/9/3.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DisplayProperty.h"
#import "NumberBar.h"

@interface DisplayPropertyWidget : UIView {
    
    UILabel *captionLabel;
    UILabel *textLabel;
    NumberBar *numberBar;
}

@property (nonatomic, strong) DisplayProperty *displayProperty;

@end
