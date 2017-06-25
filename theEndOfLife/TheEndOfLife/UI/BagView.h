//
//  BagView.h
//  girl
//
//  Created by 尹楠 on 16/9/3.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ItemView.h"

@interface BagView : UIView <UICollectionViewDataSource, UICollectionViewDelegate> {
    
    UICollectionView *itemCollectionView;
    ItemView *itemView;
}

+ (BagView *)sharedView;

- (void)show;
- (CGFloat)maxHeight;

@end
