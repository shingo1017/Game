//
//  InfoCell.h
//  zombie
//
//  Created by 尹楠 on 17/5/25.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DisplayPropertyWidget.h"

typedef void(^helpButtonClickedBlock)();

@interface InfoCell : UITableViewCell

@property (nonatomic, assign) BOOL shouldShowHelp;
@property (nonatomic, assign) BOOL isDefaultPlace;
@property (nonatomic, strong) DisplayPropertyWidget *displayPropertyWidget;
@property (nonatomic, copy) helpButtonClickedBlock helpButtonClickedBlock;

@end
