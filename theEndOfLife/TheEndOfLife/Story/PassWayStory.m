//
//  PassWayStory.m
//  destroy
//
//  Created by 尹楠 on 16/9/22.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "PassWayStory.h"

@implementation PassWayStory

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        Scene *destinationScene = [[Game sharedGame] property:@"destinationScene"];
        Scene *passWayScene = [Utility objectForClassName:[destinationScene property:@"passWayScene"]];
        NSInteger time = [destinationScene intProperty:@"timeOfPassWayToChurchScene"];
        
        [[Person me] setProperty:[destinationScene property:@"passWayScene"] forKey:@"scene"];
        [self addCutscenesWithCommandTexts:@[
                                             [NSString stringWithFormat:@"#ic:%@|#event:%li|#c|行进中……|#w:1.0|#event:%li|#c|行进中……|#w:1.0|#event:%li|#c|行进中……|#w:1.0|#c|到达目的地了。", [passWayScene property:@"sceneImageName"], time, time, time],
                                             ]];
        self.sceneClassNameWhenEndOfStory = NSStringFromClass([destinationScene class]);
    }
    return self;
}

- (void)storyEvent:(NSString *)value {
    
    NSInteger minutes = [value integerValue];
    [[Game sharedGame] dateProperty:@"time" plus:Minutes(minutes)];
    [[Person me] intProperty:@"energy" plus:-minutes];
    [[Person me] intProperty:@"thirsty" plus:-minutes];
    [[Person me] intProperty:@"sober" plus:-minutes];
}

- (void)storyResult {
    
    [Message hideMessage];
}

@end
