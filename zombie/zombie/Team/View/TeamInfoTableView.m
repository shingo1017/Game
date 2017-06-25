//
//  TeamInfoTableView.m
//  zombie
//
//  Created by 尹楠 on 17/5/27.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "TeamInfoTableView.h"
#import "InfoCell.h"
#import "NumberHelpScene.h"

@interface TeamInfoTableView () {
    
    BOOL _isDefaultTeam;
}

@end

@implementation TeamInfoTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self borderStyle];
    }
    return self;
}

- (void)setTeam:(Team *)team {
    
    _team = team;
    
    if (_team) {
        
        _infoGroup = [Utility objectForClassName:@"TeamInfoGroup"];
        
        self.height = c_f_padding * 2 + _infoGroup.displayProperties.count * 20;
        
        _isDefaultTeam = [_team.id isEqualToString:[[Game sharedGame] property:k_myTeamId]];
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _infoGroup.displayProperties.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return c_f_padding;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 20.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier = @"InfoCell";
    InfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        
        cell = [[InfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.isDefaultPlace = _isDefaultTeam;
    DisplayProperty *displayProperty = _infoGroup.displayProperties[indexPath.row];
    if (_isDefaultTeam)
        displayProperty.displayObject = [Team myTeam];
    else
        displayProperty.displayObject = _team;
    cell.displayPropertyWidget.displayProperty = displayProperty;
    
    cell.shouldShowHelp = YES;
    [cell setHelpButtonClickedBlock:^() {
        
        NSString *key = [[displayProperty.keyPath componentsSeparatedByString:@"."] lastObject];
        [[NumberHelpScene new] showWithNumber:[_team floatProperty:key] key:key];
    }];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

@end
