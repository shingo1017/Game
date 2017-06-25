//
//  SurvivorInfoScene.m
//  zombie
//
//  Created by 尹楠 on 17/5/27.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "SurvivorInfoScene.h"

@interface SurvivorInfoScene () {
    
    UILabel *_nameLabel;
    UIView *_nameLine;
    UIImageView *_avatarImageView;
    UILabel *_maxHealthLabel;
    UILabel *_prestigeLabel;
    
    UIView *_statusContainerView;
    UILabel *_hungryLabel;
    UILabel *_thirstyLabel;
    
    UIButton *_innateTabButton;
    UIView *_innateContainerView;
    UIView *_innateInfoContainerView;
    UILabel *_genderLabel;
    UILabel *_ageLabel;
    UILabel *_burdenLabel;
    
    UILabel *_innateAbilityCaption;
    UIView *_innateAbilityContainerView;
    UILabel *_corageLabel;
    UILabel *_strengthLabel;
    UILabel *_agilityLabel;
    UILabel *_strategyLabel;
    UILabel *_eqLabel;
    UILabel *_goodnessLabel;
    
    UIButton *_acquiredTabButton;
    UIView *_acquiredContainerView;
    UILabel *_acquiredAbilityCaption;
    UIView *_acquiredAbilityContainerView;
    UILabel *_combatLabel;
    UILabel *_shootingLabel;
    UILabel *_survivalLabel;
    UILabel *_logisticsLabel;
    
    UILabel *_skillCaption;
    UIView *_skillContainerView;
    
    Survivor *_survivor;
}

@end

@implementation SurvivorInfoScene

- (id)init {
    
    self = [super init];
    if (self) {
        
        self.contentView.frame = CGRectMake((SCREEN_WIDTH - 600) / 2, (SCREEN_HEIGHT - 350) / 2, 600, 350);
        
        //姓名
        _nameLabel = [UILabel labelWithFontSize:20];
        _nameLabel.frame = CGRectMake(c_f_padding, 20, 0, 0);
        [self.contentView addSubview:_nameLabel];
        
        _nameLine = [UIView lineWithFrame:CGRectMake(c_f_padding, 0, self.contentView.width - c_f_padding * 2, 1)];
        [self.contentView addSubview:_nameLine];
        
        //威望
        _prestigeLabel = [UILabel labelWithFontSize:14];
        [self.contentView addSubview:_prestigeLabel];
        
        //状态信息
        _statusContainerView = [[UIView alloc] initWithFrame:CGRectMake(c_f_padding, 0, 0, 0)];
        _statusContainerView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_statusContainerView];
        
        _hungryLabel = [UILabel labelWithFontSize:14];
        [_innateAbilityContainerView addSubview:_hungryLabel];
        
        _thirstyLabel = [UILabel labelWithFontSize:14];
        [_innateAbilityContainerView addSubview:_thirstyLabel];
        
        //先天Tab按钮
        _innateTabButton = [Button stateButtonWithTitle:@"天生"];
        _innateTabButton.frame = CGRectMake(0, 0, self.closeButton.width + c_f_padding, self.closeButton.height);
        _innateTabButton.selected = YES;
        [_innateTabButton addTarget:self action:@selector(innateTabButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_innateTabButton];
        
        //后天Tab按钮
        _acquiredTabButton = [Button stateButtonWithTitle:@"培养"];
        _acquiredTabButton.frame = CGRectMake(0, 0, self.closeButton.width + c_f_padding, self.closeButton.height);
        [_acquiredTabButton addTarget:self action:@selector(acquiredTabButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_acquiredTabButton];
        
        //先天Tab
        _innateContainerView = [[UIView alloc] initWithFrame:CGRectMake(c_f_padding, 0, self.contentView.width - self.closeButton.width - c_f_padding * 3, 0)];
        _innateContainerView.backgroundColor = [UIColor clearColor];
        [_innateContainerView borderStyle];
        [self.contentView addSubview:_innateContainerView];
        
        //先天信息
        _innateInfoContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _innateContainerView.width, 0)];
        _innateInfoContainerView.backgroundColor = [UIColor clearColor];
        [_innateContainerView addSubview:_innateInfoContainerView];
        
        //头像
        _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(c_f_padding, c_f_padding, 80, 120)];
        _avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
        _avatarImageView.clipsToBounds = YES;
        [_innateInfoContainerView addSubview:_avatarImageView];
        
        _ageLabel = [UILabel labelWithFontSize:14];
        _ageLabel.text = @"年 龄：";
        [_ageLabel sizeToFitAndSetPoint:CGPointMake(_avatarImageView.right + c_f_padding, c_f_padding)];
        [_innateInfoContainerView addSubview:_ageLabel];
        
        _genderLabel = [UILabel labelWithFontSize:14];
        _genderLabel.text = @"性 别：";
        [_genderLabel sizeToFitAndSetPoint:CGPointMake(_ageLabel.left, _ageLabel.bottom + c_f_padding)];
        [_innateInfoContainerView addSubview:_genderLabel];
        
        _burdenLabel = [UILabel labelWithFontSize:14];
        _burdenLabel.text = @"负 重：";
        [_burdenLabel sizeToFitAndSetPoint:CGPointMake(_ageLabel.left, _genderLabel.bottom + c_f_padding)];
        [_innateInfoContainerView addSubview:_burdenLabel];
        
        _innateAbilityCaption = [UILabel captionWithText:@"== 资 质 ==" fontSize:14];
        [_innateAbilityCaption sizeToFitAndSetPoint:CGPointMake(_avatarImageView.left, _avatarImageView.bottom + c_f_padding)];
        [_innateContainerView addSubview:_innateAbilityCaption];
        
        //先天能力
        _innateAbilityContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, _innateAbilityCaption.bottom, _innateContainerView.width, 0)];
        _innateAbilityContainerView.backgroundColor = [UIColor clearColor];
        [_innateContainerView addSubview:_innateAbilityContainerView];
        
        _corageLabel = [UILabel labelWithFontSize:14];
        _corageLabel.text = @"勇 气：";
        [_corageLabel sizeToFitAndSetPoint:CGPointMake(c_f_padding, c_f_padding)];
        [_innateAbilityContainerView addSubview:_corageLabel];
        
        _strengthLabel = [UILabel labelWithFontSize:14];
        _strengthLabel.text = @"力 气：";
        [_strengthLabel sizeToFitAndSetPoint:CGPointMake(_innateAbilityContainerView.width / 3, _corageLabel.top)];
        [_innateAbilityContainerView addSubview:_strengthLabel];
        
        _agilityLabel = [UILabel labelWithFontSize:14];
        _agilityLabel.text = @"灵 活：";
        [_agilityLabel sizeToFitAndSetPoint:CGPointMake(_innateAbilityContainerView.width / 3 * 2, _corageLabel.top)];
        [_innateAbilityContainerView addSubview:_agilityLabel];
        
        _strategyLabel = [UILabel labelWithFontSize:14];
        _strategyLabel.text = @"谋 略：";
        [_strategyLabel sizeToFitAndSetPoint:CGPointMake(_corageLabel.left, _corageLabel.bottom + c_f_padding)];
        [_innateAbilityContainerView addSubview:_strategyLabel];
        
        _eqLabel = [UILabel labelWithFontSize:14];
        _eqLabel.text = @"情 商：";
        [_eqLabel sizeToFitAndSetPoint:CGPointMake(_innateAbilityContainerView.width / 3, _strategyLabel.top)];
        [_innateAbilityContainerView addSubview:_eqLabel];
        
        _goodnessLabel = [UILabel labelWithFontSize:14];
        _goodnessLabel.text = @"善 良：";
        [_goodnessLabel sizeToFitAndSetPoint:CGPointMake(_innateAbilityContainerView.width / 3 * 2, _strategyLabel.top)];
        [_innateAbilityContainerView addSubview:_goodnessLabel];
        
        //后天Tab
        _acquiredContainerView = [[UIView alloc] initWithFrame:CGRectMake(c_f_padding, 0, _innateContainerView.width, 0)];
        _acquiredContainerView.backgroundColor = [UIColor clearColor];
        [_acquiredContainerView borderStyle];
        [self.contentView addSubview:_acquiredContainerView];
        
        _acquiredAbilityCaption = [UILabel captionWithText:@"== 能 力 ==" fontSize:14];
        [_acquiredAbilityCaption sizeToFitAndSetPoint:CGPointMake(c_f_padding, c_f_padding)];
        [_acquiredContainerView addSubview:_acquiredAbilityCaption];
        
        //后天能力
        _acquiredAbilityContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, _acquiredAbilityCaption.bottom, _acquiredContainerView.width, 0)];
        _acquiredAbilityContainerView.backgroundColor = [UIColor clearColor];
        [_acquiredContainerView addSubview:_acquiredAbilityContainerView];
        
        _combatLabel = [UILabel labelWithFontSize:14];
        _combatLabel.text = @"战 斗：";
        [_combatLabel sizeToFitAndSetPoint:CGPointMake(c_f_padding, c_f_padding)];
        [_acquiredAbilityContainerView addSubview:_combatLabel];
        
        _shootingLabel = [UILabel labelWithFontSize:14];
        _shootingLabel.text = @"射 击：";
        [_shootingLabel sizeToFitAndSetPoint:CGPointMake(_acquiredAbilityContainerView.width / 3, _combatLabel.top)];
        [_acquiredAbilityContainerView addSubview:_shootingLabel];
        
        _survivalLabel = [UILabel labelWithFontSize:14];
        _survivalLabel.text = @"生 存：";
        [_survivalLabel sizeToFitAndSetPoint:CGPointMake(_acquiredAbilityContainerView.width / 3 * 2, _combatLabel.top)];
        [_acquiredAbilityContainerView addSubview:_survivalLabel];
        
        _logisticsLabel = [UILabel labelWithFontSize:14];
        _logisticsLabel.text = @"后 勤：";
        [_logisticsLabel sizeToFitAndSetPoint:CGPointMake(_combatLabel.left, _combatLabel.bottom + c_f_padding)];
        [_acquiredAbilityContainerView addSubview:_logisticsLabel];
        
        _acquiredAbilityContainerView.height = _logisticsLabel.bottom + c_f_padding;
        
        _skillCaption = [UILabel captionWithText:@"== 技 能 ==" fontSize:14];
        [_skillCaption sizeToFitAndSetPoint:CGPointMake(_acquiredAbilityCaption.left, _acquiredAbilityContainerView.bottom)];
        [_acquiredContainerView addSubview:_skillCaption];
        
        //后天技能
        _skillContainerView = [[UIView alloc] initWithFrame:CGRectMake(_nameLabel.left, 0, 0, 0)];
        _skillContainerView.backgroundColor = [UIColor clearColor];
        [_acquiredContainerView addSubview:_skillContainerView];
    }
    return self;
}

- (void)showWithSurvivorId:(NSString *)survivorId {
    
    _survivor = (Survivor *)[Survivor entityWithId:survivorId];
    
    _nameLabel.text = _survivor.name;
    [_nameLabel sizeToFit];
    
    _nameLine.top = _nameLabel.bottom + c_f_padding;
    
    _innateContainerView.top = _nameLine.bottom + c_f_padding;
    _innateContainerView.height = self.contentView.height - _innateContainerView.top - c_f_padding;
    
    _acquiredContainerView.frame = _innateContainerView.frame;
    
    _innateTabButton.left = _innateContainerView.right;
    _innateTabButton.top = _innateContainerView.top;
    _acquiredTabButton.left = _acquiredContainerView.right;
    _acquiredTabButton.top = _innateTabButton.bottom;
    
    _innateInfoContainerView.height = _avatarImageView.bottom;
    
    //先天信息
    _avatarImageView.image = [UIImage imageNamed:[_survivor property:k_avatar]];
    [_ageLabel setTextAndSizeToFit:[NSString stringWithFormat:@"%@：%li", [Utility textForKey:k_age], [_survivor intProperty:k_age]]];
    [_genderLabel setTextAndSizeToFit:[NSString stringWithFormat:@"%@：%@", [Utility textForKey:k_gender], _survivor.genderText]];
    [_burdenLabel setTextAndSizeToFit:[NSString stringWithFormat:@"%@：%.1f kg", [Utility textForKey:k_burden], _survivor.burden]];
    
    [_corageLabel setTextAndSizeToFit:[NSString stringWithFormat:@"%@：%li", [Utility textForKey:k_courage], [_survivor intProperty:k_courage]]];
    [_strengthLabel setTextAndSizeToFit:[NSString stringWithFormat:@"%@：%li", [Utility textForKey:k_strength], [_survivor intProperty:k_strength]]];
    [_agilityLabel setTextAndSizeToFit:[NSString stringWithFormat:@"%@：%li", [Utility textForKey:k_agility], [_survivor intProperty:k_agility]]];
    [_strategyLabel setTextAndSizeToFit:[NSString stringWithFormat:@"%@：%li", [Utility textForKey:k_strategy], [_survivor intProperty:k_strategy]]];
    [_eqLabel setTextAndSizeToFit:[NSString stringWithFormat:@"%@：%li", [Utility textForKey:k_eq], [_survivor intProperty:k_eq]]];
    [_goodnessLabel setTextAndSizeToFit:[NSString stringWithFormat:@"%@：%li", [Utility textForKey:k_goodness], [_survivor intProperty:k_goodness]]];
    
    [_combatLabel setTextAndSizeToFit:[NSString stringWithFormat:@"%@：%li", [Utility textForKey:k_combat], [_survivor intProperty:k_combat]]];
    [_shootingLabel setTextAndSizeToFit:[NSString stringWithFormat:@"%@：%li", [Utility textForKey:k_shooting], [_survivor intProperty:k_shooting]]];
    [_survivalLabel setTextAndSizeToFit:[NSString stringWithFormat:@"%@：%li", [Utility textForKey:k_survival], [_survivor intProperty:k_survival]]];
    [_logisticsLabel setTextAndSizeToFit:[NSString stringWithFormat:@"%@：%li", [Utility textForKey:k_logistics], [_survivor intProperty:k_logistics]]];
    
    [super show];
    
    [self innateTabButtonClicked];
}

- (void)innateTabButtonClicked {
    
    _innateTabButton.selected = YES;
    _acquiredTabButton.selected = NO;
    
    _innateContainerView.hidden = NO;
    _acquiredContainerView.hidden = YES;
}

- (void)acquiredTabButtonClicked {
    
    _innateTabButton.selected = NO;
    _acquiredTabButton.selected = YES;
    
    _innateContainerView.hidden = YES;
    _acquiredContainerView.hidden = NO;
}

@end
