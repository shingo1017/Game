//
//  NumberWidget.h
//  seller
//
//  Created by Shingo on 13-3-16.
//  Copyright (c) 2013年 Shingo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NumberType) {
    
    NumberTypeInt,
    NumberTypeFloat
};

@protocol NumberWidgetDelegate;

@interface NumberWidget : UIView

@property (nonatomic, weak) id<NumberWidgetDelegate> delegate;
@property (nonatomic, assign) NumberType numberType;
@property (nonatomic, assign) CGFloat number;
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, assign) BOOL empty;
@property (nonatomic, assign) BOOL focus;
@property (nonatomic, assign) BOOL editable;

@end

@protocol NumberWidgetDelegate <NSObject>

- (void)editDidChange:(NumberWidget *)numberWidget;
- (void)editDidEnd:(NumberWidget *)numberWidget;

@end
