//
//  TitleScreenView.h
//  destroy
//
//  Created by 尹楠 on 16/9/22.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleScreenView : UIViewController {
    
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *authorLabel;
    
    IBOutlet UIButton *loadGameButton;
}

@property (nonatomic, strong) IBOutlet UIView *sceneTransferMaskView;

+ (TitleScreenView *)sharedView;

- (void)show;

@end
