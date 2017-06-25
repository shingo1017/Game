//
//  MainView.h
//  girl
//
//  Created by 尹楠 on 16/9/2.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupContainerView.h"
#import "RATreeView.h"
#import "PersonView.h"
#import "SceneWidget.h"
#import "GroupWidget.h"
#import "StoreView.h"
#import "BagView.h"

@interface MainView : BaseMainView <UITableViewDataSource, UITableViewDelegate, RATreeViewDataSource, RATreeViewDelegate>

@property (nonatomic, strong) IBOutlet PersonView *personView;
@property (nonatomic, strong) IBOutlet StoreView *storeView;
@property (nonatomic, strong) IBOutlet BagView *bagView;
//@property (nonatomic, strong) IBOutlet ItemView *itemView;
@property (nonatomic, strong) IBOutlet UIImageView *myImageView;
@property (nonatomic, strong) IBOutlet UIImageView *partnerImageView;
@property (nonatomic, strong) IBOutlet GroupWidget *gameGroupWidget;
@property (nonatomic, strong) IBOutlet GroupWidget *myStatusGroupWidget;
@property (nonatomic, strong) IBOutlet SceneWidget *sceneWidget;
@property (nonatomic, strong) RATreeView *actionTableView;

+ (MainView *)sharedView;

- (void)showMyImage;
- (void)showMyImageWithAnimation:(BOOL)animation;
- (void)showMyImage:(NSString *)imageName;
- (void)showMyImage:(NSString *)imageName animation:(BOOL)animation;
- (void)hideMyImage;
- (void)hideMyImageWithAnimation:(BOOL)animation;
- (void)showPartnerImage;
- (void)showPartnerImageWithAnimation:(BOOL)animation;
- (void)showPartnerImage:(NSString *)imageName;
- (void)showPartnerImage:(NSString *)imageName animation:(BOOL)animation;
- (void)hidePartnerImage;
- (void)hidePartnerImageWithAnimation:(BOOL)animation;

@end

