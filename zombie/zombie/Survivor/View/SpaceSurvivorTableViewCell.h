//
//  SpaceSurvivorTableViewCell.h
//  worldOfZombie
//
//  Created by 尹楠 on 15/2/20.
//  Copyright (c) 2015年 c2y. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Survivor.h"
#import "NumberBar.h"

@interface SpaceSurvivorTableViewCell : UITableViewCell {
    
    IBOutlet UIImageView *survivorImageView;
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *statusLabel;
    IBOutlet NumberBar *staminaNumberBar;
    IBOutlet UIButton *talkButton;
}

@property (nonatomic, retain) Survivor *survivor;

- (IBAction)talkButtonClicked:(id)sender;

@end
