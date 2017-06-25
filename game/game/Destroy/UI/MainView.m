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
    
    NSTimer *_messageTimer;
    NSInteger _messageIndex;
}

@end

@implementation MainView

static MainView *_sharedView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shouldReloadGroupNotification:) name:K_SHOULD_RELOAD_GROUP_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shouldReloadMessageNotification:) name:K_SHOULD_RELOAD_MESSAGE_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shouldReloadActionNotification:) name:K_SHOULD_RELOAD_ACTION_NOTIFICATION object:nil];
    
    id group = [Utility objectForClassName:@"TimeGroup"];
    _gameGroupWidget.group = group;
    
    [_actionTableView registerNib:[UINib nibWithNibName:@"ActionCell" bundle:nil] forCellReuseIdentifier:@"ActionCell"];
    _actionTableView.backgroundColor = [UIColor clearColor];
    _actionTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _actionTableView.dataSource = self;
    _actionTableView.delegate = self;
    
    _sharedView = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (MainView *)sharedView {
    
    return _sharedView;
}

- (void)showTime {
    
    _gameGroupWidget.hidden = NO;
}

- (void)hideTime {
    
    _gameGroupWidget.hidden = YES;
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
    
    _messageLabel.height = [_messageLabel.text heightOfAttributedText:_messageLabel.attributedText width:_messageLabel.width];
    _messageContainerView.height = _messageLabel.height + 30;
    _messageContainerView.bottom = SCREEN_HEIGHT;
    actionContainerView.height = [Action sharedActions].count * 30;
    actionContainerView.bottom = _messageContainerView.top - 10;
}

- (void)messageTimerTicked {
    
    bool eof = NO;
    
    if (_messageIndex >= [Message lastMessage].text.length) {
        
        eof = YES;
        
        [[Cutscene currentCutscene] stepOver];
    }
    else {
    
        _messageLabel.text = [_messageLabel.text stringByAppendingString:[[Message lastMessage].text substringWithRange:NSMakeRange(_messageIndex, 1)]];
        
        _messageLabel.attributedText = [_messageLabel.text attributedStringWithFontSize:_messageLabel.font.pointSize textColor:_messageLabel.textColor];
        
        [self reloadMessage];
    }

    _messageIndex += 1;
    
    if (!eof) {
        
        [self performSelector:@selector(messageTimerTicked) withObject:nil afterDelay:[System system].messageSpeed];
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
            
            if (!_messageContainerView.hidden)
                actionContainerViewBottom = _messageContainerView.height + 10;
                
            actionContainerView.height = rows  * 30;
            
            if (actionContainerView.height + 10 + actionContainerViewBottom > SCREEN_HEIGHT)
                actionContainerView.height = SCREEN_HEIGHT - 10 - actionContainerViewBottom;
            
            actionContainerView.bottom = SCREEN_HEIGHT - actionContainerViewBottom;
        }];
        
        if (_gameGroupWidget.height + 20 > actionContainerView.top) {
            
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
        
        if (!_messageContainerView.hidden)
            actionContainerViewBottom = _messageContainerView.height + 10;
        
        actionContainerView.height = rows  * 30;
        
        if (actionContainerView.height + 10 + actionContainerViewBottom > SCREEN_HEIGHT)
            actionContainerView.height = SCREEN_HEIGHT - 10 - actionContainerViewBottom;
        
        actionContainerView.bottom = SCREEN_HEIGHT - actionContainerViewBottom;
        
        if (_gameGroupWidget.height + 20 > actionContainerView.top)
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

/*- (void)shouldReloadGroupNotification:(NSNotification *)notification {
    
    _sceneWidget.scene = [Scene currentScene];
    _sceneWidget.width = 150.0f;
    _sceneWidget.height = [_sceneWidget maxHeight];
    _sceneWidget.bottom = SCREEN_WIDTH - 10.0f;
}*/

- (void)shouldReloadMessageNotification:(NSNotification *)notification {
    
    _messageIndex = 0;
    
    _messageContainerView.hidden = NO;
    
    if ([Message lastMessage].displayDirectly) {
        
        _messageLabel.text = [Message lastMessage].text;
        _messageLabel.attributedText = [_messageLabel.text attributedStringWithFontSize:_messageLabel.font.pointSize textColor:_messageLabel.textColor];
        
        [self reloadMessage];
    }
    else
        
        [self performSelector:@selector(messageTimerTicked) withObject:nil afterDelay:[System system].messageSpeed];
        //_messageTimer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(messageTimerTicked) userInfo:nil repeats:YES];
}

- (void)shouldReloadActionNotification:(NSNotification *)notification {
    
    actionContainerView.width = [Action maxWidthOfActionCell];
    actionContainerView.right = SCREEN_WIDTH - 10;
    
    [_actionTableView reloadData];
    [self actionTableFitsize];
}

@end
