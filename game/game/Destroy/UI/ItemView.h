//
//  ItemView.h
//  girl
//
//  Created by 尹楠 on 16/9/3.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"

@interface ItemView : UIView

@property (nonatomic, assign) Item *item;

+ (ItemView *)sharedView;

- (void)showWithItemKey:(NSString *)itemKey;
- (CGFloat)maxHeight;

@end
