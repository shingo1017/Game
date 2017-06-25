//
//  EndingRewardView.m
//  destroy
//
//  Created by 尹楠 on 16/10/2.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "EndingRewardView.h"
#import "RewardCell.h"

@interface EndingRewardView () {
    
    NSInteger _stepIndex;
}

@end

@implementation EndingRewardView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    rewardTableView.tableFooterView = footerView;
    separatorLineView.height = 0.5f;
    
    _stepIndex = 0;
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:1.5f animations:^{
        
        _sceneTransferMaskView.alpha = 0.0f;
        
        [self performSelector:@selector(excuteStep) withObject:nil afterDelay:1.0f];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)excuteStep {
    
    if (_stepIndex == 0) {
        
        [UIView animateWithDuration:0.3f animations:^{
            
            titleLabel.alpha = 1.0f;
        } completion:^(BOOL finished) {
            
            _stepIndex += 1;
            [self performSelector:@selector(excuteStep) withObject:nil afterDelay:1.0f];
        }];
    }
    else if (_stepIndex == 1) {
        
        [rewardTableView reloadData];
        _stepIndex += 1;
        
        [UIView animateWithDuration:1.5f animations:^{
            
            separatorLineView.width = rewardTableView.width;
        }];
        [self performSelector:@selector(excuteStep) withObject:nil afterDelay:1.0f];
    }
    else if (_stepIndex == 2) {
        
        [rewardTableView reloadData];
        _stepIndex += 1;
        [self performSelector:@selector(excuteStep) withObject:nil afterDelay:1.0f];
    }
    else if (_stepIndex == 3) {
        
        [rewardTableView reloadData];
        gameSurvivalPointLabel.text = [NSString stringWithFormat:@"本局游戏获得点数：%li点", [[Game sharedGame] daysPass] * 100];
        gameSurvivalPointLabel.alpha = 1.0f;
        _stepIndex += 1;
        [self performSelector:@selector(excuteStep) withObject:nil afterDelay:1.0f];
    }
    else if (_stepIndex == 4) {
        
        totalSurvivalPointLabel.text = [NSString stringWithFormat:@"总点数：%li点", [[System system] intProperty:@"survivalPoint"] + [[Game sharedGame] daysPass] * 100];
        totalSurvivalPointLabel.alpha = 1.0f;
        _stepIndex += 1;
        [self performSelector:@selector(excuteStep) withObject:nil afterDelay:1.0f];
    }
    else {
        
        [UIView animateWithDuration:0.3f animations:^{
            
            titleScreenButton.alpha = 1.0f;
        }];
    }
}

- (IBAction)titleScreenButtonClick:(id)sender {
    
    [UIView animateWithDuration:1.5f animations:^{
        
        _sceneTransferMaskView.alpha = 1.0f;
    } completion:^(BOOL finished) {
        
        [[TitleScreenView sharedView].navigationController popToRootViewControllerAnimated:NO];
        [[TitleScreenView sharedView] show];
    }];
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (_stepIndex > 1)
        return 1;
    else
        return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (_stepIndex > 0)
        return 40.0f;
    else
        return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 40.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if (_stepIndex > 2)
        return 80.0f;
    else
        return 0.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (_stepIndex > 0) {
        
        headerView.alpha = 1.0f;
        return headerView;
    }
    else
        return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier = @"RewardCell";
    RewardCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
        cell = (RewardCell *)[UIView viewWithName:@"RewardCell"];
    
    cell.nameLabel.text = [NSString stringWithFormat:@"存活了%li天", [[Game sharedGame] daysPass]];
    cell.survivalPointLabel.text = [NSString stringWithFormat:@"%li点", [[Game sharedGame] daysPass] * 100];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    if (_stepIndex > 2) {
        
        footerView.alpha = 1.0f;
        return footerView;
    }
    else
        return nil;
}

@end
