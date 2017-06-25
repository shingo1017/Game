//
//  EquipmentCollectionCell.h
//  worldOfZombie
//
//  Created by 尹楠 on 15/2/20.
//  Copyright (c) 2015年 c2y. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"

@interface EquipmentCollectionCell : UICollectionViewCell {
    
    IBOutlet UILabel *captionLabel;
    IBOutlet UIButton *nameButton;
}

@property (nonatomic, retain) Item *item;

@end
