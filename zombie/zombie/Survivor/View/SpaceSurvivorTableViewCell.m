//
//  SpaceSurvivorTableViewCell.m
//  worldOfZombie
//
//  Created by 尹楠 on 15/2/20.
//  Copyright (c) 2015年 c2y. All rights reserved.
//

#import "SpaceSurvivorTableViewCell.h"
#import "TalkView.h"

@implementation SpaceSurvivorTableViewCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    self.backgroundColor = BACKGROUND_COLOR;
    [self borderStyleWithColor:GROUP_CONTAINER_BORDER_COLOR];
    [talkButton cornerRadiusStyle];
    [talkButton borderStyleWithColor:GROUP_CONTAINER_BORDER_COLOR];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shouldReloadStaminaNotification:) name:K_SHOULD_RELOAD_STAMINA_NOTIFICATION object:nil];
}

- (void)setSurvivor:(Survivor *)survivor {
    
    _survivor = survivor;
    
    if (_survivor) {
        
        survivorImageView.image = [UIImage imageNamed:_survivor.name];
        nameLabel.text = _survivor.name;
        statusLabel.text = _survivor.statusText;
        staminaNumberBar.maxNumber = _survivor.maxStamina;
        staminaNumberBar.number = _survivor.stamina;
//        if ([_survivor isMySelf])
//            talkButton.hidden = YES;
//        else
//            talkButton.hidden = NO;
    }
}

- (IBAction)talkButtonClicked:(id)sender {
    
    [[TalkView sharedTalkView] showWithSurvivors:@[[Survivor defaultSurvivor], _survivor]];
}

- (void)shouldReloadStaminaNotification:(NSNotification *)notification {
    
    staminaNumberBar.number = [notification.object floatValue];
}

@end
