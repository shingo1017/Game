//
//  MapView.h
//  girl
//
//  Created by 尹楠 on 16/9/3.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapView : UIView <UICollectionViewDataSource, UICollectionViewDelegate> {
    
    UICollectionView *sceneCollectionView;
}

+ (StoreView *)sharedView;

- (void)show;
- (CGFloat)maxHeight;

@end
