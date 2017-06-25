//
//  PersonView.h
//  girl
//
//  Created by 尹楠 on 16/9/3.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"

@interface PersonView : UIView

@property (nonatomic, strong) Person *person;

+ (PersonView *)sharedView;

- (void)showWithPersion:(Person *)person;
- (CGFloat)maxHeight;

@end
