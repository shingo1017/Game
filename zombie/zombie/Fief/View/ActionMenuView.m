//
//  ActionMenuView.m
//  zombie
//
//  Created by 尹楠 on 17/5/24.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "ActionMenuView.h"
#import "SettlementAction.h"

@interface ActionMenuView () {
    
    UIButton *dismissButton;
}

@property (nonatomic, strong) UITableView *menuTableView;

@property (nonatomic, strong) NSArray *actions;

@end

@implementation ActionMenuView

- (id)init {
    
    self = [super init];
    if (self) {
        
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 40);
        self.alpha = 0;
        
        dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
        dismissButton.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        dismissButton.backgroundColor = RGBA(0, 0, 0, 0);
        [dismissButton addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:dismissButton];
        
        self.menuTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 120, 150) style:UITableViewStyleGrouped];
        [self.menuTableView borderStyleWithColor:BLACK_COLOR];
        self.menuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.menuTableView.backgroundColor = [UIColor clearColor];
        self.menuTableView.dataSource = self;
        self.menuTableView.delegate = self;
        [self addSubview:self.menuTableView];
    }
    return self;
}

- (void)showWithActions:(NSArray *)actions atPoint:(CGPoint)point {
    
    _actions = actions;
    
    [self.menuTableView reloadData];
    self.menuTableView.height = _actions.count * 30;
    self.menuTableView.left = point.x;
    self.menuTableView.bottom = point.y;
    
    self.alpha = 1;
}

- (void)hide {
    
    self.alpha = 0.0f;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _actions.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 30.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier = @"MenuActionsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = WHITE_COLOR;
        cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    Action *action = _actions[indexPath.row];
    cell.textLabel.text = action.name;
    if (action.isEnabled)
        cell.textLabel.textColor = BLACK_COLOR;
    else
        cell.textLabel.textColor = GRAY_COLOR;
    //[NSString stringWithFormat:@"%@：%@", displayProperty.caption, displayProperty.displayText];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Action *action = _actions[indexPath.row];
    if (action.isEnabled) {
        
        [action actionResult];
        [self hide];
    }
}

@end
