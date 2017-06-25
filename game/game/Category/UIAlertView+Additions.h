//
//  UIAlertView+Additions.h
//  Entlphone
//
//  Created by wangyanan on 14-8-14.
//  Copyright (c) 2014年 Shingo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CompleteBlock) (NSInteger buttonIndex);

@interface UIAlertView (Additions)

// 用Block的方式回调，这时候会默认用self作为Delegate
- (void)showAlertViewWithCompleteBlock:(CompleteBlock) block;

@end
