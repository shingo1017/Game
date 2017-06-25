//
//  BaseMainView.h
//  girl
//
//  Created by 尹楠 on 16/9/2.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MainViewClass [Utility subClassForFatherClass:BaseMainView.class]

@interface BaseMainView : UIViewController

@property (nonatomic, strong) UIImageView *sceneImageView;
//@property (nonatomic, strong) UIView *viewMaskView;
@property (nonatomic, strong) UIView *sceneContainerView;
@property (nonatomic, strong) UIView *messageContainerView;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIView *sceneTransferMaskView;

+ (__kindof BaseMainView *)sharedView;
+ (void)setSharedView:(BaseMainView *)baseMainView;

- (void)initCustomLayerViews;

- (void)transferSceneWithClassName:(NSString *)className;
- (void)transferSceneWithClassName:(NSString *)className animation:(BOOL)animation;
- (void)transferSceneWithClassName:(NSString *)className completion:(void (^)(void))completionBlock;
- (void)transferSceneWithClassName:(NSString *)className animation:(BOOL)animation completion:(void(^)(void))completionBlock;
- (void)didTransferSceneWithClassName:(NSString *)className;

- (void)reloadMessage;

@end

