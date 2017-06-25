//
//  PlaceScene.m
//  zombie
//
//  Created by 尹楠 on 17/5/16.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "PlaceScene.h"
#import "PlaceInfoTableView.h"
#import "TeamInfoTableView.h"
#import "ScheduleTableView.h"
#import "NumberHelpScene.h"
#import "ActionMenuView.h"
#import "InfoCell.h"
#import "TimeGoingOnScene.h"

@interface PlaceScene () {
    
    UILabel *_infoCaption;
    PlaceInfoTableView *_infoTableView;
    
    UILabel *_teamInfoCaption;
    TeamInfoTableView *_teamInfoTableView;
    
    UILabel *_scheduleCaption;
    ScheduleTableView *_scheduleTableView;
    
    Button *_mapButton;
    Button *_excutiveButton;
}

@property (nonatomic, strong) UILabel *placeNameLabel;
@property (nonatomic, strong) UILabel *leaderNameLabel;
@property (nonatomic, strong) UIView *placeNameLine;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UIView *buttonContainerView;
@property (nonatomic, strong) ActionMenuView *actionMenuView;

@end

@implementation PlaceScene

+ (PlaceScene *)sharedScene {
    
    return (PlaceScene *)[[MainView sharedView] sceneForClassName:@"PlaceScene"];
}

- (id)init {
    
    self = [super init];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shouldReloadNotification) name:K_SHOULD_RELOAD_SCENE_NOTIFICATION object:nil];
        
        self.backgroundColor = [UIColor clearColor];
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        
        self.placeNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(c_f_padding, 20, 0, 20)];
        self.placeNameLabel.font = [UIFont systemFontOfSize:20.0f];
        self.placeNameLabel.textColor = WHITE_COLOR;
        [self addSubview:self.placeNameLabel];
        
        self.leaderNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        self.leaderNameLabel.font = [UIFont systemFontOfSize:13.0f];
        self.leaderNameLabel.textColor = WHITE_COLOR;
        [self addSubview:self.leaderNameLabel];
        
        self.placeNameLine = [[UIView alloc] initWithFrame:CGRectMake(self.placeNameLabel.left, _placeNameLabel.bottom + c_f_padding, SCREEN_WIDTH - 20, 1)];
        self.placeNameLine.backgroundColor = WHITE_COLOR;
        [self addSubview:self.placeNameLine];
        
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 27, 0, 0)];
        self.dateLabel.font = [UIFont systemFontOfSize:13.0f];
        self.dateLabel.textColor = WHITE_COLOR;
        [self addSubview:self.dateLabel];
        
        _infoCaption = [UILabel captionWithText:@"本地情况" fontSize:14];
        _infoCaption.frame = CGRectMake(_placeNameLabel.left, _placeNameLine.bottom + c_f_padding, 0, 14);
        [self addSubview:_infoCaption];
        
        _infoTableView = [[PlaceInfoTableView alloc] initWithFrame:CGRectMake(self.placeNameLine.left, _infoCaption.bottom + c_f_padding, 120, 100) style:UITableViewStyleGrouped];
        [self addSubview:_infoTableView];
        
        _teamInfoCaption = [UILabel captionWithText:@"团队情况" fontSize:14];
        _teamInfoCaption.frame = CGRectMake(_placeNameLabel.left, _placeNameLine.bottom + c_f_padding, 0, 14);
        [self addSubview:_teamInfoCaption];
        
        _teamInfoTableView = [[TeamInfoTableView alloc] initWithFrame:CGRectMake(self.placeNameLine.left, _teamInfoCaption.bottom + c_f_padding, 120, 100) style:UITableViewStyleGrouped];
        [self addSubview:_teamInfoTableView];
        
        _scheduleCaption = [UILabel captionWithText:@"任务安排" fontSize:14];
        _scheduleCaption.frame = CGRectMake(self.width - 120 - c_f_padding, _infoCaption.top, 180, 14);
        [self addSubview:_scheduleCaption];
        
        _scheduleTableView = [[ScheduleTableView alloc] initWithFrame:CGRectMake(_scheduleCaption.left, _infoTableView.top, 120, 100) style:UITableViewStyleGrouped];
        [self addSubview:_scheduleTableView];
        
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
    }
    return self;
}

- (void)initActions {
    
    if ([self.place boolProperty:k_isFief])
        self.actions = [Action actionsBelongToClassName:@"FiefScene"];
    else if ([self.place boolProperty:k_isBuilding])
        self.actions = [Action actionsBelongToClassName:@"BuildingScene"];
    else
        self.actions = [Action actionsBelongToClassName:@"PlaceScene"];
}

- (Place *)place {
    
    return (Place *)[Place entityWithId:_placeId];
}

- (void)showWithPlaceId:(NSString *)placeId {
    
    _placeId = placeId;
    
    [self show];
    
    [self reloadData];
}

- (void)reloadData {
    
    [self initActions];
    
    self.placeNameLabel.text = self.place.name;
    [self.placeNameLabel sizeToFit];
    
    self.dateLabel.text = [NSString stringWithFormat:@"第 %li 天 - %@", [[Game sharedGame] intProperty:k_day], [[Game sharedGame] timePeriodText]];
    [self.dateLabel sizeToFit];
    self.dateLabel.right = SCREEN_WIDTH - c_f_padding;
    
    [_infoCaption setTextAndSizeToFit:@"情 况"];
    
    _infoTableView.place = self.place;
    //_infoTableView.height = SCREEN_HEIGHT - _infoCaption.bottom - self.buttonContainerView.height - c_f_padding * 2;
    [_infoTableView reloadData];
    
    [_scheduleCaption setTextAndSizeToFit:@"任务安排"];
    
    _scheduleTableView.place = self.place;
    _scheduleTableView.height = _infoTableView.height;
    
    for (UIView *view in self.buttonContainerView.subviews) {
        
        [view removeFromSuperview];
    }
    
    NSInteger i = 0;
    for (Action *action in self.actions) {
        
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
    
    [MapScene sharedScene].hidden = NO;
    self.hidden = YES;
}

- (void)actionButtonClicked:(UIButton *)actionButton {
    
    Action *action = self.actions[actionButton.tag];
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
    
    if (self.place.numberOfWorkingSurvivors < self.place.survivors.count) {
        
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

- (void)shouldReloadNotification {
    
    [self reloadData];
}

@end
