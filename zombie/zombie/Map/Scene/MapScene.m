//
//  MapScene.m
//  zombie
//
//  Created by 尹楠 on 17/6/8.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "MapScene.h"
#import "PlaceView.h"
#import "PlaceInfoTableView.h"
#import "ScheduleTableView.h"
#import "ActionMenuView.h"
#import "TimeGoingOnScene.h"

@interface MapScene () <PlaceViewDelegate> {
    
    UIView *_fogView;
    UIScrollView *_mainScrollView;
    UIView *_placeContainerView;
    
    UIView *_infoContainerView;
    UILabel *_infoCaption;
    PlaceInfoTableView *_infoTableView;
    
    UIView *_scheduleContainerView;
    UILabel *_scheduleCaption;
    ScheduleTableView *_scheduleTableView;
    
    CGFloat _zoomScale;
    PlaceView *_selectedPlaceView;
    
    Button *_mapButton;
    Button *_excutiveButton;
    
    NSArray *_actions;
}

@property (nonatomic, strong) UIView *buttonContainerView;
@property (nonatomic, strong) ActionMenuView *actionMenuView;

@end

@implementation MapScene

+ (MapScene *)sharedScene {
    
    return (MapScene *)[[MainView sharedView] sceneForClassName:@"MapScene"];
}

- (id)init {
    
    self = [super init];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shouldReloadNotification) name:K_SHOULD_RELOAD_MAP_NOTIFICATION object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shouldReloadNotification) name:K_SHOULD_RELOAD_SCENE_NOTIFICATION object:nil];
        
        self.backgroundColor = [UIColor clearColor];
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        
        _fogView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _fogView.backgroundColor = [UIColor blackColor];
        [self addSubview:_fogView];
        
        _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _mainScrollView.showsVerticalScrollIndicator = NO;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.alwaysBounceVertical = NO;
        _mainScrollView.alwaysBounceHorizontal = NO;
        _mainScrollView.bounces = NO;
        [self addSubview:_mainScrollView];
        
        _placeContainerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _placeContainerView.backgroundColor = BLACK_COLOR;
        [_mainScrollView addSubview:_placeContainerView];
        
        _infoContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120 + c_f_padding * 2, 0)];
        _infoContainerView.backgroundColor = RGBA(0, 0, 0, 0.7);
        [self addSubview:_infoContainerView];
        
        _infoCaption = [UILabel captionWithText:@"" fontSize:14];
        _infoCaption.frame = CGRectMake(c_f_padding, c_f_padding, 0, 14);
        [_infoContainerView addSubview:_infoCaption];
        
        _infoTableView = [[PlaceInfoTableView alloc] initWithFrame:CGRectMake(_infoCaption.left, _infoCaption.bottom + c_f_padding, 120, 100) style:UITableViewStyleGrouped];
        _infoTableView.hidden = YES;
        [_infoContainerView addSubview:_infoTableView];
        
        _scheduleContainerView = [[UIView alloc] initWithFrame:CGRectMake(self.width - 120 - c_f_padding * 2, 0, 120 + c_f_padding * 2, 0)];
        _scheduleContainerView.backgroundColor = RGBA(0, 0, 0, 0.7);
        [self addSubview:_scheduleContainerView];
        
        _scheduleCaption = [UILabel captionWithText:@"任务安排" fontSize:14];
        _scheduleCaption.frame = CGRectMake(c_f_padding, c_f_padding, 120, 14);
        [_scheduleContainerView addSubview:_scheduleCaption];
        
        _scheduleTableView = [[ScheduleTableView alloc] initWithFrame:CGRectMake(_scheduleCaption.left, _scheduleCaption.top, 120, 100) style:UITableViewStyleGrouped];
        [_scheduleContainerView addSubview:_scheduleTableView];
        
        _mapButton = [Button buttonWithTitle:@"地图"];
        _mapButton.frame = CGRectMake(0, self.height - 50, 70, 50);
        [_mapButton addTarget:self action:@selector(mapButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_mapButton];
        
        self.buttonContainerView = [[UIView alloc] initWithFrame:CGRectMake(_mapButton.right + c_f_padding, SCREEN_HEIGHT - 40, SCREEN_WIDTH - 140 - c_f_padding * 2, 40)];
        [self addSubview:self.buttonContainerView];
        
        self.actionMenuView = [ActionMenuView new];
        [self addSubview:self.actionMenuView];
        
        _excutiveButton = [Button buttonWithTitle:@"进行"];
        _excutiveButton.frame = CGRectMake(self.width - 70, self.height - 50, 70, 50);
        [_excutiveButton addTarget:self action:@selector(excutiveButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_excutiveButton];
        
        _zoomScale = 1.0f;
    }
    return self;
}

- (void)initActions {
    
    if ([[PlaceScene sharedScene].place boolProperty:k_isFief])
        _actions = [Action actionsBelongToClassName:@"FiefScene"];
    else if ([[PlaceScene sharedScene].place boolProperty:k_isBuilding])
        _actions = [Action actionsBelongToClassName:@"BuildingScene"];
    else
        _actions = [Action actionsBelongToClassName:@"PlaceScene"];
}

- (void)showWithCoordinate:(CGPoint)coordinate {
    
    CGSize mapSize = CGSizeMake([Map sharedMap].size.width * c_i_placeSize, [Map sharedMap].size.height * c_i_placeSize);
    
    _mainScrollView.contentSize = CGSizeMake(self.width + mapSize.width, self.height + mapSize.height);
    
    _placeContainerView.frame = CGRectMake(self.width / 2, self.height / 2, mapSize.width, mapSize.height);
    
    _mainScrollView.contentOffset = CGPointMake(coordinate.x * c_i_placeSize + c_i_placeSize / 2, coordinate.y * c_i_placeSize + c_i_placeSize / 2);
    
    NSMutableDictionary *coordinatesDictionary = [[NSMutableDictionary alloc] initWithDictionary:[[GameClass sharedGame] property:@"coordinates"]];
    for (NSString *coordinateString in coordinatesDictionary.allKeys) {
        
        NSString *placeId = coordinatesDictionary[coordinateString];
        Place *place = (Place *)[Place entityWithId:placeId];
        
        PlaceView *placeView = [PlaceView newForPlace:place atCoordinate:CGPointFromString(coordinateString)];
        placeView.selectionState = PlaceSelectionStateDefault;
        placeView.delegate = self;
        [_placeContainerView addSubview:placeView];
    }
    
    [self show];
    
    [self reloadData];
}

- (void)reloadData {
    
    _scheduleTableView.place = [PlaceScene sharedScene].place;
    _scheduleContainerView.height = _scheduleTableView.bottom;
    
    [self initActions];
    
    for (UIView *view in self.buttonContainerView.subviews) {
        
        [view removeFromSuperview];
    }
    
    NSInteger i = 0;
    for (Action *action in _actions) {
        
        UIButton *actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        actionButton.frame = CGRectMake(i * 120, 0, 120, self.buttonContainerView.height);
        actionButton.tag = i;
        actionButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        actionButton.backgroundColor = WHITE_COLOR;
        [actionButton setTitleColor:BLACK_COLOR forState:UIControlStateNormal];
        [actionButton setTitle:action.name forState:UIControlStateNormal];
        [actionButton addTarget:self action:@selector(actionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [actionButton borderStyleWithColor:BLACK_COLOR];
        [self.buttonContainerView addSubview:actionButton];
        
        i++;
    }
    
    self.buttonContainerView.width = 120 * i;
}

- (void)mapButtonClicked {
    
    [PlaceScene sharedScene].hidden = NO;
    self.hidden = YES;
}

- (void)actionButtonClicked:(UIButton *)actionButton {
    
    Action *action = _actions[actionButton.tag];
    if ([action respondsToSelector:@selector(actionResult)]) {
        
        [self.actionMenuView hide];
        
        [action actionResult];
    }
    else {
        
        self.top = 0;
        self.height = SCREEN_HEIGHT;
        self.buttonContainerView.bottom = self.height;
        
        for (UIButton *button in self.buttonContainerView.subviews) {
            
            button.selected = NO;
        }
        actionButton.selected = !actionButton.selected;
        
        if (actionButton.selected)
            [self.actionMenuView showWithActions:action.availableActions atPoint:CGPointMake(self.buttonContainerView.left + actionButton.left, self.buttonContainerView.top)];
        else
            [self.actionMenuView hide];
    }
}

- (void)excutiveButtonClicked {
    
    if ([PlaceScene sharedScene].place.numberOfWorkingSurvivors < [PlaceScene sharedScene].place.survivors.count) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认" message:@"还有幸存者没有被分配任务，确定要结束本回合吗？" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            [[TimeGoingOnScene new] show];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [[MainView sharedView] presentViewController:alert animated:YES completion:nil];
    }
    else {
        
        [[TimeGoingOnScene new] show];
    }
}

#pragma mark 点击地图上其中一个地点的方法

- (void)placeView:(PlaceView *)placeView didSelectedPlace:(Place *)place {
    
    if (_selectedPlaceView) {
        
        _selectedPlaceView.selectionState = PlaceSelectionStateDefault;
    }
    
    _selectedPlaceView = placeView;
    _selectedPlaceView.selectionState = PlaceSelectionStateHighlight;
    
    [_infoCaption setTextAndSizeToFit:place.name];

    _infoTableView.place = place;
    [_infoTableView reloadData];
    _infoTableView.hidden = NO;
    _infoContainerView.height = _infoTableView.bottom;
}

- (void)shouldReloadNotification {
    
    [self reloadData];
}

@end
