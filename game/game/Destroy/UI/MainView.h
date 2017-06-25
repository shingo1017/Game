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
#import "ItemView.h"
#import "GroupWidget.h"

@interface MainView : UIViewController <UITableViewDataSource, UITableViewDelegate, RATreeViewDataSource, RATreeViewDelegate> {
    
    IBOutlet UIView *actionContainerView;
}

@property (nonatomic, strong) IBOutlet UIImageView *sceneImageView;
@property (nonatomic, strong) IBOutlet UIView *viewMaskView;
@property (nonatomic, strong) IBOutlet PersonView *personView;
@property (nonatomic, strong) IBOutlet ItemView *itemView;
@property (nonatomic, strong) IBOutlet UIImageView *myImageView;
@property (nonatomic, strong) IBOutlet UIImageView *partnerImageView;
@property (nonatomic, strong) IBOutlet GroupWidget *gameGroupWidget;
@property (nonatomic, strong) IBOutlet UIView *messageContainerView;
@property (nonatomic, strong) IBOutlet UILabel *messageLabel;
@property (nonatomic, strong) IBOutlet UIView *sceneTransferMaskView;
@property (nonatomic, strong) IBOutlet RATreeView *actionTableView;

+ (MainView *)sharedView;

- (void)showTime;
- (void)hideTime;
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

