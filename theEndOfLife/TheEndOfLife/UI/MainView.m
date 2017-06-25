//
//  MainView.m
//  girl
//
//  Created by 尹楠 on 16/9/2.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "MainView.h"
#import "ActionCell.h"
#import "Cutscene.h"
#import "NSString+Additions.h"

@interface MainView () {
    
    UIView *_actionContainerView;
    
    NSTimer *_messageTimer;
    NSInteger _messageIndex;
}

@end

@implementation MainView

+ (MainView *)sharedView {
    
    return (MainView *)[super sharedView];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shouldReloadGroupNotification:) name:K_SHOULD_RELOAD_GROUP_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shouldReloadActionNotification:) name:K_SHOULD_RELOAD_ACTION_NOTIFICATION object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initCustomLayerViews {
    
    id group = [Utility objectForClassName:@"TimeGroup"];
    _gameGroupWidget.group = group;
    
    id myStatusGroup = [Utility objectForClassName:@"MyStatusOnMainScreenGroup"];
    _myStatusGroupWidget.backgroundColor = RGBA(0, 0, 0, 0.7);
    _myStatusGroupWidget.group = myStatusGroup;
    
    _actionContainerView = [[UIView alloc] initWithFrame:self.view.bounds];
    _actionContainerView.backgroundColor = RGBA(0, 0, 0, 0.7);
    [self.view addSubview:_actionContainerView];
    
    _actionTableView = [[RATreeView alloc] initWithFrame:self.view.bounds];
    [_actionTableView registerNib:[UINib nibWithNibName:@"ActionCell" bundle:nil] forCellReuseIdentifier:@"ActionCell"];
    _actionTableView.backgroundColor = [UIColor clearColor];
    _actionTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _actionTableView.dataSource = self;
    _actionTableView.delegate = self;
    [_actionContainerView addSubview:_actionTableView];
}

- (void)transferSceneWithClassName:(NSString *)className completion:(void (^)(void))completionBlock {
    
    [super transferSceneWithClassName:className completion:completionBlock];
}

- (void)didTransferSceneWithClassName:(NSString *)className {
    
    [super didTransferSceneWithClassName:className];
    
    self.sceneWidget.scene = [Scene currentScene];
    self.sceneImageView.image = [UIImage imageNamed:[[Scene currentScene] property:@"sceneImageName"]];
    
    if ([[Person me] isSameSceneWithPerson:[Person partner]]) {
        
        [self showPartnerImage:@"真吾_平常"];
    }
    else {
        
        [self hidePartnerImage];
    }
    
    [Message hideMessage];
    
    [Action applySceneActions];
}

- (void)showMyImage {
    
    [self showMyImage:nil animation:NO];
}

- (void)showMyImageWithAnimation:(BOOL)animation {
    
    [self showMyImage:nil animation:animation];
}

- (void)showMyImage:(NSString *)imageName {
    
    [self showMyImage:imageName animation:NO];
}

- (void)showMyImage:(NSString *)imageName animation:(BOOL)animation {
    
    _myImageView.width = 140;
    _myImageView.height = 240;
    
    if (imageName)
        _myImageView.image = [UIImage imageNamed:imageName];
    
    if (_myImageView.alpha == 0.0f)
        _myImageView.left = (SCREEN_WIDTH - _myImageView.width - 100) / 2;
    
    if (animation) {
        
        [UIView animateWithDuration:1.0f animations:^{
            _myImageView.alpha = 1.0f;
        }];
        
        [self fitsizePersonImagesWithAnimation:YES];
    }
    else {
        
        _myImageView.alpha = 1.0f;
        [self fitsizePersonImages];
    }
}

- (void)hideMyImage {
    
    [self hideMyImageWithAnimation:NO];
}

- (void)hideMyImageWithAnimation:(BOOL)animation {
    
    if (animation) {
        
        [UIView animateWithDuration:1.0f animations:^{
            _myImageView.alpha = 0.0f;
        } completion:^(BOOL finished) {
            
            [self fitsizePersonImagesWithAnimation:YES];
        }];
    }
    else {
        
        _myImageView.alpha = 0.0f;
        [self fitsizePersonImages];
    }
}

- (void)showPartnerImage {
    
    [self showPartnerImage:nil animation:NO];
}

- (void)showPartnerImageWithAnimation:(BOOL)animation {
    
    [self showPartnerImage:nil animation:animation];
}

- (void)showPartnerImage:(NSString *)imageName {
    
    [self showPartnerImage:imageName animation:NO];
}

- (void)showPartnerImage:(NSString *)imageName animation:(BOOL)animation {
    
    _partnerImageView.width = 150;
    _partnerImageView.height = 300;
    
    if (imageName)
        _partnerImageView.image = [UIImage imageNamed:imageName];
    
    if (_partnerImageView.alpha == 0.0f)
        _partnerImageView.left = (SCREEN_WIDTH - _partnerImageView.width - 100) / 2;
    
    if (animation) {
        
        [UIView animateWithDuration:1.0f animations:^{
            _partnerImageView.alpha = 1.0f;
        }];
        
        [self fitsizePersonImagesWithAnimation:YES];
    }
    else {
        
        _partnerImageView.alpha = 1.0f;
        [self fitsizePersonImages];
    }
}

- (void)hidePartnerImage {
    
    [self hidePartnerImageWithAnimation:NO];
}

- (void)hidePartnerImageWithAnimation:(BOOL)animation {
    
    if (animation) {
        
        [UIView animateWithDuration:1.0f animations:^{
            _partnerImageView.alpha = 0.0f;
        } completion:^(BOOL finished) {
            
            [self fitsizePersonImagesWithAnimation:YES];
        }];
    }
    else {
        
        _partnerImageView.alpha = 0.0f;
        [self fitsizePersonImages];
    }
}

- (void)fitsizePersonImages {
    
    [self fitsizePersonImagesWithAnimation:NO];
}

- (void)fitsizePersonImagesWithAnimation:(BOOL)animation {
    
    _myImageView.bottom = SCREEN_HEIGHT;
    
    _partnerImageView.bottom = SCREEN_HEIGHT;
    
    if (animation) {
        
        [UIView animateWithDuration:1.0f animations:^{
            
            if (_partnerImageView.alpha == 0.0f) {
                
                _myImageView.left = (SCREEN_WIDTH - _myImageView.width - 100) / 2;
            }
            else if (_myImageView.alpha == 0.0f) {
                
                _partnerImageView.left = (SCREEN_WIDTH - _partnerImageView.width - 100) / 2;
            }
            else if (_myImageView.alpha == 1.0f && _partnerImageView.alpha == 1.0f) {
                
                _myImageView.left = (SCREEN_WIDTH - _myImageView.width - _partnerImageView.width - 150) / 2;
                _partnerImageView.right = SCREEN_WIDTH - _myImageView.left - 100;
            }
        }];
    }
    else {
        
        if (_partnerImageView.alpha == 0.0f) {
            
            _myImageView.left = (SCREEN_WIDTH - _myImageView.width - 100) / 2;
        }
        else if (_myImageView.alpha == 0.0f) {
            
            _partnerImageView.left = (SCREEN_WIDTH - _partnerImageView.width - 100) / 2;
        }
        else if (_myImageView.alpha == 1.0f && _partnerImageView.alpha == 1.0f) {
            
            _myImageView.left = (SCREEN_WIDTH - _myImageView.width - _partnerImageView.width - 150) / 2;
            _partnerImageView.right = SCREEN_WIDTH - _myImageView.left - 100;
        }
    }
}

- (void)reloadMessage {
    
    [super reloadMessage];

    _actionContainerView.height = [Action sharedActions].count * 30;
    _actionContainerView.bottom = self.messageContainerView.top - 10;
    //_myStatusGroupWidget.bottom = _messageContainerView.top - 10;
}

#pragma mark -----------delegate

//返回行高
- (CGFloat)treeView:(RATreeView *)treeView heightForRowForItem:(id)item {
    
    return 30;
}

//将要展开
- (void)treeView:(RATreeView *)treeView willExpandRowForItem:(id)item {
    
    Action *action = item;
    
    NSInteger rows = [Action sharedActions].count;
    for (Action *sharedAction in [Action sharedActions]) {
        
        if (action == sharedAction || [_actionTableView isCellForItemExpanded:sharedAction])
            rows += sharedAction.availableActions.count;
    }
    
    [self actionTableFitsizeWithRows:rows animation:YES];
}
//将要收缩
- (void)treeView:(RATreeView *)treeView willCollapseRowForItem:(id)item {
    
    Action *action = item;
    
    NSInteger rows = [Action sharedActions].count;
    for (Action *sharedAction in [Action sharedActions]) {
        
        if (action != sharedAction && [_actionTableView isCellForItemExpanded:sharedAction])
            rows += sharedAction.availableActions.count;
    }
    
    [self actionTableFitsizeWithRows:rows animation:YES];
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
    [cell setAction:action level:level children:action.availableActions.count];
    
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
        
        return [Action sharedActions].count;
    }
    
    return action.availableActions.count;
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
        
        return [[Action sharedActions] objectAtIndex:index];
    }
    
    return [action.availableActions objectAtIndex:index];
}

//cell的点击方法
- (void)treeView:(RATreeView *)treeView didSelectRowForItem:(id)item {
    
    [treeView deselectRowForItem:item animated:NO];
    
    //获取当前的层
    NSInteger level = [treeView levelForCellForItem:item];
    
    //当前点击的model
    Action *action = item;
    
    if (action.availableActions.count == 0)
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

- (void)actionTableFitsizeWithRows:(NSInteger)rows animation:(BOOL)animation {
    
    __block CGFloat actionContainerViewBottom = 10;
    
    if (animation) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            if (!self.messageContainerView.hidden)
                actionContainerViewBottom = self.messageContainerView.height + 10;
                
            _actionContainerView.height = rows  * 30;
            
            if (_actionContainerView.height + 10 + actionContainerViewBottom > SCREEN_HEIGHT)
                _actionContainerView.height = SCREEN_HEIGHT - 10 - actionContainerViewBottom;
            
            _actionContainerView.bottom = SCREEN_HEIGHT - actionContainerViewBottom;
            //_myStatusGroupWidget.bottom = SCREEN_HEIGHT - actionContainerViewBottom;
        }];
        
        if (_gameGroupWidget.height + 20 > _actionContainerView.top) {
            
            if (_gameGroupWidget.left != 0) {
                
                [UIView animateWithDuration:0.3 animations:^{
                    
                    _gameGroupWidget.left = SCREEN_WIDTH;
                } completion:^(BOOL finished) {
                    
                    _gameGroupWidget.right = 0;
                    
                    [UIView animateWithDuration:0.3 animations:^{
                        
                        _gameGroupWidget.left = 0;
                    }];
                }];
            }
        }
        else {
            
            if (_gameGroupWidget.right != SCREEN_WIDTH) {
                
                [UIView animateWithDuration:0.3 animations:^{
                    
                    _gameGroupWidget.right = 0;
                } completion:^(BOOL finished) {
                    
                    _gameGroupWidget.left = SCREEN_WIDTH;
                    
                    [UIView animateWithDuration:0.3 animations:^{
                        
                        _gameGroupWidget.right = SCREEN_WIDTH;
                    }];
                }];
            }
        }
    }
    else {
        
        if (!self.messageContainerView.hidden)
            actionContainerViewBottom = self.messageContainerView.height + 10;
        
        _actionContainerView.height = rows  * 30;
        
        if (_actionContainerView.height + 10 + actionContainerViewBottom > SCREEN_HEIGHT)
            _actionContainerView.height = SCREEN_HEIGHT - 10 - actionContainerViewBottom;
        
        _actionContainerView.bottom = SCREEN_HEIGHT - actionContainerViewBottom;
        //_myStatusGroupWidget.bottom = SCREEN_HEIGHT - actionContainerViewBottom;
        
        if (_gameGroupWidget.height + 20 > _actionContainerView.top)
            _gameGroupWidget.left = 0;
        else
            _gameGroupWidget.right = SCREEN_WIDTH;
    }
    
}

- (void)actionTableFitsize {
    
    NSInteger rows = [Action sharedActions].count;
    for (Action *sharedAction in [Action sharedActions]) {
        
        if ([_actionTableView isCellForItemExpanded:sharedAction])
            rows += sharedAction.availableActions.count;
    }

    [self actionTableFitsizeWithRows:rows animation:NO];
}

- (void)shouldReloadGroupNotification:(NSNotification *)notification {
    
    _sceneWidget.scene = [Scene currentScene];
    _sceneWidget.width = 150.0f;
    //_sceneWidget.height = [_sceneWidget maxHeight];
    //_sceneWidget.bottom = SCREEN_WIDTH - 10.0f;
}

- (void)shouldReloadActionNotification:(NSNotification *)notification {
    
    _actionContainerView.width = [Action maxWidthOfActionCell];
    _actionContainerView.right = SCREEN_WIDTH - 10;
    
    [_actionTableView reloadData];
    [self actionTableFitsize];
    
//    NSLog(@"actionContainerView :%f, %f, %f, %f, %f",_actionContainerView.left, actionContainerView.top, actionContainerView.width, actionContainerView.height, _actionContainerView.alpha);
//    NSLog(@"actionTableView: %f, %f, %f, %f, %f",_actionTableView.left, _actionTableView.top, _actionTableView.width, _actionTableView.height, _actionTableView.alpha);
}

@end
