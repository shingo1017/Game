//
//  PlacePickerScene.h
//  zombie
//
//  Created by 尹楠 on 17/6/14.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import "LayerScene.h"

@interface PlacePickerScene : LayerScene

- (void)showForDistance:(NSInteger)distance
            fromPlaceId:(NSString *)fromPlaceId
                  title:(NSString *)title
             completion:(void (^)(Place *place))completion;

@end
