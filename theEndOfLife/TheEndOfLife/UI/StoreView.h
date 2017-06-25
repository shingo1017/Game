//
//  StoreView.h
//  girl
//
//  Created by 尹楠 on 16/9/3.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemView.h"

@interface StoreView : UIView <UICollectionViewDataSource, UICollectionViewDelegate> {
    
    UICollectionView *itemCollectionView;
    ItemView *itemView;
}

+ (StoreView *)sharedView;

- (void)show;
- (CGFloat)maxHeight;

@end
