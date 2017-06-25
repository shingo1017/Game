//
//  SceneSpaceView.h
//  worldOfZombie
//
//  Created by 尹楠 on 15/6/29.
//  Copyright (c) 2015年 c2y. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "BaseView.h"
//#import "SurvivorsView.h"
//#import "ItemsView.h"

@interface SceneSpaceView : UIView {
    
    BaseView *baseView;
    SurvivorsView *survivorsView;
//    ItemsView *itemsView;
}

- (IBAction)baseViewButtonClicked:(id)sender;
- (IBAction)survivorsViewButtonClicked:(id)sender;
- (IBAction)itemsViewButtonClicked:(id)sender;
- (IBAction)settingViewButtonClicked:(id)sender;

@end
