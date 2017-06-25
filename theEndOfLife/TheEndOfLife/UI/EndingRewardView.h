//
//  EndingRewardView.h
//  destroy
//
//  Created by 尹楠 on 16/10/2.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EndingRewardView : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    
    IBOutlet UILabel *titleLabel;
    IBOutlet UIView *headerView;
    IBOutlet UIView *separatorLineView;
    IBOutlet UITableView *rewardTableView;
    IBOutlet UIView *footerView;
    IBOutlet UILabel *gameSurvivalPointLabel;
    IBOutlet UILabel *totalSurvivalPointLabel;
    IBOutlet UIButton *titleScreenButton;
}

@property (nonatomic, strong) IBOutlet UIView *sceneTransferMaskView;

@end
