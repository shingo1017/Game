//
//  Entity+MapProperty.h
//  theEndOfLife
//
//  Created by 尹楠 on 16/12/21.
//  Copyright © 2016年 尹楠. All rights reserved.
//

@interface Entity (MapProperty)

@property (nonatomic, readonly, weak) Entity *northPlace;
@property (nonatomic, readonly, weak) Entity *westPlace;
@property (nonatomic, readonly, weak) Entity *southPlace;
@property (nonatomic, readonly, weak) Entity *eastPlace;

@property (nonatomic, assign) CGPoint coordinate;

- (NSString *)landformText;

@end
