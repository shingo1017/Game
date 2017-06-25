//
//  NumberBar.h
//  worldOfZombie
//
//  Created by 尹楠 on 15/7/21.
//  Copyright (c) 2015年 c2y. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NumberBar : UIView {
    
    IBOutlet UIView *maxNumberBar;
    IBOutlet UIView *numberBar;
}

@property (nonatomic, assign) CGFloat maxNumber;
@property (nonatomic, assign) CGFloat number;

- (void)setNumber:(CGFloat)number animation:(BOOL)animation;

@end
