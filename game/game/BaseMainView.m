//
//  BaseMainView.m
//  girl
//
//  Created by 尹楠 on 16/9/2.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "BaseMainView.h"
#import "BaseCutscene.h"
#import "NSString+Additions.h"

@interface BaseMainView () {
    
    NSTimer *_messageTimer;
    NSInteger _messageIndex;
}

@end

@implementation BaseMainView

static BaseMainView *_sharedView;

+ (__kindof BaseMainView *)sharedView {
    
    return _sharedView;
}

+ (void)setSharedView:(BaseMainView *)baseMainView; {
    
    _sharedView = baseMainView;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shouldReloadMessageNotification:) name:K_SHOULD_RELOAD_MESSAGE_NOTIFICATION object:nil];
    
    [self initSceneLayerViews];
    
    //[self initCustomLayerViews];
    
    //[self initMessageLayerViews];
    
    //[self initSceneTransferLayerViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initSceneLayerViews {
    
    /*_sceneImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    _sceneImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:_sceneImageView];*/
    
    _sceneContainerView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_sceneContainerView];
    
    /*_viewMaskView = [[UIView alloc] initWithFrame:self.view.bounds];
    _viewMaskView.backgroundColor = RGBA(0, 0, 0, 0.7);
    _viewMaskView.alpha = 0;
    [self.view addSubview:_viewMaskView];*/
}

- (void)initCustomLayerViews {
    
    
}

- (void)initMessageLayerViews {
    
    _messageContainerView = [[UIView alloc] initWithFrame:self.view.bounds];
    _messageContainerView.backgroundColor = RGBA(0, 0, 0, 0.7);
    _messageContainerView.alpha = 1;
    [self.view addSubview:_messageContainerView];
    
    _messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, self.view.width - 20, self.view.height - 30)];
    _messageLabel.font = [UIFont systemFontOfSize:13];
    _messageLabel.textColor = WHITE_COLOR;
    [_messageContainerView addSubview:_messageLabel];
}

- (void)initSceneTransferLayerViews {
    
    _sceneTransferMaskView = [[UIView alloc] initWithFrame:self.view.bounds];
    _sceneTransferMaskView.backgroundColor = RGBA(0, 0, 0, 1);
    _sceneTransferMaskView.alpha = 1;
    [self.view addSubview:_sceneTransferMaskView];
}

- (void)transferSceneWithClassName:(NSString *)className {
    
    [self transferSceneWithClassName:className animation:YES completion:nil];
}

- (void)transferSceneWithClassName:(NSString *)className animation:(BOOL)animation {
    
    [self transferSceneWithClassName:className animation:animation completion:nil];
}

- (void)transferSceneWithClassName:(NSString *)className completion:(void (^)(void))completionBlock {
    
    [self transferSceneWithClassName:className animation:YES completion:completionBlock];
}

- (void)transferSceneWithClassName:(NSString *)className animation:(BOOL)animation completion:(void (^)(void))completionBlock {
    
    [SceneClass transferSceneWithClassName:className];
    
    if (animation) {
        
        [UIView animateWithDuration:0.8f animations:^{
            
            self.sceneTransferMaskView.alpha = 1.0f;
        } completion:^(BOOL finished) {
            
            [self didTransferSceneWithClassName:className];
            
            [UIView animateWithDuration:0.8f animations:^{
                
                self.sceneTransferMaskView.alpha = 0.0f;
            }];
        }];
    }
    else
        [self didTransferSceneWithClassName:className];
}

- (void)didTransferSceneWithClassName:(NSString *)className {
    
    
}

- (void)reloadMessage {
    
    _messageLabel.height = [_messageLabel.text heightOfAttributedText:_messageLabel.attributedText width:_messageLabel.width];
    _messageContainerView.height = _messageLabel.height + 30;
    _messageContainerView.bottom = SCREEN_HEIGHT;
}

- (void)messageTimerTicked {
    
    bool eof = NO;
    
    if (_messageIndex >= [Message lastMessage].text.length) {
        
        eof = YES;
        
        [[CutsceneClass currentCutscene] stepOver];
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

@end
