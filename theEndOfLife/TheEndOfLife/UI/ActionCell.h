//
//  ActionCell.h
//  girl
//
//  Created by 尹楠 on 15/2/20.
//  Copyright (c) 2015年 c2y. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActionCell : UITableViewCell {
    
    IBOutlet UIView *flagView;
    IBOutlet UILabel *nameLabel;
}

@property (nonatomic, retain) Action *action;

- (void)setAction:(Action *)action level:(NSInteger)level children:(NSInteger)children;

@end
