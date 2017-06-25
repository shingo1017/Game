//
//  ScheduleTableView.h
//  zombie
//
//  Created by 尹楠 on 17/5/27.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScheduleTableView : UITableView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) Place *place;

@end
