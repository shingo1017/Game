//
//  MoveConfirmationScene.m
//  zombie
//
//  Created by 尹楠 on 17/6/14.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "MoveConfirmationScene.h"
#import "OutsideAction.h"

@interface MoveConfirmationScene () {
    
    UILabel *_targetPlaceNameLabel;
    UILabel *_foodConsumptionLabel;
    UILabel *_waterConsumptionLabel;
    Button *_confirmButton;
    
    void (^_completion)(BOOL isConfirmed);
}

@end

@implementation MoveConfirmationScene

- (id)init {
    
    self = [super init];
    if (self) {
        
        self.contentView.frame = CGRectMake((SCREEN_WIDTH - 300) / 2, (SCREEN_HEIGHT - 200) / 2, 300, 200);
        
        _targetPlaceNameLabel = [UILabel labelWithFontSize:13];
        _targetPlaceNameLabel.frame = CGRectMake(c_f_padding, c_f_padding, self.contentView.width - c_f_padding * 2, 13);
        [self.contentView addSubview:_targetPlaceNameLabel];
        
        _foodConsumptionLabel = [UILabel labelWithFontSize:13];
        _foodConsumptionLabel.frame = CGRectMake(_targetPlaceNameLabel.left, _targetPlaceNameLabel.bottom + c_f_padding, _targetPlaceNameLabel.width, 13);
        [self.contentView addSubview:_foodConsumptionLabel];
        
        _waterConsumptionLabel = [UILabel labelWithFontSize:13];
        _waterConsumptionLabel.frame = CGRectMake(_targetPlaceNameLabel.left, _foodConsumptionLabel.bottom + c_f_padding, _targetPlaceNameLabel.width, 13);
        [self.contentView addSubview:_waterConsumptionLabel];
        
        _confirmButton = [Button buttonWithTitle:@"确定迁移"];
        _confirmButton.frame = CGRectMake(self.contentView.width - self.closeButton.width * 2 - c_f_padding * 2, self.contentAvailableSize.height + c_f_padding, self.closeButton.width, self.closeButton.height);
        [_confirmButton addTarget:self action:@selector(confirmButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_confirmButton];
    }
    return self;
}

- (void)showWithTargetPlaceId:(NSString *)targetPlaceId completion:(void (^)(BOOL))completion {
    
    _completion = completion;
    
    Place *targetPlace = (Place *)[Place entityWithId:targetPlaceId];
    
    _targetPlaceNameLabel.text = [NSString stringWithFormat:@"迁移目的地：%@", targetPlace.name];
    
    _foodConsumptionLabel.text = [NSString stringWithFormat:@"预计%@消耗：%li", [Utility textForKey:k_food], [OutsideMoveAction foodConsumption]];
    _waterConsumptionLabel.text = [NSString stringWithFormat:@"预计%@消耗：%li", [Utility textForKey:k_water], [OutsideMoveAction waterConsumption]];
    
    [self show];
}

- (void)confirmButtonClicked {
    
    if (_completion)
        _completion(YES);
    
    [super hide];
}

- (void)hide {
    
    if (_completion)
        _completion(NO);
    
    [super hide];
}

@end
