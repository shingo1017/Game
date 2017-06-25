//
//  ShopView.m
//  destroy
//
//  Created by 尹楠 on 16/10/1.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "ShopView.h"
#import "ShopTabCell.h"
#import "ActionCell.h"
#import "NSString+Additions.h"

@interface ShopView () {
    
    NSArray *_actions;
}

@end

@implementation ShopView

static ShopView *_sharedView;

+ (ShopView *)sharedView {
    
    return _sharedView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [tabDescriptionContainerView borderStyleWithColor:[UIColor whiteColor]];
    [tabDescriptionContainerView cornerRadiusStyle];
    
    [_actionTableView registerNib:[UINib nibWithNibName:@"ActionCell" bundle:nil] forCellReuseIdentifier:@"ActionCell"];
    _actionTableView.backgroundColor = [UIColor clearColor];
    _actionTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _actionTableView.dataSource = self;
    _actionTableView.delegate = self;
    
    _sharedView = self;
    
    [self reloadSurvivalPoint];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:1.5f animations:^{
        
        _sceneTransferMaskView.alpha = 0.0f;
    }];
    
    [tabTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
    [self tableView:tabTableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reloadSurvivalPoint {
    
    survivalPointLabel.text = [NSString stringWithFormat:@"生存点数：%li", [[System system] intProperty:@"survivalPoint"]];
}

- (void)reloadCurrentScene {
    
    [_actionTableView reloadData];
}

- (void)warningNotEnoughSurvivalPoint {
    
    
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 40.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier = @"ShopTabCell";
    ShopTabCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
        cell = (ShopTabCell *)[UIView viewWithName:identifier];
    
    if (indexPath.row == 0)
        cell.nameLabel.text = @"生 存 技 能";
    else if (indexPath.row == 1)
        cell.nameLabel.text = @"补 给 品 店";
    else if (indexPath.row == 2)
        cell.nameLabel.text = @"离 开 营 地";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        tabDescriptionLabel.attributedText = [@"生存技能可以帮助求生者们存活的更久，学习之后，所有角色均永久有效。" attributedStringWithFontSize:tabDescriptionLabel.font.pointSize textColor:tabDescriptionLabel.textColor];
        
        Scene *scene = [Utility objectForClassName:@"SurvivalSkillScene"];
        _actions = [scene property:@"actions"];
        [_actionTableView reloadData];
    }
    else if (indexPath.row == 1) {
        
        tabDescriptionLabel.attributedText = [@"开始新游戏时，会额外携带已购买的补给品，同时消耗掉该补给品。" attributedStringWithFontSize:tabDescriptionLabel.font.pointSize textColor:tabDescriptionLabel.textColor];
        
        Scene *scene = [Utility objectForClassName:@"SupplyScene"];
        _actions = [scene property:@"actions"];
        [_actionTableView reloadData];
    }
    else if (indexPath.row == 2) {
        
        //离开营地
        [UIView animateWithDuration:1.5f animations:^{
            
            self.sceneTransferMaskView.alpha = 1.0f;
        } completion:^(BOOL finished) {
            
            [[TitleScreenView sharedView].navigationController popToRootViewControllerAnimated:NO];
            [[TitleScreenView sharedView] show];
        }];
    }
}

#pragma mark -----------delegate

//返回行高
- (CGFloat)treeView:(RATreeView *)treeView heightForRowForItem:(id)item {
    
    return 30;
}

//将要展开
- (void)treeView:(RATreeView *)treeView willExpandRowForItem:(id)item {
    
    Action *action = item;
    
    NSInteger rows = _actions.count;
    for (Action *sharedAction in _actions) {
        
        if (action == sharedAction || [_actionTableView isCellForItemExpanded:sharedAction])
            rows += sharedAction.actions.count;
    }
    
    //[self actionTableFitsizeWithRows:rows animation:YES];
}
//将要收缩
- (void)treeView:(RATreeView *)treeView willCollapseRowForItem:(id)item {
    
    Action *action = item;
    
    NSInteger rows = _actions.count;
    for (Action *sharedAction in _actions) {
        
        if (action != sharedAction && [_actionTableView isCellForItemExpanded:sharedAction])
            rows += sharedAction.actions.count;
    }
    
    //[self actionTableFitsizeWithRows:rows animation:YES];
}

#pragma mark -----------dataSource

//返回cell
- (UITableViewCell *)treeView:(RATreeView *)treeView cellForItem:(id)item {
    
    //获取cell
    ActionCell *cell = [treeView dequeueReusableCellWithIdentifier:@"ActionCell"];
    
    //当前item
    Action *action = item;
    
    //当前层级
    NSInteger level = [treeView levelForCellForItem:item];
    
    //赋值
    [cell setAction:action level:level children:action.actions.count];
    
    return cell;
}

/**
 *  必须实现
 *
 *  @param treeView treeView
 *  @param item    节点对应的item
 *
 *  @return  每一节点对应的个数
 */
- (NSInteger)treeView:(RATreeView *)treeView numberOfChildrenOfItem:(id)item {
    
    Action *action = item;
    
    if (item == nil) {
        
        return _actions.count;
    }
    
    return action.actions.count;
}
/**
 *必须实现的dataSource方法
 *
 *  @param treeView treeView
 *  @param index    子节点的索引
 *  @param item     子节点索引对应的item
 *
 *  @return 返回 节点对应的item
 */
- (id)treeView:(RATreeView *)treeView child:(NSInteger)index ofItem:(id)item {
    
    Action *action = item;
    if (item == nil) {
        
        return [_actions objectAtIndex:index];
    }
    
    return [action.actions objectAtIndex:index];
}

//cell的点击方法
- (void)treeView:(RATreeView *)treeView didSelectRowForItem:(id)item {
    
    [treeView deselectRowForItem:item animated:NO];
    
    //获取当前的层
    NSInteger level = [treeView levelForCellForItem:item];
    
    //当前点击的model
    Action *action = item;
    
    if (action.actions.count == 0)
        [action actionResult];
}

//单元格是否可以编辑 默认是YES
- (BOOL)treeView:(RATreeView *)treeView canEditRowForItem:(id)item {
    
    return NO;
}

//....没看懂啥意思
- (NSInteger)treeView:(RATreeView *)treeView indentationLevelForRowForItem:(id)item {
    
    return 3;
}

@end
