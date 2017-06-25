//
//  TitleScreenView.m
//  destroy
//
//  Created by 尹楠 on 16/9/22.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "TitleScreenView.h"
#import "Story.h"

@interface TitleScreenView ()

@end

@implementation TitleScreenView

static TitleScreenView *_sharedView;

+ (TitleScreenView *)sharedView {
    
    return _sharedView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self reload];
    
    _sharedView = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reload {
    
    if ([Game canLoadGame]) {
        
        loadGameButton.enabled = YES;
        [loadGameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    else {
        
        loadGameButton.enabled = NO;
        [loadGameButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
}

- (IBAction)newGameButtonClicked:(id)sender {
    
    if ([Game canLoadGame]) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"警告" message:@"重新开始游戏会覆盖已有的存档！要继续吗？" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alert addAction:[UIAlertAction actionWithTitle:@"覆盖" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            [self newGame];
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else
        [self newGame];
}

- (void)newGame {
    
    [UIView animateWithDuration:1.5f animations:^{
        
        self.sceneTransferMaskView.alpha = 1.0f;
    } completion:^(BOOL finished) {
        
        //显示作者名
        [UIView animateWithDuration:2.0f animations:^{
            
            authorLabel.alpha = 1.0f;
        } completion:^(BOOL finished) {
            
            [self performSelector:@selector(start) withObject:nil afterDelay:1.5f];
        }];
    }];
}

- (void)start {
    
    [UIView animateWithDuration:1.5f animations:^{
        
        titleLabel.alpha = 0.0f;
        authorLabel.alpha = 0.0f;
    } completion:^(BOOL finished) {
        
        //暂时代替剧本的作用
        [[Game sharedGame] setProperty:@(21) forKey:k_dayAfterLastHumanDay];
        [[Game sharedGame] setProperty:@(1) forKey:k_day];
        [[Game sharedGame] setProperty:@(8) forKey:k_hour];
        [[Game sharedGame] setProperty:@"TownHospital" forKey:@"placeClassName"];
        
        //初始化地图
        Map *map = [Utility objectForClassName:@"Townlet"];
        [[Game sharedGame] setProperty:NSStringFromClass(map.class) forKey:@"defaultMapClass"];
        if (!map.fogEnabled)
            [map visableMap];
        [map discoverPlaceAtCoordinate:map.startCoordinate];
        
        //初始化场景
        Place *startPlace = [map placeAtCoordinate:map.startCoordinate];
        [[Game sharedGame] setProperty:startPlace.id forKey:k_myPlaceId];
        
        //初始化幸存者
        Survivor *rick = [Utility objectForClassName:@"Rick"];
        [Survivor setEntity:rick];
        
        //初始化团队
        Team *team = [Utility objectForClassName:@"RickTeam"];
        [Team setEntity:team];
        [[Game sharedGame] setProperty:team.id forKey:k_myTeamId];
        
        //初始化关系
        [team setProperty:@[rick.id] forKey:k_survivorIds];
        [startPlace setProperty:@[rick.id] forKey:k_survivorIds];
        
        //初始化游戏主界面
        MainView *mainView = [self.storyboard instantiateViewControllerWithIdentifier:@"MainView"];
        [MainView setSharedView:mainView];
        [self.navigationController pushViewController:mainView animated:NO];
        
        //游戏教程
        [Story beginStoryWithClassName:@"TutorialStory"];
    }];
}

- (IBAction)loadGameButtonClicked:(id)sender {
    
    [UIView animateWithDuration:1.5f animations:^{
        
        titleLabel.alpha = 0.0f;
        self.sceneTransferMaskView.alpha = 1.0f;
    } completion:^(BOOL finished) {

        [Game loadGame];
        
        MainView *mainView = [self.storyboard instantiateViewControllerWithIdentifier:@"MainView"];
        [MainView setSharedView:mainView];
        [self.navigationController pushViewController:mainView animated:NO];
    }];
}

- (void)show {
    
    [self reload];
    
    [UIView animateWithDuration:1.5f animations:^{
        
        titleLabel.alpha = 1.0f;
        self.sceneTransferMaskView.alpha = 0.0f;
    }];
}

@end
