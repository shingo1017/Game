//
//  StoreView.m
//  girl
//
//  Created by 尹楠 on 16/9/3.
//  Copyright © 2016年 尹楠. All rights reserved.
//

#import "StoreView.h"
#import "GroupWidget.h"
#import "BagCell.h"

@interface StoreView () {
    
    NSArray *_groups;
    NSArray *_items;
    NSArray *_actions;
}

@end

@implementation StoreView

static StoreView *_sharedView;

+ (StoreView *)sharedView {
    
    return _sharedView;
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        _groups = [Utility getSubClassInstancesWithFatherClassName:@"Group" belongToClassName:NSStringFromClass([self class])];
    }
    return self;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:K_SHOULD_RELOAD_STORE_NOTIFICATION object:nil];
    
    _sharedView = self;
}

- (void)show {
    
    for (UIView *view in self.subviews) {
        
        [view removeFromSuperview];
    }
    
    Group *group = [Utility objectForClassName:@"StoreInfoGroup"];
    _groups = [NSArray arrayWithObject:group];
    
    NSArray *resultArray = [_groups sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        NSNumber *sort1 = [NSNumber numberWithInteger:[[obj1 valueForKey:@"sort"] integerValue]];
        NSNumber *sort2 = [NSNumber numberWithInteger:[[obj2 valueForKey:@"sort"] integerValue]];
        
        NSComparisonResult result = [sort1 compare:sort2];
        
        return result == NSOrderedDescending; // 升序
    }];
    
    int y = 0;
    for (Group *group in resultArray) {
        
        GroupWidget *groupWidget = [[GroupWidget alloc] initWithFrame:CGRectMake(0, y, SCREEN_HEIGHT, 0)];
        groupWidget.group = group;
        [self addSubview:groupWidget];
        
        y = groupWidget.bottom + 10;
    }
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置对齐方式
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    //cell间距
    layout.minimumInteritemSpacing = 2.0f;
    //cell行距
    layout.minimumLineSpacing = 2.0f;
    
    itemCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 60, 355, 200) collectionViewLayout:layout];
    [itemCollectionView registerNib:[UINib nibWithNibName:@"BagCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"BagCell"];
    itemCollectionView.dataSource = self;
    itemCollectionView.delegate = self;
    itemCollectionView.backgroundColor = [UIColor clearColor];
    [self addSubview:itemCollectionView];
    
    itemView = [[ItemView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, 150, 200)];
    [self addSubview:itemView];
    
    [MainView sharedView].messageContainerView.hidden = YES;
    
    self.right = 0;
    [UIView animateWithDuration:0.3 animations:^{
        
        self.left = 0;
        [MainView sharedView].sceneWidget.alpha = 0.0f;
        [MainView sharedView].viewMaskView.alpha = 1.0f;
    }];
    
    [[MainView sharedView] hideMyImageWithAnimation:YES];
    [[MainView sharedView] hidePartnerImageWithAnimation:YES];
    
    [self reloadData];
}

- (void)reloadData {
    
    _items = [[Store sharedStore] itemGroups];
    [itemCollectionView reloadData];
    
    [self reloadActions];
    
    [itemView close];
}

- (void)reloadActions {
    
    _actions = [NSArray arrayWithArray:[[Store sharedStore] property:@"actions"]];
    id closeAction = [Utility objectForClassName:@"StoreViewCloseAction"];
    _actions = [_actions arrayByAddingObjectsFromArray:@[closeAction]];
    
    [Action clearActions];
    [Action appendActions:_actions];
}

- (CGFloat)maxHeight {
    
    CGFloat maxHeight = 0;
    
    for (UIView *view in self.subviews) {
        
        if (view.bottom > maxHeight)
            maxHeight = view.bottom;
    }
    
    return maxHeight;
}

#pragma mark - UICollectionViewDataSource method

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _items.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(80, 80);
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier = @"BagCell";
    BagCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    NSArray *items = [_items objectAtIndex:indexPath.row];
    Item *item = [items firstObject];
    cell.nameLabel.text = [item property:@"name"];
    
    NSInteger count = items.count;
    if (count > 1)
        cell.countLabel.text = Int2String(count);
    else
        cell.countLabel.text = @"";
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    Item *item = [[_items objectAtIndex:indexPath.row] firstObject];
    [itemView showWithItem:item];
    
    [Action clearActions];
    _actions = [NSArray arrayWithArray:[item property:@"actions"]];
    id takeAction = [Utility objectForClassName:@"StoreViewTakeAction"];
    id closeAction = [Utility objectForClassName:@"StoreViewCloseAction"];
    _actions = [_actions arrayByAddingObjectsFromArray:@[takeAction, closeAction]];
    [Action appendActions:_actions];
}

@end
