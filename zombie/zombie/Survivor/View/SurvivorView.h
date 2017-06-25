//
//  SurvivorView.h
//  worldOfZombie
//
//  Created by 尹楠 on 15/7/2.
//  Copyright (c) 2015年 c2y. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Survivor.h"
#import "GroupContainerView.h"
#import "NumberBar.h"

@interface SurvivorView : UIView {
    
    IBOutlet UIImageView *survivorImageView;
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *genderLabel;
    IBOutlet UILabel *personalityLabel;
    IBOutlet UILabel *statusLabel;
    
    IBOutlet UIView *infoContainerView;
    IBOutlet GroupContainerView *capabilityPropertyContainerView;
    IBOutlet UILabel *combatLabel;
    IBOutlet UILabel *shootingLabel;
    IBOutlet UILabel *survivalLabel;
    IBOutlet UILabel *logisticsLabel;
    
    IBOutlet GroupContainerView *basePropertyContainerView;
    IBOutlet UILabel *healthLabel;
    IBOutlet NumberBar *staminaNumberBar;
    IBOutlet UILabel *staminaLabel;
    IBOutlet UILabel *courageLabel;
    IBOutlet UILabel *strengthLabel;
    IBOutlet UILabel *agilityLabel;
    IBOutlet UILabel *strategyLabel;
    IBOutlet UILabel *eqLabel;
    IBOutlet UILabel *goodnessLabel;
    
    IBOutlet GroupContainerView *statusPropertyContainerView;
    IBOutlet UILabel *hungryLabel;
    IBOutlet UILabel *thirstyLabel;
    
    IBOutlet UIView *equipmentContainerView;
    IBOutlet GroupContainerView *equipmentGroupContainerView;
    IBOutlet UICollectionView *equipmentCollectionView;
    
    IBOutlet UIView *summaryContainerView;
    IBOutlet GroupContainerView *summaryGroupContainerView;
    IBOutlet UILabel *summaryLabel;
}

@property (nonatomic, retain) Survivor *survivor;

+ (SurvivorView *)sharedSurvivorView;
+ (void)setSharedSurvivorView:(SurvivorView *)sharedSurvivorView;


- (IBAction)genderButtonClicked:(id)sender;
- (IBAction)ageButtonClicked:(id)sender;
- (IBAction)personalityButtonClicked:(id)sender;
- (IBAction)statusButtonClicked:(id)sender;
- (IBAction)healthButtonClicked:(id)sender;
- (IBAction)staminaButtonClicked:(id)sender;
- (IBAction)strengthButtonClicked:(id)sender;
- (IBAction)agilityButtonClicked:(id)sender;
- (IBAction)hungryButtonClicked:(id)sender;
- (IBAction)thirstyButtonClicked:(id)sender;

- (IBAction)mainHandItemButtonClicked:(id)sender;
- (IBAction)offHandItemButtonClicked:(id)sender;

- (IBAction)infoButtonClicked:(id)sender;
- (IBAction)equipmentButtonClicked:(id)sender;
- (IBAction)summaryButtonClicked:(id)sender;
- (IBAction)closeButtonClicked:(id)sender;

- (void)showWithSurvivor:(Survivor *)survivor;

@end
