//
//  TitleScreenView.m
//  destroy
//
//  Created by 尹楠 on 16/9/22.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "TitleScreenView.h"
#import "Shingo.h"
#import "ShopView.h"
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
        
        [Person setMe:[[Shingo alloc] init]];
        [[Person me] setProperty:@"ChurchRoomScene" forKey:@"scene"];
        
        MainView *mainView = [self.storyboard instantiateViewControllerWithIdentifier:@"MainView"];
        [self.navigationController pushViewController:mainView animated:NO];
        
        [MainView setSharedView:mainView];
        
        //游戏教程
        [Story beginStoryWithClassName:@"TutorialStory"];
    }];
}

- (IBAction)loadGameButtonClicked:(id)sender {
    
    [UIView animateWithDuration:1.5f animations:^{
        
        titleLabel.alpha = 0.0f;
        self.sceneTransferMaskView.alpha = 1.0f;
    } completion:^(BOOL finished) {

        MainView *mainView = [self.storyboard instantiateViewControllerWithIdentifier:@"MainView"];
        [self.navigationController pushViewController:mainView animated:NO];
        
        [MainView setSharedView:mainView];
        
        [Game loadGame];
    }];
}

- (IBAction)shopViewButtonClicked:(id)sender {
    
    [UIView animateWithDuration:1.5f animations:^{
        
        titleLabel.alpha = 0.0f;
        self.sceneTransferMaskView.alpha = 1.0f;
    } completion:^(BOOL finished) {
        
        ShopView *shopView = [self.storyboard instantiateViewControllerWithIdentifier:@"ShopView"];
        [self.navigationController pushViewController:shopView animated:NO];
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
