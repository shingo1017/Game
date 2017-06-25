//
//  GridView.m
//  zombie
//
//  Created by 尹楠 on 17/5/27.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "GridView.h"
#import "GridCell.h"

@interface GridView ()

@end

@implementation GridView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor clearColor];
        self.selectedIndexSet = [NSMutableIndexSet new];
    }
    return self;
}

- (void)setMaxSelectionCount:(NSInteger)maxSelectionCount {
    
    _maxSelectionCount = maxSelectionCount;
    
    self.allowsMultipleSelection = _maxSelectionCount > 1;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1 + _dataRows.count;
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
    
    NSString *identifier = @"GridCell";
    GridCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        
        cell = [[GridCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (!_widthLimits && _widthLimits.count == 0) {
        
        CGFloat width = self.width / _titles.count;
        
        NSMutableArray *widthLimits = [NSMutableArray new];
        for (int i = 0; i < _titles.count; i++) {
            
            [widthLimits addObject:@(width)];
        }
        _widthLimits = widthLimits;
    }
    
    if (indexPath.row == 0) {
        
        cell.isTitle = YES;
        cell.texts = _titles;
        cell.widthLimits = _widthLimits;
    }
    else {
        
        NSArray *texts = _dataRows[indexPath.row - 1];
        cell.texts = texts;
        cell.widthLimits = _widthLimits;
        
        NSArray *colors = _colors[indexPath.row - 1];
        cell.colors = colors;
        
        BOOL shouldEnableRow = YES;
        if ([self.gridViewDelegate respondsToSelector:@selector(gridView:shouldEnableRow:)])
            shouldEnableRow = [self.gridViewDelegate gridView:self shouldEnableRow:indexPath.row - 1];
        
        if (shouldEnableRow) {
            
            if (_selectedIndex == indexPath.row || [_selectedIndexSet containsIndex:indexPath.row - 1]) {
                
                //选中状态
                cell.style = GridCellStyleHighlight;
            }
            else
                cell.style = GridCellStyleDefault;
        }
        else {
            
            //失效的cell，不可选
            cell.style = GridCellStyleDisabled;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger selectedIndex = indexPath.row - 1;
    
    BOOL shouldEnableRow = YES;
    if ([self.gridViewDelegate respondsToSelector:@selector(gridView:shouldEnableRow:)])
        shouldEnableRow = [self.gridViewDelegate gridView:self shouldEnableRow:selectedIndex];
    
    if (shouldEnableRow) {
        
        if (self.doneWhenSelect) {
            
            _selectedIndex = indexPath.row;
            
            if ([self.gridViewDelegate respondsToSelector:@selector(gridView:didSelectedRow:)])
                [self.gridViewDelegate gridView:self didSelectedRow:selectedIndex];
        }
        else {
            
            if (_maxSelectionCount == 1) {
                
                //单选
                [_selectedIndexSet removeAllIndexes];
                [_selectedIndexSet addIndex:selectedIndex];
                [tableView reloadData];
            }
            else {
                
                //多选
                GridCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                if (cell.style == GridCellStyleHighlight) {
                    
                    cell.style = GridCellStyleDefault;
                    [_selectedIndexSet removeIndex:selectedIndex];
                    [tableView reloadData];
                }
                else if (_selectedIndexSet.count < _maxSelectionCount) {
                    
                    cell.style = GridCellStyleHighlight;
                    [_selectedIndexSet addIndex:selectedIndex];
                    [tableView reloadData];
                }
            }
            
            if ([self.gridViewDelegate respondsToSelector:@selector(gridView:didSelectedRow:)])
                [self.gridViewDelegate gridView:self didSelectedRow:selectedIndex];
        }
    }
}

@end
