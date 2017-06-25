//
//  MainView.m
//  zombie
//
//  Created by 尹楠 on 16/9/2.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "MainView.h"
#import "Group.h"
#import "NSString+Additions.h"
#import "GroupWidget.h"

@interface MainView () {
    
    NSMutableDictionary *_scenesDictionary;
    
    UIButton *_continueButton;
}

@end

@implementation MainView

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shouldReloadSceneNotification:) name:K_SHOULD_RELOAD_SCENE_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shouldReloadActionNotification:) name:K_SHOULD_RELOAD_ACTION_NOTIFICATION object:nil];
    
    _continueButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _continueButton.frame = self.view.bounds;
    _continueButton.hidden = YES;
    [_continueButton addTarget:self action:@selector(continueButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_continueButton];
    
    _scenesDictionary = [NSMutableDictionary new];
    
    PlaceScene *placeScene = [Utility objectForClassName:@"PlaceScene"];
    NSString *defaultPlaceId = [[Game sharedGame] property:k_myPlaceId];
    [placeScene showWithPlaceId:defaultPlaceId];
    
    MapScene *mapScene = [Utility objectForClassName:@"MapScene"];
    CGPoint currentCoordinate = CGPointFromString([placeScene.place property:k_coordinate]);
    [mapScene showWithCoordinate:currentCoordinate];
    mapScene.hidden = YES;    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (MainView *)sharedView {
    
    return (MainView *)[super sharedView];
}

- (void)showScene:(Scene *)scene {
    
    Scene *sceneInstance = _scenesDictionary[NSStringFromClass(scene.class)];
    if (!sceneInstance) {
        
        [self.sceneContainerView addSubview:scene];
        _scenesDictionary[NSStringFromClass(scene.class)] = scene;
    }
}

- (void)hideScene:(Scene *)scene {
    
    [_scenesDictionary removeObjectForKey:NSStringFromClass(scene.class)];
    [scene removeFromSuperview];
    scene = nil;
}

- (Scene *)sceneForClassName:(NSString *)className {
    
    return _scenesDictionary[className];
}

- (void)showContinueButton {
    
    _continueButton.hidden = NO;
}

- (void)continueButtonClicked {
    
    [[Story currentStory] excuteNextCutscene];
    
    _continueButton.hidden = YES;
}

- (void)transferSceneWithClassName:(NSString *)className completion:(void (^)(void))completionBlock {
    
    [super transferSceneWithClassName:className completion:completionBlock];
}

- (void)didTransferSceneWithClassName:(NSString *)className {
    
    [super didTransferSceneWithClassName:className];
    
    //self.sceneImageView.image = [UIImage imageNamed:[[SceneClass currentScene] property:@"sceneImageName"]];
    
    [Message hideMessage];
    
    //TODO:加这句会报错，因为game_current_scene里实例化了FiefScene，它是UIView，访问Property就异常了。
    [Action applySceneActions];
}

- (void)shouldReloadSceneNotification:(NSNotification *)notification {
    
    /*for (UIView *view in _groupWidgetContainerView.subviews) {
        
        [view removeFromSuperview];
    }
    
    NSArray *resultArray = [((NSArray *)[[Scene currentScene] property:@"groups"]) sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        NSNumber *sort1 = [NSNumber numberWithInteger:[[obj1 valueForKey:@"sort"] integerValue]];
        NSNumber *sort2 = [NSNumber numberWithInteger:[[obj2 valueForKey:@"sort"] integerValue]];
        
        NSComparisonResult result = [sort1 compare:sort2];
        
        return result == NSOrderedDescending; // 升序
    }];
    
    for (Group *group in resultArray) {
        
        GroupWidget *groupWidget = [[GroupWidget alloc] initWithFrame:group.frame];
        groupWidget.backgroundColor = RGBA(0, 0, 0, 0.7);
        groupWidget.group = group;
        [_groupWidgetContainerView addSubview:groupWidget];
    }*/
}

- (void)shouldReloadActionNotification:(NSNotification *)notification {
    
    
}

@end
