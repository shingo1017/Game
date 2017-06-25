//
//  PlaceScene.h
//  zombie
//
//  Created by 尹楠 on 17/5/16.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceScene : Scene

@property (nonatomic, strong, readonly) Place *place;
@property (nonatomic, copy, readonly) NSString *placeId;

@property (nonatomic, strong) NSArray *actions;

+ (PlaceScene *)sharedScene;
//+ (void)setSharedScene:(PlaceScene *)sharedScene;

- (void)showWithPlaceId:(NSString *)placeId;

@end
