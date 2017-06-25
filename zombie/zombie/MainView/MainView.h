//
//  MainView.h
//  girl
//
//  Created by 尹楠 on 16/9/2.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainView : BaseMainView

+ (MainView *)sharedView;

- (void)showScene:(Scene *)scene;
- (void)hideScene:(Scene *)scene;
- (Scene *)sceneForClassName:(NSString *)className;

- (void)showContinueButton;
- (void)transferSceneWithClassName:(NSString *)className completion:(void (^)(void))completionBlock;

@end

