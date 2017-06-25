//
//  ShopView.h
//  destroy
//
//  Created by 尹楠 on 16/10/1.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RATreeView.h"

@interface ShopView : UIViewController <UITableViewDataSource, UITableViewDelegate, RATreeViewDataSource, RATreeViewDelegate> {
    
    IBOutlet UILabel *survivalPointLabel;
    IBOutlet UITableView *tabTableView;
    IBOutlet UIView *tabDescriptionContainerView;
    IBOutlet UILabel *tabDescriptionLabel;
}

@property (nonatomic, strong) IBOutlet UIView *sceneTransferMaskView;
@property (nonatomic, strong) IBOutlet RATreeView *actionTableView;

+ (ShopView *)sharedView;

- (void)reloadSurvivalPoint;
- (void)reloadCurrentScene;
- (void)warningNotEnoughSurvivalPoint;

@end
