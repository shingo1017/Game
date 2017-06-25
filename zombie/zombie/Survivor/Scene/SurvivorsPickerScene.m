//
//  SurvivorsPickerScene.m
//  zombie
//
//  Created by 尹楠 on 17/5/26.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "SurvivorsPickerScene.h"
#import "GridView.h"
#import "SurvivorInfoScene.h"

@interface SurvivorsPickerScene () <GridViewDelegate> {
    
    UILabel *_nameLabel;
    UIView *_nameLine;
    GridView *_survivorsGridView;
    UILabel *_placeConsumableLabel;
    UILabel *_survivorConsumableLabel;
    Button *_confirmButton;
    
    NSMutableArray *_survivors;
    NSDictionary *_placeConsumables;
    NSDictionary *_survivorConsumables;
    
    void (^_completion)(NSArray *selectedSurvivors);
}

@end

@implementation SurvivorsPickerScene



- (id)init {
    
    self = [super init];
    if (self) {
        
        self.contentView.frame = CGRectMake((SCREEN_WIDTH - 600) / 2, (SCREEN_HEIGHT - 350) / 2, 600, 350);
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(c_f_padding, 20, 0, 20)];
        _nameLabel.font = [UIFont systemFontOfSize:20.0f];
        _nameLabel.textColor = WHITE_COLOR;
        [self.contentView addSubview:_nameLabel];
        
        _nameLine = [[UIView alloc] initWithFrame:CGRectMake(_nameLabel.left, _nameLabel.bottom + c_f_padding, self.contentView.width - _nameLabel.left * 2, 1)];
        _nameLine.backgroundColor = WHITE_COLOR;
        [self.contentView addSubview:_nameLine];
        
        _survivorsGridView = [[GridView alloc] initWithFrame:CGRectMake(_nameLine.left, _nameLine.bottom + c_f_padding, self.contentView.width - _nameLabel.left * 2, self.contentView.height - _nameLine.bottom - c_f_padding - self.closeButton.height - c_f_padding * 2) style:UITableViewStyleGrouped];
        _survivorsGridView.gridViewDelegate = self;
        [self.contentView addSubview:_survivorsGridView];
        
        _placeConsumableLabel = [UILabel labelWithFontSize:12];
        _placeConsumableLabel.frame = CGRectMake(_nameLabel.left, _survivorsGridView.bottom + 5, 0, 12);
        [self.contentView addSubview:_placeConsumableLabel];
        
        _survivorConsumableLabel = [UILabel labelWithFontSize:12];
        _survivorConsumableLabel.frame = CGRectMake(_nameLabel.left, 0, 0, 12);
        [self.contentView addSubview:_survivorConsumableLabel];
        
        _confirmButton = [Button buttonWithTitle:@"确认"];
        _confirmButton.frame = CGRectMake(0, 0, self.closeButton.width, self.closeButton.height);
        [_confirmButton addTarget:self action:@selector(confirmButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_confirmButton];
        
        _survivors = [NSMutableArray new];
    }
    return self;
}

- (void)showWithTitleKeys:(NSArray *)titleKeys completion:(void (^)(NSArray<Survivor *> *))completion {
    
    _survivorsGridView.doneWhenSelect = YES;
    
    [self showWithPickNumberOfSurvivors:1
                              titleKeys:titleKeys
                       placeConsumables:nil
                    survivorConsumables:nil
                             completion:completion];
}

- (void)showWithPickNumberOfSurvivors:(NSInteger)numberOfSurvivors
                            titleKeys:(NSArray *)titleKeys
                           completion:(void (^)(NSArray<Survivor *> *))completion {
    
    [self showWithPickNumberOfSurvivors:numberOfSurvivors
                              titleKeys:titleKeys
                       placeConsumables:nil
                    survivorConsumables:nil
                             completion:completion];
}

- (void)showWithPickNumberOfSurvivors:(NSInteger)numberOfSurvivors
                            titleKeys:(NSArray *)titleKeys
                     placeConsumables:(NSDictionary *)placeConsumables
                  survivorConsumables:(NSDictionary *)survivorConsumables
                           completion:(void (^)(NSArray<Survivor *> *))completion {
    
    _completion = completion;
    
    if (numberOfSurvivors == 1)
        [_nameLabel setTextAndSizeToFit:@"选择幸存者"];
    else
        [_nameLabel setTextAndSizeToFit:[NSString stringWithFormat:@"选择1~%li名幸存者", numberOfSurvivors]];
    
    //按照第二列倒序排序
    _survivors = [NSMutableArray arrayWithArray:[[PlaceScene sharedScene].place.survivors sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        NSString *sortKey = titleKeys[1];
        
        Survivor *survivor1 = obj1;
        Survivor *survivor2 = obj2;
        
        NSNumber *sort1 = @([survivor1 intProperty:sortKey]);
        NSNumber *sort2 = @([survivor2 intProperty:sortKey]);
        
        NSComparisonResult result = [sort2 compare:sort1];
        
        return result == NSOrderedDescending;
    }]];
    
    _placeConsumables = placeConsumables;
    _survivorConsumables = survivorConsumables;
    
    NSMutableArray *titles = [NSMutableArray new];
    for (NSString *titleKey in titleKeys) {
        
        [titles addObject:[Utility textForKey:titleKey]];
    }
    
    NSMutableArray *texts = [NSMutableArray new];
    NSMutableArray *colors = [NSMutableArray new];
    for (Survivor *survivor in _survivors) {
        
        NSMutableArray *tempTexts = [NSMutableArray new];
        NSMutableArray *tempColors = [NSMutableArray new];
        for (NSString *titleKey in titleKeys) {
            
            if ([titleKey isEqualToString:k_name])
                [tempTexts addObject:survivor.name];
            else if ([titleKey isEqualToString:k_status])
                [tempTexts addObject:survivor.statusText];
            else if ([titleKey isEqualToString:k_gender])
                [tempTexts addObject:survivor.genderText];
            else if ([titleKey isEqualToString:k_stamina]) {
                
                NSString *staminaText;
                NSInteger stamina = [survivor intProperty:titleKey];
                if (stamina < 20)
                    staminaText = [NSString stringWithFormat:@"%li 过低", stamina];
                else if (stamina < 40)
                    staminaText = [NSString stringWithFormat:@"%li 不足", stamina];
                else
                    staminaText = FLOAT02String(stamina);
                
                [tempTexts addObject:staminaText];
            }
            else
                [tempTexts addObject:FLOAT02String([survivor intProperty:titleKey])];
            
            if ([titleKey isEqualToString:k_stamina]) {
                
                UIColor *staminaColor;
                NSInteger stamina = [survivor intProperty:titleKey];
                if (stamina < 20)
                    staminaColor = RED_VALUE_COLOR;
                else if (stamina < 40)
                    staminaColor = YELLOW_VALUE_COLOR;
                else
                    staminaColor = WHITE_COLOR;
                
                [tempColors addObject:staminaColor];
            }
            else
                [tempColors addObject:WHITE_COLOR];
        }
        [texts addObject:tempTexts];
        [colors addObject:tempColors];
    }
    
    _survivorsGridView.maxSelectionCount = numberOfSurvivors;
    _survivorsGridView.titles = titles;
    _survivorsGridView.dataRows = texts;
    _survivorsGridView.colors = colors;
    
    if (_survivorsGridView.doneWhenSelect) {
        
        _confirmButton.hidden = YES;
    }
    else {
        
        _confirmButton.bottom = self.contentView.height - c_f_padding;
        _confirmButton.right = self.contentView.width - self.closeButton.width - c_f_padding * 2;
        _confirmButton.hidden = NO;
    }
    
    [self show];
    
    //系统推荐适合幸存者
    if (!_survivorsGridView.doneWhenSelect && _survivors.count > 0) {
        
        [_survivorsGridView.selectedIndexSet addIndex:0];
        [_survivorsGridView reloadData];
    }
    
    [self reloadConsumable];
}

- (void)reloadConsumable {
    
    if (_placeConsumables) {
        
        NSMutableAttributedString *feifConsumablesText = [[NSMutableAttributedString alloc] initWithString:@"领地消耗："];
        NSInteger selectedCount = _survivorsGridView.selectedIndexSet.count;
        for (NSString *key in _placeConsumables) {
            
            NSInteger inventory = [[PlaceScene sharedScene].place intProperty:key];
            NSInteger consumableAmount = selectedCount * [_placeConsumables[key] integerValue];
            if (inventory < consumableAmount) {
            
                _confirmButton.enabled = NO;
            }
            else {
                
                _confirmButton.enabled = YES;
            }
            
            NSString *text = [NSString stringWithFormat:@"%@%@ ", @(consumableAmount), [Utility textForKey:key]];
            UIColor *color = _confirmButton.enabled ? WHITE_COLOR : RED_VALUE_COLOR;
            NSAttributedString *consumableText = [[NSAttributedString alloc] initWithString:text attributes:@{NSForegroundColorAttributeName : color}];
            [feifConsumablesText appendAttributedString:consumableText];
        }
        
        _placeConsumableLabel.attributedText = feifConsumablesText;
        [_placeConsumableLabel sizeToFit];
    }
    else {
        
        _placeConsumableLabel.hidden = YES;
    }
    
    if (_survivorConsumables) {
    
        NSMutableAttributedString *survivorConsumablesText = [[NSMutableAttributedString alloc] initWithString:@"每名幸存者消耗："];
        for (NSString *key in _survivorConsumables) {
            
            NSInteger consumableAmount = [_survivorConsumables[key] integerValue];
            
            NSString *text = [NSString stringWithFormat:@"%@%@ ", @(consumableAmount), [Utility textForKey:key]];
            NSAttributedString *consumableText = [[NSAttributedString alloc] initWithString:text attributes:@{NSForegroundColorAttributeName : WHITE_COLOR}];
            [survivorConsumablesText appendAttributedString:consumableText];
        }
        
        _survivorConsumableLabel.attributedText = survivorConsumablesText;
        [_survivorConsumableLabel sizeToFit];
        
        if (_placeConsumableLabel.hidden)
            _survivorConsumableLabel.top = _survivorsGridView.bottom + c_f_padding * 2;
        else
            _survivorConsumableLabel.top = _placeConsumableLabel.bottom + 5;
    }
    
    _confirmButton.enabled = _survivorsGridView.selectedIndexSet.count > 0;
}

- (void)confirmButtonClicked {
    
    if (_completion) {
        
        NSArray *survivors = [_survivors objectsAtIndexes:_survivorsGridView.selectedIndexSet];
        _completion(survivors);
    }
    
    [self hide];
}

#pragma mark GridViewDelegate

- (BOOL)gridView:(GridView *)gridView shouldEnableRow:(NSInteger)row {
    
    if (!gridView.doneWhenSelect) {
        
        Survivor *survivor = _survivors[row];
        
        NSString *excutiveClassName = [survivor property:k_excutiveClassName];
        if (!excutiveClassName || excutiveClassName.length == 0)
            return YES;
        else
            return NO;
    }
    else
        return YES;
}

- (void)gridView:(GridView *)gridView didSelectedRow:(NSInteger)row {
    
    [self reloadConsumable];
    
    if (_survivorsGridView.doneWhenSelect && _completion)
        _completion(@[self->_survivors[row]]);
}

@end
