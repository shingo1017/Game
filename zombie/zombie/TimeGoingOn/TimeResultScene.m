//
//  TimeResultScene.m
//  zombie
//
//  Created by 尹楠 on 17/5/31.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "TimeResultScene.h"
#import "TimeGoingOn.h"
#import "InfoCell.h"

static TimeResultScene *_sharedTimeResultScene;

@interface TimeResultScene () <UITableViewDataSource, UITableViewDelegate> {
    
    UILabel *_nameLabel;
    UIView *_nameLine;
    UITableView *_resultTextTableView;
}

@end

@implementation TimeResultScene

+ (TimeResultScene *)sharedScene {
    
    return _sharedTimeResultScene;
}

+ (void)setSharedScene:(TimeResultScene *)sharedScene {
    
    _sharedTimeResultScene = sharedScene;
}

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
        
        _resultTextTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _nameLine.bottom + c_f_padding, self.contentView.width, self.contentView.height - _nameLine.bottom - c_f_padding - self.closeButton.height - c_f_padding * 2) style:UITableViewStyleGrouped];
        _resultTextTableView.dataSource = self;
        _resultTextTableView.delegate = self;
        _resultTextTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _resultTextTableView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_resultTextTableView];
    }
    return self;
}

- (void)show {
    
    [_nameLabel setTextAndSizeToFit:@"4小时结果汇报"];
    [_resultTextTableView reloadData];
    
    [super show];
}

- (void)hide {
    
    [[TimeGoingOn sharedInstance].resultTexts removeAllObjects];
    
    [super hide];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [TimeGoingOn sharedInstance].resultTexts.count;
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
    
    NSString *identifier = @"ResultTextCell";
    InfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        
        cell = [[InfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    
    NSString *text = [TimeGoingOn sharedInstance].resultTexts[indexPath.row];
    
    cell.textLabel.text = text;
    
    return cell;
}

@end
