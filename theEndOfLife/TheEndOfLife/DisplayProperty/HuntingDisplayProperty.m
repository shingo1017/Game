//
//  HuntingDisplayProperty.m
//  destroy
//
//  Created by 尹楠 on 16/9/23.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "HuntingDisplayProperty.h"

@implementation NameDisplayProperty

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        self.belongToClassNames = @[@"HuntingGroup"];
        self.caption = @"地点：";
        self.type = DisplayPropertyTypeText;
        self.keyPath = @"Scene.name";
        //self.notificationKeyPaths = @[@"Game.time"];
        self.sort = 0;
    }
    return self;
}

- (NSString *)displayText {
    
    return [[Scene currentScene] property:@"name"];
}

@end

@implementation ProgressDisplayProperty

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        self.belongToClassNames = @[@"HuntingGroup"];
        self.caption = @"进度：";
        self.type = DisplayPropertyTypeText;
        self.keyPath = @"Scene.progress";
        //self.notificationKeyPaths = @[@"Game.time"];
        self.sort = 10;
    }
    return self;
}

- (NSString *)displayText {
    
    NSString *outsideSceneClassName = [[Scene currentScene] property:@"outsideSceneClassName"];
    Scene *scene = [Scene sceneWithClassName:outsideSceneClassName];
    return [NSString stringWithFormat:@"%li %%", [scene intProperty:@"progress"]];
}

@end
