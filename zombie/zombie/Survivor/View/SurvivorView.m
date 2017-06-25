//
//  SurvivorView.m
//  worldOfZombie
//
//  Created by 尹楠 on 15/7/2.
//  Copyright (c) 2015年 c2y. All rights reserved.
//

#import "SurvivorView.h"
#import "NumberHelpView.h"
#import "ItemView.h"
#import "EquipmentCollectionCell.h"

static SurvivorView *_sharedSurvivorView;

@implementation SurvivorView

+ (SurvivorView *)sharedSurvivorView {
    
    return _sharedSurvivorView;
}

+ (void)setSharedSurvivorView:(SurvivorView *)sharedSurvivorView {
    
    _sharedSurvivorView = sharedSurvivorView;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shouldReloadStatusNotification:) name:K_SHOULD_RELOAD_STATUS_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shouldReloadHealthNotification:) name:K_SHOULD_RELOAD_HEALTH_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shouldReloadStaminaNotification:) name:K_SHOULD_RELOAD_STAMINA_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shouldReloadCapabilityPropertyNotification:) name:K_SHOULD_RELOAD_COMBAT_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shouldReloadCapabilityPropertyNotification:) name:K_SHOULD_RELOAD_SHOOTING_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shouldReloadCapabilityPropertyNotification:) name:K_SHOULD_RELOAD_SURVIVAL_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shouldReloadCapabilityPropertyNotification:) name:K_SHOULD_RELOAD_LOGISTICS_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shouldReloadBasePropertyNotification:) name:K_SHOULD_RELOAD_COURAGE_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shouldReloadBasePropertyNotification:) name:K_SHOULD_RELOAD_STRENGTH_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shouldReloadBasePropertyNotification:) name:K_SHOULD_RELOAD_AGILITY_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shouldReloadBasePropertyNotification:) name:K_SHOULD_RELOAD_STRATEGY_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shouldReloadBasePropertyNotification:) name:K_SHOULD_RELOAD_EQ_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shouldReloadBasePropertyNotification:) name:K_SHOULD_RELOAD_GOODNESS_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shouldReloadHungryNotification:) name:K_SHOULD_RELOAD_HUNGRY_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shouldReloadThirstyNotification:) name:K_SHOULD_RELOAD_THIRSTY_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shouldReloadEquipmentNotification:) name:K_SHOULD_RELOAD_EQUIPMENT_NOTIFICATION object:nil];
    
    self.backgroundColor = BLACK_COLOR;
    [staminaNumberBar borderStyleWithColor:GROUP_CONTAINER_BORDER_COLOR];
    [staminaNumberBar roundHeightStyle];
    
    capabilityPropertyContainerView.groupName = @"能力";
    basePropertyContainerView.groupName = @"基本";
    statusPropertyContainerView.groupName = @"状态";
    equipmentGroupContainerView.groupName = @"装备";
    summaryGroupContainerView.groupName = @"阅读";
}

- (IBAction)infoButtonClicked:(id)sender {
    
    infoContainerView.hidden = NO;
    equipmentContainerView.hidden = YES;
    summaryContainerView.hidden = YES;
}

- (IBAction)equipmentButtonClicked:(id)sender {
    
    infoContainerView.hidden = YES;
    equipmentContainerView.hidden = NO;
    summaryContainerView.hidden = YES;
}

- (IBAction)summaryButtonClicked:(id)sender {
    
    infoContainerView.hidden = YES;
    equipmentContainerView.hidden = YES;
    summaryContainerView.hidden = NO;
}

- (IBAction)closeButtonClicked:(id)sender {
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    self.alpha = 0.0f;
    [UIView commitAnimations];
}

- (IBAction)genderButtonClicked:(id)sender {
    
    
}

- (IBAction)ageButtonClicked:(id)sender {
    
    
}

- (IBAction)personalityButtonClicked:(id)sender {
    
    
}

- (IBAction)statusButtonClicked:(id)sender {
    
    
}

- (IBAction)healthButtonClicked:(id)sender {
    
    [[NumberHelpView sharedNumberHelpView] showWithNumber:_survivor.health key:k_HEALTH];
}

- (IBAction)staminaButtonClicked:(id)sender {
    
    [[NumberHelpView sharedNumberHelpView] showWithNumber:_survivor.stamina key:k_STAMINA];
}

- (IBAction)combatButtonClicked:(id)sender {
    
    [[NumberHelpView sharedNumberHelpView] showWithNumber:_survivor.combat key:k_COMBAT];
}

- (IBAction)shootingButtonClicked:(id)sender {
    
    [[NumberHelpView sharedNumberHelpView] showWithNumber:_survivor.shooting key:k_SHOOTING];
}

- (IBAction)survivalButtonClicked:(id)sender {
    
    [[NumberHelpView sharedNumberHelpView] showWithNumber:_survivor.survival key:k_SURVIVAL];
}

- (IBAction)logisticsButtonClicked:(id)sender {
    
    [[NumberHelpView sharedNumberHelpView] showWithNumber:_survivor.logistics key:k_LOGISTICS];
}

- (IBAction)courageButtonClicked:(id)sender {
    
    [[NumberHelpView sharedNumberHelpView] showWithNumber:_survivor.courage key:k_COURAGE];
}

- (IBAction)strengthButtonClicked:(id)sender {
    
    [[NumberHelpView sharedNumberHelpView] showWithNumber:_survivor.strength key:k_STRENGTH];
}

- (IBAction)agilityButtonClicked:(id)sender {
    
    [[NumberHelpView sharedNumberHelpView] showWithNumber:_survivor.agility key:k_AGILITY];
}

- (IBAction)strategyButtonClicked:(id)sender {
    
    [[NumberHelpView sharedNumberHelpView] showWithNumber:_survivor.strategy key:k_STRATEGY];
}

- (IBAction)eqButtonClicked:(id)sender {
    
    [[NumberHelpView sharedNumberHelpView] showWithNumber:_survivor.eq key:k_EQ];
}

- (IBAction)goodnessButtonClicked:(id)sender {
    
    [[NumberHelpView sharedNumberHelpView] showWithNumber:_survivor.goodness key:k_GOODNESS];
}

- (IBAction)hungryButtonClicked:(id)sender {
    
    [[NumberHelpView sharedNumberHelpView] showWithNumber:_survivor.hungry key:k_HUNGRY];
}

- (IBAction)thirstyButtonClicked:(id)sender {
    
    [[NumberHelpView sharedNumberHelpView] showWithNumber:_survivor.thirsty key:k_THIRSTY];
}

- (IBAction)mainHandItemButtonClicked:(id)sender {
    
    [[ItemView sharedItemView] showWithItem:_survivor.mainHandItem];
}

- (IBAction)offHandItemButtonClicked:(id)sender {
    
    [[ItemView sharedItemView] showWithItem:_survivor.offHandItem];
}

- (void)shouldReloadCapabilityPropertyNotification:(NSNotification *)notification {
    
    combatLabel.text = [NSString stringWithFormat:@"搏斗：%@", FLOAT02String(_survivor.combat)];
    shootingLabel.text = [NSString stringWithFormat:@"射击：%@", FLOAT02String(_survivor.shooting)];
    survivalLabel.text = [NSString stringWithFormat:@"生存：%@", FLOAT02String(_survivor.survival)];
    logisticsLabel.text = [NSString stringWithFormat:@"后勤：%@", FLOAT02String(_survivor.logistics)];
}

- (void)shouldReloadBasePropertyNotification:(NSNotification *)notification {
    
    courageLabel.text = [NSString stringWithFormat:@"勇气：%@", FLOAT02String(_survivor.courage)];
    strengthLabel.text = [NSString stringWithFormat:@"力量：%@", FLOAT02String(_survivor.strength)];
    agilityLabel.text = [NSString stringWithFormat:@"灵活：%@", FLOAT02String(_survivor.agility)];
    strategyLabel.text = [NSString stringWithFormat:@"谋略：%@", FLOAT02String(_survivor.strategy)];
    eqLabel.text = [NSString stringWithFormat:@"情商：%@", FLOAT02String(_survivor.eq)];
    goodnessLabel.text = [NSString stringWithFormat:@"善良：%@", FLOAT02String(_survivor.goodness)];
}

- (void)shouldReloadStatusNotification:(NSNotification *)notification {
    
    if (_survivor.status == PersonStatusNormal || _survivor.status == PersonStatusSleeping)
        statusLabel.text = _survivor.statusText;
    else if (_survivor.status == PersonStatusWorking)
        statusLabel.text = _survivor.workingOnText;
}

- (void)shouldReloadHealthNotification:(NSNotification *)notification {
    
    healthLabel.text = _survivor.healthText;
    healthLabel.textColor = _survivor.healthColor;
}

- (void)shouldReloadStaminaNotification:(NSNotification *)notification {
    
    if (_survivor) {
        
        staminaNumberBar.maxNumber = _survivor.maxStamina;
        staminaNumberBar.number = _survivor.stamina;
        staminaLabel.text = [NSString stringWithFormat:@"%@ / %@", FLOAT02String(_survivor.stamina), FLOAT02String(_survivor.maxStamina)];
        staminaLabel.textColor = _survivor.staminaColor;
    }
}

- (void)shouldReloadHungryNotification:(NSNotification *)notification {
    
    hungryLabel.text = FLOAT02String(_survivor.hungry);
    hungryLabel.textColor = _survivor.hungryColor;
}

- (void)shouldReloadThirstyNotification:(NSNotification *)notification {
    
    thirstyLabel.text = FLOAT02String(_survivor.thirsty);
    thirstyLabel.textColor = _survivor.thirstyColor;
}

- (void)shouldReloadEquipmentNotification:(NSNotification *)notification {
    
    [equipmentCollectionView reloadData];
}

- (void)showWithSurvivor:(Survivor *)survivor {
    
    _survivor = survivor;
    
    if (_survivor) {
        
        survivorImageView.image = [UIImage imageNamed:_survivor.name];
        nameLabel.text = _survivor.name;
        genderLabel.text = [NSString stringWithFormat:@"%@  %i岁", _survivor.gender == GenderMale ? @"男" : @"女", _survivor.age];
        personalityLabel.text = [NSString stringWithFormat:@"%@", _survivor.personalityText];
        
        [self shouldReloadStatusNotification:nil];
        [self shouldReloadHealthNotification:nil];
        [self shouldReloadStaminaNotification:nil];
        [self shouldReloadCapabilityPropertyNotification:nil];
        [self shouldReloadBasePropertyNotification:nil];
        [self shouldReloadHungryNotification:nil];
        [self shouldReloadThirstyNotification:nil];
        [self shouldReloadEquipmentNotification:nil];
        
        NSString *summary = [NSString stringWithFormat:@"    %@", _survivor.summary];
        summaryLabel.attributedText = [summary attributedStringForSummary];
        CGFloat height = [summary heightOfAttributedText:summaryLabel.attributedText width:260.0f];
        summaryLabel.height = height;
        summaryGroupContainerView.height = height + 50.0f;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        self.alpha = 1.0f;
        [UIView commitAnimations];
    }
}

#pragma mark UICollectionViewDataSource method

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _survivor.equipItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier = @"EquipmentCollectionCell";
    
    UINib *nib = [UINib nibWithNibName:identifier bundle: [NSBundle mainBundle]];
    [collectionView registerNib:nib forCellWithReuseIdentifier:identifier];
    EquipmentCollectionCell *cell = [[EquipmentCollectionCell alloc] init];
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    Item *item = [_survivor.equipItems objectAtIndex:indexPath.row];
    cell.item = item;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    Item *item = [_survivor.equipItems objectAtIndex:indexPath.row];
    [[ItemView sharedItemView] showWithItem:item];
}

@end
