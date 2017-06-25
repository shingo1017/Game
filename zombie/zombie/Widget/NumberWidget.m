//
//  NumberWidget.m
//  seller
//
//  Created by Shingo on 13-3-16.
//  Copyright (c) 2013年 Shingo. All rights reserved.
//

#import "NumberWidget.h"

@interface NumberWidget () {
    
    UITextField *_numberText;
    UIButton *_addButton;
    UIButton *_reduceButton;
}

@end

@implementation NumberWidget

@synthesize number = _number;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self borderStyle];
        [self cornerRadiusStyle];
    }
    return self;
}

- (void)setNumber:(CGFloat)number {
    
    _number = number;
    
    if (_number) {
        
        if (_numberType == NumberTypeInt)
            _numberText.text = [NSString stringWithFormat:@"%i", (int)_number];
        else if (_numberType == NumberTypeFloat)
            _numberText.text = [NSString stringWithFormat:@"%.2f", _number];
    }
}

- (CGFloat)number {
    
    if (_numberText.text.length == 0)
        _number = 0;
    else
        _number = [_numberText.text floatValue];
    
    return _number;
}

- (void)setPlaceholder:(NSString *)placeholder {
    
    _numberText.placeholder = placeholder;
}

- (void)setNumberType:(NumberType)numberType {
    
    _numberType = numberType;
    
    if (_numberType == NumberTypeInt)
        _numberText.keyboardType = UIKeyboardTypeNumberPad;
    else if (_numberType == NumberTypeFloat)
        _numberText.keyboardType = UIKeyboardTypeDecimalPad;
}

- (void)setEmpty:(BOOL)empty {
    
    _numberText.text = @"";
}

- (BOOL)empty {
    
    return _numberText.text.length == 0;
}

- (void)setFocus:(BOOL)focus {
    
    if (focus)
        [_numberText becomeFirstResponder];
    else
        [_numberText resignFirstResponder];
}

- (void)setEditable:(BOOL)editable {
    
    _editable = editable;
    
    _numberText.enabled = _editable;
    _addButton.enabled = _editable;
    _reduceButton.enabled = _editable;
    
    if (_editable)
        _numberText.textColor = [UIColor darkGrayColor];
    else
        _numberText.textColor = [UIColor lightGrayColor];
}

- (void)numberEditChange:(id)sender {
    
    if (_delegate && [_delegate respondsToSelector:@selector(editDidChange:)])
        [_delegate editDidChange:self];
}

- (void)numberEditEnd:(id)sender {
    
    if (_delegate && [_delegate respondsToSelector:@selector(editDidEnd:)])
        [_delegate editDidEnd:self];
}

- (void)numberAddButtonClicked:(id)sender {
    
    _number = [_numberText.text intValue] + 1;
    if (_numberType == NumberTypeInt)
        _numberText.text = [NSString stringWithFormat:@"%i", (int)_number];
    else if (_numberType == NumberTypeFloat)
        _numberText.text = [NSString stringWithFormat:@"%.2f", _number];
    
    if (_delegate && [_delegate respondsToSelector:@selector(editDidEnd:)])
        [_delegate editDidEnd:self];
}

- (void)numberReduceButtonClicked:(id)sender {
    
    _number = [_numberText.text intValue] - 1;
    if (_numberType == NumberTypeInt)
        _numberText.text = [NSString stringWithFormat:@"%i", (int)_number];
    else if (_numberType == NumberTypeFloat)
        _numberText.text = [NSString stringWithFormat:@"%.2f", _number];
    
    if (_delegate && [_delegate respondsToSelector:@selector(editDidEnd:)])
        [_delegate editDidEnd:self];
}

@end
