//
//  PlaceView.m
//  zombie
//
//  Created by 尹楠 on 17/6/10.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "PlaceView.h"

@interface PlaceView () {
    
    UILabel *_landformLabel;
    
    Place *_place;
}

//@property (nonatomic, strong,readonly) Place *place;

@end

@implementation PlaceView

//@synthesize place;

+ (PlaceView *)newForPlace:(Place *)place atCoordinate:(CGPoint)coordinate {
    
    PlaceView *placeView = [[PlaceView alloc] initWithFrame:CGRectMake(c_i_placeSize * coordinate.x, c_i_placeSize * coordinate.y, c_i_placeSize, c_i_placeSize)];
    placeView.place = place;
    
    return placeView;
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.selectionState = PlaceSelectionStateDefault;
        [self borderStyle];
        
        _landformLabel = [UILabel labelWithFontSize:14.0f];
        _landformLabel.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        _landformLabel.textAlignment = NSTextAlignmentCenter;
        _landformLabel.numberOfLines = 0;
        [self addSubview:_landformLabel];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    return self;
}

- (Place *)place {
    
    return _place;
}

- (void)setPlace:(Place *)place {
    
    _place = place;
    
    if (_place) {
        
        _landformLabel.text = _place.name;
    }
}

- (void)setSelectionState:(PlaceSelectionState)selectionState {
    
    _selectionState = selectionState;
    
    if (_selectionState == PlaceSelectionStateDefault) {
        
        _landformLabel.userInteractionEnabled = YES;
        
        if ([_place.id isEqualToString:[[Game sharedGame] property:k_myPlaceId]]) {
            
            _landformLabel.backgroundColor = RGBA(220, 220, 220, 1);
            _landformLabel.textColor = BLACK_COLOR;
        }
        else {
            
            _landformLabel.backgroundColor = BLACK_COLOR;
            _landformLabel.textColor = WHITE_COLOR;
        }
    }
    else if (_selectionState == PlaceSelectionStateHighlight) {
        
        _landformLabel.userInteractionEnabled = YES;
        _landformLabel.backgroundColor = WHITE_COLOR;
        _landformLabel.textColor = BLACK_COLOR;
    }
    else if (_selectionState == PlaceSelectionStateDisabled) {
        
        _landformLabel.userInteractionEnabled = NO;
        _landformLabel.backgroundColor = BLACK_COLOR;
        _landformLabel.textColor = WHITE_COLOR;
    }
}

- (void)buttonClicked {
    
    if ([self.delegate respondsToSelector:@selector(placeView:didSelectedPlace:)])
        [self.delegate placeView:self didSelectedPlace:_place];
}

- (void)twinkle {
    
     [self.layer addAnimation:[self opacityForever_Animation:0.5] forKey:@"twinkle"];
}

- ( CABasicAnimation *)opacityForever_Animation:( float )time {
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath : @"opacity" ]; // 必须写 opacity 才行。
    
    animation. fromValue = [ NSNumber numberWithFloat : 1.0f ];
    
    animation. toValue = [ NSNumber numberWithFloat : 0.0f ]; // 这是透明度。
    
    animation. autoreverses = YES ;
    
    animation. duration = time;
    
    animation. repeatCount = MAXFLOAT ;
    
    animation. removedOnCompletion = NO ;
    
    animation. fillMode = kCAFillModeForwards ;
    
//    animation. timingFunction =[ CAMediaTimingFunction functionWithName : kCAMediaTimingFunctionEaseIn ]; /// 没有的话是均匀的动画。
    
    return animation;
    
}

- (void)stopTwinkle {
    
    [self.layer removeAnimationForKey:@"twinkle"];
}

@end
