//
//  SurvivorsView.h
//  worldOfZombie
//
//  Created by 尹楠 on 14-9-3.
//  Copyright (c) 2014年 c2y. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SurvivorsView : UIView <UITableViewDataSource, UITableViewDelegate> {
    
    IBOutlet UIButton *nameButton;
    IBOutlet UIButton *surviveDaysButton;
    
    IBOutlet UITableView *survivorTableView;
}

- (IBAction)meetingButtonClicked:(id)sender;

@end
