//
//  ScheduleTableView.m
//  zombie
//
//  Created by 尹楠 on 17/5/27.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "ScheduleTableView.h"
#import "InfoCell.h"

@interface ScheduleTableView () {
    
    NSMutableArray *_survivors;
}

@end

@implementation ScheduleTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadSchedule) name:K_SHOULD_RELOAD_SCHEDULE_NOTIFICATION object:nil];
        
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self borderStyle];
        
        _survivors = [NSMutableArray new];
    }
    return self;
}

- (void)setPlace:(Place *)place {
    
    _place = place;
    
    if (_place) {
        
        [self reloadSchedule];
    }
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:K_SHOULD_RELOAD_SCHEDULE_NOTIFICATION object:nil];
}

- (void)reloadSchedule {
    
    [_survivors removeAllObjects];
    NSArray *survivors = _place.survivors;
    for (Survivor *survivor in survivors) {
        
        NSString *excutiveClassName = [survivor property:k_excutiveClassName];
        if (excutiveClassName.length > 0) {
            
            [_survivors addObject:survivor];
        }
    }
    
    self.hidden = _survivors.count == 0;
    
    [self reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _survivors.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10;
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
        cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    
    Survivor *survivor = _survivors[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@：%@", survivor.name, [survivor property:k_status]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

@end
