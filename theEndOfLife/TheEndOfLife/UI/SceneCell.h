//
//  SceneCell.h
//  theEndOfLife
//
//  Created by 尹楠 on 16/10/11.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SceneCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, assign) BOOL searchFinished;

@end
