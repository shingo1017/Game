//
//  HelpButton.h
//  zombie
//
//  Created by 尹楠 on 2017/6/22.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelpButton : UIView

- (id)initWithText:(NSString *)text helpbuttonClicked:(void (^)())helpbuttonClicked;

@end
