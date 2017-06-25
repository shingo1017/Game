//
//  ResourceReorganizationScene.m
//  zombie
//
//  Created by 尹楠 on 17/6/14.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "ResourceReorganizationScene.h"
#import "OutsideAction.h"
#import "HelpButton.h"
#import "CommonHelpScene.h"

@interface ResourceReorganizationScene () {
    
    UILabel *_nameLabel;
    UIView *_nameLine;
    HelpButton *_helpButton;
    
    UILabel *_burdenLabel;
    
    UILabel *_foodCaption;
    UILabel *_foodLeaveLabel;
    UISlider *_foodSlider;
    UILabel *_foodTakeLabel;
    CGFloat _foodMaxValue;
    
    UILabel *_waterCaption;
    UILabel *_waterLeaveLabel;
    UISlider *_waterSlider;
    UILabel *_waterTakeLabel;
    CGFloat _waterMaxValue;
    
    UILabel *_materialCaption;
    UILabel *_materialLeaveLabel;
    UISlider *_materialSlider;
    UILabel *_materialTakeLabel;
    CGFloat _materialMaxValue;
    
    UILabel *_medicineCaption;
    UILabel *_medicineLeaveLabel;
    UISlider *_medicineSlider;
    UILabel *_medicineTakeLabel;
    CGFloat _medicineMaxValue;
    
    UILabel *_ammunitionCaption;
    UILabel *_ammunitionLeaveLabel;
    UISlider *_ammunitionSlider;
    UILabel *_ammunitionTakeLabel;
    CGFloat _ammunitionMaxValue;
    
    Button *_confirmButton;
    
    void (^_completion)(BOOL, NSDictionary *);
}

@end

@implementation ResourceReorganizationScene

- (id)init {
    
    self = [super init];
    if (self) {
        
        self.contentView.frame = CGRectMake((SCREEN_WIDTH - 500) / 2, (SCREEN_HEIGHT - 350) / 2, 500, 350);
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(c_f_padding, 20, 0, 20)];
        _nameLabel.font = [UIFont systemFontOfSize:20.0f];
        _nameLabel.textColor = WHITE_COLOR;
        [self.contentView addSubview:_nameLabel];
        
        _nameLine = [[UIView alloc] initWithFrame:CGRectMake(_nameLabel.left, _nameLabel.bottom + c_f_padding, self.contentView.width - _nameLabel.left * 2, 1)];
        _nameLine.backgroundColor = WHITE_COLOR;
        [self.contentView addSubview:_nameLine];
        
        _helpButton = [[HelpButton alloc] initWithText:@"资源负重说明" helpbuttonClicked:^{
            
            CommonHelpScene *commonHelpScene = [CommonHelpScene new];
            [commonHelpScene showWithText:[NSString stringWithFormat:@"1 %@ = 0.5 kg\r\n1 %@ = 1 kg\r\n1 %@ = 2 kg\r\n1 %@ = 0.01 kg\r\n1 %@ = 0.01 kg", [Utility textForKey:k_food], [Utility textForKey:k_water], [Utility textForKey:k_material], [Utility textForKey:k_medicine], [Utility textForKey:k_ammunition]]];
        }];
        _helpButton.right = _nameLine.right;
        _helpButton.bottom = _nameLine.top - 5;
        [self.contentView addSubview:_helpButton];
        
        _burdenLabel = [UILabel labelWithFontSize:13];
        _burdenLabel.frame = CGRectMake(_nameLabel.left, _nameLine.bottom + c_f_padding * 2, _nameLine.width, 13);
        [self.contentView addSubview:_burdenLabel];
        
        //食物
        _foodCaption = [UILabel captionWithText:[Utility textForKey:k_food] fontSize:13];
        _foodCaption.frame = CGRectMake(_nameLabel.left, _burdenLabel.bottom + c_f_padding, _nameLine.width, 33);
        [self.contentView addSubview:_foodCaption];
        
        _foodLeaveLabel = [UILabel labelWithFontSize:11];
        _foodLeaveLabel.numberOfLines = 2;
        _foodLeaveLabel.textAlignment = NSTextAlignmentRight;
        _foodLeaveLabel.frame = CGRectMake(_nameLabel.left + 50, _foodCaption.top, 60, 33);
        [self.contentView addSubview:_foodLeaveLabel];
        
        _foodSlider = [[UISlider alloc] initWithFrame:CGRectMake(_nameLabel.left + 120, _foodCaption.top, _nameLine.width - 120 - 60, 33)];
        [_foodSlider addTarget:self action:@selector(sliderTouchDown:) forControlEvents:UIControlEventTouchDown];
        [_foodSlider addTarget:self action:@selector(foodSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        [self.contentView addSubview:_foodSlider];
        
        _foodTakeLabel = [UILabel labelWithFontSize:11];
        _foodTakeLabel.numberOfLines = 2;
        _foodTakeLabel.frame = CGRectMake(_foodSlider.right + c_f_padding, _foodCaption.top, 60, 33);
        [self.contentView addSubview:_foodTakeLabel];
        
        //饮用水
        _waterCaption = [UILabel captionWithText:[Utility textForKey:k_water] fontSize:13];
        _waterCaption.frame = CGRectMake(_nameLabel.left, _foodCaption.bottom + c_f_padding, _nameLine.width, 33);
        [self.contentView addSubview:_waterCaption];
        
        _waterLeaveLabel = [UILabel labelWithFontSize:11];
        _waterLeaveLabel.numberOfLines = 2;
        _waterLeaveLabel.textAlignment = NSTextAlignmentRight;
        _waterLeaveLabel.frame = CGRectMake(_nameLabel.left + 50, _waterCaption.top, 60, 33);
        [self.contentView addSubview:_waterLeaveLabel];
        
        _waterSlider = [[UISlider alloc] initWithFrame:CGRectMake(_nameLabel.left + 120, _waterCaption.top, _nameLine.width - 120 - 60, 33)];
        [_waterSlider addTarget:self action:@selector(sliderTouchDown:) forControlEvents:UIControlEventTouchDown];
        [_waterSlider addTarget:self action:@selector(waterSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        [self.contentView addSubview:_waterSlider];
        
        _waterTakeLabel = [UILabel labelWithFontSize:11];
        _waterTakeLabel.numberOfLines = 2;
        _waterTakeLabel.frame = CGRectMake(_waterSlider.right + c_f_padding, _waterCaption.top, 60, 33);
        [self.contentView addSubview:_waterTakeLabel];
        
        //建材
        _materialCaption = [UILabel captionWithText:[Utility textForKey:k_material] fontSize:13];
        _materialCaption.frame = CGRectMake(_nameLabel.left, _waterCaption.bottom + c_f_padding, _nameLine.width, 33);
        [self.contentView addSubview:_materialCaption];
        
        _materialLeaveLabel = [UILabel labelWithFontSize:11];
        _materialLeaveLabel.numberOfLines = 2;
        _materialLeaveLabel.textAlignment = NSTextAlignmentRight;
        _materialLeaveLabel.frame = CGRectMake(_nameLabel.left + 50, _materialCaption.top, 60, 33);
        [self.contentView addSubview:_materialLeaveLabel];
        
        _materialSlider = [[UISlider alloc] initWithFrame:CGRectMake(_nameLabel.left + 120, _materialCaption.top, _nameLine.width - 120 - 60, 33)];
        [_materialSlider addTarget:self action:@selector(sliderTouchDown:) forControlEvents:UIControlEventTouchDown];
        [_materialSlider addTarget:self action:@selector(materialSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        [self.contentView addSubview:_materialSlider];
        
        _materialTakeLabel = [UILabel labelWithFontSize:11];
        _materialTakeLabel.numberOfLines = 2;
        _materialTakeLabel.frame = CGRectMake(_materialSlider.right + c_f_padding, _materialCaption.top, 60, 33);
        [self.contentView addSubview:_materialTakeLabel];
        
        //药品
        _medicineCaption = [UILabel captionWithText:[Utility textForKey:k_medicine] fontSize:13];
        _medicineCaption.frame = CGRectMake(_nameLabel.left, _materialCaption.bottom + c_f_padding, _nameLine.width, 33);
        [self.contentView addSubview:_medicineCaption];
        
        _medicineLeaveLabel = [UILabel labelWithFontSize:11];
        _medicineLeaveLabel.numberOfLines = 2;
        _medicineLeaveLabel.textAlignment = NSTextAlignmentRight;
        _medicineLeaveLabel.frame = CGRectMake(_nameLabel.left + 50, _medicineCaption.top, 60, 33);
        [self.contentView addSubview:_medicineLeaveLabel];
        
        _medicineSlider = [[UISlider alloc] initWithFrame:CGRectMake(_nameLabel.left + 120, _medicineCaption.top, _nameLine.width - 120 - 60, 33)];
        [_medicineSlider addTarget:self action:@selector(sliderTouchDown:) forControlEvents:UIControlEventTouchDown];
        [_medicineSlider addTarget:self action:@selector(medicineSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        [self.contentView addSubview:_medicineSlider];
        
        _medicineTakeLabel = [UILabel labelWithFontSize:11];
        _medicineTakeLabel.numberOfLines = 2;
        _medicineTakeLabel.frame = CGRectMake(_medicineSlider.right + c_f_padding, _medicineCaption.top, 60, 33);
        [self.contentView addSubview:_medicineTakeLabel];
        
        //弹药
        _ammunitionCaption = [UILabel captionWithText:[Utility textForKey:k_ammunition] fontSize:13];
        _ammunitionCaption.frame = CGRectMake(_nameLabel.left, _medicineCaption.bottom + c_f_padding, _nameLine.width, 33);
        [self.contentView addSubview:_ammunitionCaption];
        
        _ammunitionLeaveLabel = [UILabel labelWithFontSize:11];
        _ammunitionLeaveLabel.numberOfLines = 2;
        _ammunitionLeaveLabel.textAlignment = NSTextAlignmentRight;
        _ammunitionLeaveLabel.frame = CGRectMake(_nameLabel.left + 50, _ammunitionCaption.top, 60, 33);
        [self.contentView addSubview:_ammunitionLeaveLabel];
        
        _ammunitionSlider = [[UISlider alloc] initWithFrame:CGRectMake(_nameLabel.left + 120, _ammunitionCaption.top, _nameLine.width - 120 - 60, 33)];
        [_ammunitionSlider addTarget:self action:@selector(sliderTouchDown:) forControlEvents:UIControlEventTouchDown];
        [_ammunitionSlider addTarget:self action:@selector(ammunitionSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        [self.contentView addSubview:_ammunitionSlider];
        
        _ammunitionTakeLabel = [UILabel labelWithFontSize:11];
        _ammunitionTakeLabel.numberOfLines = 2;
        _ammunitionTakeLabel.frame = CGRectMake(_ammunitionSlider.right + c_f_padding, _ammunitionCaption.top, 60, 33);
        [self.contentView addSubview:_ammunitionTakeLabel];
        
        _confirmButton = [Button buttonWithTitle:@"确定分配"];
        _confirmButton.frame = CGRectMake(self.contentView.width - self.closeButton.width * 2 - c_f_padding * 2, self.contentAvailableSize.height + c_f_padding, self.closeButton.width, self.closeButton.height);
        [_confirmButton addTarget:self action:@selector(confirmButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_confirmButton];
    }
    return self;
}

- (void)showForMoveWithCompletion:(void (^)(BOOL, NSDictionary *))completion {
    
    _completion = completion;
    
    [_nameLabel setTextAndSizeToFit:@"负重不足，请调整资源分配"];
    
    Place *place =  [PlaceScene sharedScene].place;
    
    _foodSlider.maximumValue = [place intProperty:k_food];
    _waterSlider.maximumValue = [place intProperty:k_water];
    _materialSlider.maximumValue = [place intProperty:k_material];
    _medicineSlider.maximumValue = [place intProperty:k_medicine];
    _ammunitionSlider.maximumValue = [place intProperty:k_ammunition];
    
    CGFloat totalBurden = place.survivorsBurden;
    _foodSlider.value = [Place foodOfBurden:totalBurden / 2];
    _waterSlider.value = [Place waterOfBurden:totalBurden / 2];
    _materialSlider.value = 0;
    _medicineSlider.value = 0;
    _ammunitionSlider.value = 0;
    
//    _resourceBurdenExampleLabel.text = [NSString stringWithFormat:@"%@：0.5 kg  %@：1 kg  %@：2 kg  %@：0.01 kg  %@：0.01 kg", [Utility textForKey:k_food], [Utility textForKey:k_water], [Utility textForKey:k_material], [Utility textForKey:k_medicine], [Utility textForKey:k_ammunition]];
    
    _foodLeaveLabel.text = [NSString stringWithFormat:@"剩余%.0f\r\n%.1f kg", [place intProperty:k_food] - _foodSlider.value, [Place burdenOfFood:[place intProperty:k_food] - _foodSlider.value]];
    _foodTakeLabel.text = [NSString stringWithFormat:@"携带%.0f\r\n%.1f kg", _foodSlider.value, [Place burdenOfFood:_foodSlider.value]];
    _waterLeaveLabel.text = [NSString stringWithFormat:@"剩余%.0f\r\n%.1f kg", [place intProperty:k_water] - _waterSlider.value, [Place burdenOfWater:[place intProperty:k_water] - _waterSlider.value]];
    _waterTakeLabel.text = [NSString stringWithFormat:@"携带%.0f\r\n%.1f kg", _waterSlider.value, [Place burdenOfWater:_waterSlider.value]];
    _materialLeaveLabel.text = [NSString stringWithFormat:@"剩余%.0f\r\n%.1f kg", [place intProperty:k_material] - _materialSlider.value, [Place burdenOfMaterial:[place intProperty:k_material] - _materialSlider.value]];
    _materialTakeLabel.text = [NSString stringWithFormat:@"携带%.0f\r\n%.1f kg", _materialSlider.value, [Place burdenOfMaterial:_materialSlider.value]];
    _medicineLeaveLabel.text = [NSString stringWithFormat:@"剩余%.0f\r\n%.1f kg", [place intProperty:k_medicine] - _medicineSlider.value, [Place burdenOfMedicine:[place intProperty:k_medicine] - _medicineSlider.value]];
    _medicineTakeLabel.text = [NSString stringWithFormat:@"携带%.0f\r\n%.1f kg", _medicineSlider.value, [Place burdenOfMedicine:_medicineSlider.value]];
    _ammunitionLeaveLabel.text = [NSString stringWithFormat:@"剩余%.0f\r\n%.1f kg", [place intProperty:k_ammunition] - _foodSlider.value, [Place burdenOfAmmunition:[place intProperty:k_ammunition] - _ammunitionSlider.value]];
    _ammunitionTakeLabel.text = [NSString stringWithFormat:@"携带%.0f\r\n%.1f kg", _ammunitionSlider.value, [Place burdenOfAmmunition:_ammunitionSlider.value]];
    _burdenLabel.text = [NSString stringWithFormat:@"总%@：%.1f kg  剩余%@：%.1f kg", [Utility textForKey:k_burden], place.survivorsBurden, [Utility textForKey:k_burden], [self remainBurden]];
    
    [super show];
}

- (void)sliderTouchDown:(UISlider *)slider {
    
    if (slider == _foodSlider)
        _foodMaxValue = [self maxWithResourceKey:k_food];
    else if (slider == _waterSlider)
        _waterMaxValue = [self maxWithResourceKey:k_water];
    else if (slider == _materialSlider)
        _materialMaxValue = [self maxWithResourceKey:k_material];
    else if (slider == _medicineSlider)
        _medicineMaxValue = [self maxWithResourceKey:k_medicine];
    else if (slider == _ammunitionSlider)
        _ammunitionMaxValue = [self maxWithResourceKey:k_ammunition];
}

- (void)foodSliderValueChanged:(UISlider *)slider {
    
    Place *place =  [PlaceScene sharedScene].place;
    
    if (_foodSlider.value > _foodMaxValue)
        _foodSlider.value = _foodMaxValue;
    
    _foodLeaveLabel.text = [NSString stringWithFormat:@"剩余%.0f\r\n%.1f kg", [place intProperty:k_food] - _foodSlider.value, [Place burdenOfFood:[place intProperty:k_food] - _foodSlider.value]];
    _foodTakeLabel.text = [NSString stringWithFormat:@"携带%.0f\r\n%.1f kg", _foodSlider.value, [Place burdenOfFood:_foodSlider.value]];
    _burdenLabel.text = [NSString stringWithFormat:@"总%@：%.1f kg  剩余%@：%.1f kg", [Utility textForKey:k_burden], place.survivorsBurden, [Utility textForKey:k_burden], [self remainBurden]];
}

- (void)waterSliderValueChanged:(UISlider *)slider {
    
    Place *place =  [PlaceScene sharedScene].place;
    
    if (_waterSlider.value > _waterMaxValue)
        _waterSlider.value = _waterMaxValue;
        
    _waterLeaveLabel.text = [NSString stringWithFormat:@"剩余%.0f\r\n%.1f kg", [place intProperty:k_water] - _waterSlider.value, [Place burdenOfWater:[place intProperty:k_water] - _waterSlider.value]];
    _waterTakeLabel.text = [NSString stringWithFormat:@"携带%.0f\r\n%.1f kg", _waterSlider.value, [Place burdenOfWater:_waterSlider.value]];
    _burdenLabel.text = [NSString stringWithFormat:@"总%@：%.1f kg  剩余%@：%.1f kg", [Utility textForKey:k_burden], place.survivorsBurden, [Utility textForKey:k_burden], [self remainBurden]];
}

- (void)materialSliderValueChanged:(UISlider *)slider {
    
    Place *place =  [PlaceScene sharedScene].place;
    
    if (_materialSlider.value > _materialMaxValue)
        _materialSlider.value = _materialMaxValue;
        
    _materialLeaveLabel.text = [NSString stringWithFormat:@"剩余%.0f\r\n%.1f kg", [place intProperty:k_material] - _materialSlider.value, [Place burdenOfMaterial:[place intProperty:k_material] - _materialSlider.value]];
    _materialTakeLabel.text = [NSString stringWithFormat:@"携带%.0f\r\n%.1f kg", _materialSlider.value, [Place burdenOfMaterial:_materialSlider.value]];
    _burdenLabel.text = [NSString stringWithFormat:@"总%@：%.1f kg  剩余%@：%.1f kg", [Utility textForKey:k_burden], place.survivorsBurden, [Utility textForKey:k_burden], [self remainBurden]];
}

- (void)medicineSliderValueChanged:(UISlider *)slider {
    
    Place *place =  [PlaceScene sharedScene].place;
    
    if (_medicineSlider.value > _medicineMaxValue)
        _medicineSlider.value = _medicineMaxValue;
        
    _medicineLeaveLabel.text = [NSString stringWithFormat:@"剩余%.0f\r\n%.1f kg", [place intProperty:k_medicine] - _medicineSlider.value, [Place burdenOfMedicine:[place intProperty:k_medicine] - _medicineSlider.value]];
    _medicineTakeLabel.text = [NSString stringWithFormat:@"携带%.0f\r\n%.1f kg", _medicineSlider.value, [Place burdenOfMedicine:_medicineSlider.value]];
    _burdenLabel.text = [NSString stringWithFormat:@"总%@：%.1f kg  剩余%@：%.1f kg", [Utility textForKey:k_burden], place.survivorsBurden, [Utility textForKey:k_burden], [self remainBurden]];
}

- (void)ammunitionSliderValueChanged:(UISlider *)slider {
    
    Place *place =  [PlaceScene sharedScene].place;
    
    if (_ammunitionSlider.value > _ammunitionMaxValue)
        _ammunitionSlider.value = _ammunitionMaxValue;
        
    _ammunitionLeaveLabel.text = [NSString stringWithFormat:@"剩余%.0f\r\n%.1f kg", [place intProperty:k_ammunition] - _foodSlider.value, [Place burdenOfAmmunition:[place intProperty:k_ammunition] - _ammunitionSlider.value]];
    _ammunitionTakeLabel.text = [NSString stringWithFormat:@"携带%.0f\r\n%.1f kg", _ammunitionSlider.value, [Place burdenOfAmmunition:_ammunitionSlider.value]];
    _burdenLabel.text = [NSString stringWithFormat:@"总%@：%.1f kg  剩余%@：%.1f kg", [Utility textForKey:k_burden], place.survivorsBurden, [Utility textForKey:k_burden], [self remainBurden]];
}

- (NSInteger)maxWithResourceKey:(NSString *)key {
    
    Place *place =  [PlaceScene sharedScene].place;
    
    CGFloat totalBurden = [Place burdenOfFood:_foodSlider.value] + [Place burdenOfWater:_waterSlider.value] + [Place burdenOfMaterial:_materialSlider.value] + [Place burdenOfMedicine:_medicineSlider.value] + [Place burdenOfAmmunition:_ammunitionSlider.value];
    NSInteger burdenWithoutKey = 0;
    
    if ([key isEqualToString:k_food])
        burdenWithoutKey = totalBurden - [Place burdenOfFood:_foodSlider.value];
    else if ([key isEqualToString:k_water])
        burdenWithoutKey = totalBurden - [Place burdenOfFood:_waterSlider.value];
    else if ([key isEqualToString:k_material])
        burdenWithoutKey = totalBurden - [Place burdenOfFood:_materialSlider.value];
    else if ([key isEqualToString:k_medicine])
        burdenWithoutKey = totalBurden - [Place burdenOfFood:_medicineSlider.value];
    else
        burdenWithoutKey = totalBurden - [Place burdenOfFood:_ammunitionSlider.value];
    
    CGFloat remainBurden = place.survivorsBurden - burdenWithoutKey;
    NSInteger keyResourceCount = 0;
    
    if (remainBurden > 0) {
        
        if ([key isEqualToString:k_food])
            keyResourceCount = [Place foodOfBurden:remainBurden];
        else if ([key isEqualToString:k_water])
            keyResourceCount = [Place waterOfBurden:remainBurden];
        else if ([key isEqualToString:k_material])
            keyResourceCount = [Place materialOfBurden:remainBurden];
        else if ([key isEqualToString:k_medicine])
            keyResourceCount = [Place medicineOfBurden:remainBurden];
        else
            keyResourceCount = [Place ammunitionOfBurden:remainBurden];
    }
    else
        keyResourceCount = 0;
    
    return keyResourceCount;
}

- (CGFloat)remainBurden {
    
    Place *place =  [PlaceScene sharedScene].place;
    
    CGFloat totalBurden = [Place burdenOfFood:_foodSlider.value] + [Place burdenOfWater:_waterSlider.value] + [Place burdenOfMaterial:_materialSlider.value] + [Place burdenOfMedicine:_medicineSlider.value] + [Place burdenOfAmmunition:_ammunitionSlider.value];
    
    CGFloat remainBurden = place.survivorsBurden - totalBurden;
    if (remainBurden > 0)
        return remainBurden;
    else
        return 0.0;
}

- (void)confirmButtonClicked {
    
    if (_completion)
        _completion(YES, @{
                           k_food : @(_foodSlider.value),
                           k_water : @(_waterSlider.value),
                           k_material : @(_materialSlider.value),
                           k_medicine : @(_medicineSlider.value),
                           k_ammunition : @(_ammunitionSlider.value),
                           });
    
    [super hide];
}

- (void)hide {
    
    if (_completion)
        _completion(NO, nil);
    
    [super hide];
}

@end
