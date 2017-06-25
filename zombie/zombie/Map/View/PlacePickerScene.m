//
//  PlacePickerScene.m
//  zombie
//
//  Created by 尹楠 on 17/6/14.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "PlacePickerScene.h"
#import "PlaceView.h"
#import "PlaceInfoTableView.h"
#import "MoveConfirmationScene.h"

@interface PlacePickerScene () <PlaceViewDelegate> {
    
    UILabel *_nameLabel;
    UIView *_nameLine;
    
    UIView *_fogView;
    UIScrollView *_mainScrollView;
    UIView *_placeContainerView;
    
    UIView *_infoContainerView;
    UILabel *_infoCaption;
    PlaceInfoTableView *_infoTableView;
    
    NSInteger _distance;
    Place *_formPlace;
    Place *_selectedPlace;
    NSMutableDictionary *_allPlaceViews;
    NSMutableArray<PlaceView *> *_twinklePlaceViews;
    
    Button *_confirmButton;
    
    void (^_completion)(Place *place);
}

@end

@implementation PlacePickerScene

- (id)init {
    
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.contentView.frame = CGRectMake((SCREEN_WIDTH - 600) / 2, (SCREEN_HEIGHT - 350) / 2, 600, 350);
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(c_f_padding, 20, 0, 20)];
        _nameLabel.font = [UIFont systemFontOfSize:20.0f];
        _nameLabel.textColor = WHITE_COLOR;
        [self.contentView addSubview:_nameLabel];
        
        _nameLine = [[UIView alloc] initWithFrame:CGRectMake(_nameLabel.left, _nameLabel.bottom + c_f_padding, self.contentView.width - _nameLabel.left * 2, 1)];
        _nameLine.backgroundColor = WHITE_COLOR;
        [self.contentView addSubview:_nameLine];
        
        CGSize mapSize = CGSizeMake([Map sharedMap].size.width * c_i_placeSize, [Map sharedMap].size.height * c_i_placeSize);
        
        _fogView = [[UIView alloc] initWithFrame:CGRectMake(_nameLabel.left, _nameLine.bottom + c_f_padding, _nameLine.width, self.contentAvailableSize.height - _nameLine.bottom - c_f_padding)];
        _fogView.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:_fogView];
        
        _mainScrollView = [[UIScrollView alloc] initWithFrame:_fogView.frame];
        _mainScrollView.showsVerticalScrollIndicator = NO;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.alwaysBounceVertical = NO;
        _mainScrollView.alwaysBounceHorizontal = NO;
        _mainScrollView.bounces = NO;
        _mainScrollView.contentSize = CGSizeMake(self.contentView.width + mapSize.width, self.contentAvailableSize.height + mapSize.height);
        [self.contentView addSubview:_mainScrollView];
        
        _placeContainerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _placeContainerView.backgroundColor = BLACK_COLOR;
        _placeContainerView.frame = CGRectMake(self.contentView.width / 2, self.contentAvailableSize.height / 2, mapSize.width, mapSize.height);
        [_mainScrollView addSubview:_placeContainerView];
        
        _infoContainerView = [[UIView alloc] initWithFrame:CGRectMake(_nameLabel.left, _mainScrollView.top, 120 + c_f_padding * 2, 0)];
        _infoContainerView.backgroundColor = RGBA(0, 0, 0, 0.7);
        [self.contentView addSubview:_infoContainerView];
        
        _infoCaption = [UILabel captionWithText:@"" fontSize:14];
        _infoCaption.frame = CGRectMake(c_f_padding, c_f_padding, 0, 14);
        [_infoContainerView addSubview:_infoCaption];
        
        _infoTableView = [[PlaceInfoTableView alloc] initWithFrame:CGRectMake(_infoCaption.left, _infoCaption.bottom + c_f_padding, 120, 100) style:UITableViewStyleGrouped];
        _infoTableView.hidden = YES;
        [_infoContainerView addSubview:_infoTableView];
        
        _confirmButton = [Button buttonWithTitle:@"选择"];
        _confirmButton.frame = CGRectMake(self.contentView.width - self.closeButton.width * 2 - c_f_padding * 2, self.contentAvailableSize.height + c_f_padding, self.closeButton.width, self.closeButton.height);
        [_confirmButton addTarget:self action:@selector(confirmButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_confirmButton];
        
        _allPlaceViews = [NSMutableDictionary new];
        _twinklePlaceViews = [NSMutableArray new];
    }
    return self;
}

- (void)showForDistance:(NSInteger)distance fromPlaceId:(NSString *)fromPlaceId title:(NSString *)title completion:(void (^)(Place *))completion {
    
    _completion = completion;
    _distance = distance;
    
    [_nameLabel setTextAndSizeToFit:title];
    
    NSMutableDictionary *coordinatesDictionary = [[NSMutableDictionary alloc] initWithDictionary:[[GameClass sharedGame] property:@"coordinates"]];
    for (NSString *coordinateString in coordinatesDictionary.allKeys) {
        
        NSString *placeId = coordinatesDictionary[coordinateString];
        Place *place = (Place *)[Place entityWithId:placeId];
        
        PlaceView *placeView = [PlaceView newForPlace:place atCoordinate:CGPointFromString(coordinateString)];
        placeView.selectionState = PlaceSelectionStateDefault;
        placeView.delegate = self;
        [_placeContainerView addSubview:placeView];
        _allPlaceViews[coordinateString] = placeView;
    }
    
    [super show];
    
    [self resetStartPlace:(Place *)[Place entityWithId:fromPlaceId]];
}

#pragma mark 重置出发地点

- (void)resetStartPlace:(Place *)startPlace {
    
    if (_formPlace) {
        
        PlaceView *placeView = [self placeViewAtCoordinate:_formPlace.coordinate];
        placeView.selectionState = PlaceSelectionStateDefault;
    }
    
    _formPlace = startPlace;
    PlaceView *placeView = [self placeViewAtCoordinate:_formPlace.coordinate];
    placeView.selectionState = PlaceSelectionStateHighlight;
    
    _mainScrollView.contentOffset = CGPointMake(startPlace.coordinate.x * c_i_placeSize + c_i_placeSize / 2, startPlace.coordinate.y * c_i_placeSize + c_i_placeSize / 2);
    
    [self twinklePlacesDistance:_distance fromPlace:startPlace];
}

#pragma mark 以某个地点为中心周围地点开始闪烁效果

- (void)twinklePlacesDistance:(NSInteger)distance fromPlace:(Place *)fromPlace {
    
    [_twinklePlaceViews removeAllObjects];
    NSArray *closePlaceViews = [self placeViewsDistance:distance fromPlace:fromPlace];
    for (PlaceView *placeView in closePlaceViews) {
        
        [placeView twinkle];
        [_twinklePlaceViews addObject:placeView];
    }
}

- (PlaceView *)placeViewAtCoordinate:(CGPoint)coordinate {
    
    NSString *coordinateString = NSStringFromCGPoint(coordinate);
    return _allPlaceViews[coordinateString];
}

- (NSArray *)placeViewsDistance:(NSInteger)distance fromPlace:(Place *)fromPlace {
    
    NSMutableArray *placeViews = [NSMutableArray new];
    NSArray *coordinates = [[Map sharedMap] coordinatesDistance:distance fromCoordinate:fromPlace.coordinate];
    for (NSString *coordinateString in coordinates) {
        
        PlaceView *placeView = [self placeViewAtCoordinate:CGPointFromString(coordinateString)];
        if (![placeView.place boolProperty:k_canNotMove])
            [placeViews addObject:placeView];
    }
    
    return placeViews;
}

#pragma mark 点击地图上其中一个地点

- (void)placeView:(PlaceView *)placeView didSelectedPlace:(Place *)place {
    
    if (![place boolProperty:k_canNotMove] && //目标地点必须可以移动
        [[Map sharedMap] isShorterThanDistance:_distance fromCoordinate:_formPlace.coordinate toCoordinate:place.coordinate] && //目标地点和出发地点之间必须在小于规定距离
        _formPlace != place) { //目标地点不能是出发地点
    
        if (_selectedPlace) {
            
            PlaceView *placeView = [self placeViewAtCoordinate:_selectedPlace.coordinate];
            placeView.selectionState = PlaceSelectionStateDefault;
        }
        
        _selectedPlace = place;
        PlaceView *placeView = [self placeViewAtCoordinate:_selectedPlace.coordinate];
        placeView.selectionState = PlaceSelectionStateHighlight;
    }
    
    [_infoCaption setTextAndSizeToFit:place.name];
    
    _infoTableView.place = place;
    [_infoTableView reloadData];
    _infoTableView.hidden = NO;
    _infoContainerView.height = _infoTableView.bottom;
}

#pragma mark 点击确认按钮

- (void)confirmButtonClicked {
    
    if (_selectedPlace) {
        
//        for (PlaceView *placeView in _twinklePlaceViews) {
//            
//            [placeView stopTwinkle];
//        }
        
        if (_completion)
            _completion(_selectedPlace);
    }
}

@end
