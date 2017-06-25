//
//  GridView.h
//  zombie
//
//  Created by 尹楠 on 17/5/27.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GridViewDelegate;

@interface GridView : UITableView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *dataRows;
@property (nonatomic, strong) NSArray *widthLimits;
@property (nonatomic, strong) NSArray *colors;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) NSMutableIndexSet *selectedIndexSet;
@property (nonatomic, assign) BOOL doneWhenSelect;
@property (nonatomic, assign) NSInteger maxSelectionCount;
@property (nonatomic, weak) id<GridViewDelegate> gridViewDelegate;

@end

@protocol GridViewDelegate <NSObject>

@optional

- (BOOL)gridView:(GridView *)gridView shouldEnableRow:(NSInteger)row;
- (void)gridView:(GridView *)gridView didSelectedRow:(NSInteger)row;

@end
