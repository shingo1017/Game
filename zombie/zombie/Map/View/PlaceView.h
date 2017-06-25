//
//  PlaceView.h
//  zombie
//
//  Created by 尹楠 on 17/6/10.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Place.h"

@protocol PlaceViewDelegate;

typedef NS_ENUM(NSInteger, PlaceSelectionState) {
    
    PlaceSelectionStateDefault,
    PlaceSelectionStateHighlight,
    PlaceSelectionStateDisabled,
};

@interface PlaceView : UIView

@property (nonatomic, assign) PlaceSelectionState selectionState;
@property (nonatomic, strong, readonly) Place *place;
@property (nonatomic, weak) id<PlaceViewDelegate> delegate;

+ (PlaceView *)newForPlace:(Place *)place atCoordinate:(CGPoint)coordinate;

- (void)twinkle;
- (void)stopTwinkle;

@end

@protocol PlaceViewDelegate <NSObject>

@optional

- (void)placeView:(PlaceView *)placeView didSelectedPlace:(Place *)place;

@end
