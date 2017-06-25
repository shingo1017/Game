//
//  GridCell.h
//  zombie
//
//  Created by 尹楠 on 17/5/25.
//  Copyright © 2017年 尹楠. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, GridCellStyle) {
    
    GridCellStyleDefault,
    GridCellStyleHighlight,
    GridCellStyleDisabled,
};

@interface GridCell : UITableViewCell

@property (nonatomic, strong) NSArray *texts;
@property (nonatomic, strong) NSArray *widthLimits;
@property (nonatomic, strong) NSArray *colors;
@property (nonatomic, assign) BOOL isTitle;
@property (nonatomic, assign) GridCellStyle style;

@end
