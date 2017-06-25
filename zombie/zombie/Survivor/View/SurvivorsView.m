//
//  SurvivorsView.m
//  worldOfZombie
//
//  Created by 尹楠 on 14-9-3.
//  Copyright (c) 2014年 c2y. All rights reserved.
//

#import "SurvivorsView.h"
#import "Base.h"
#import "Survivor.h"
#import "SpaceSurvivorTableViewCell.h"
#import "SurvivorView.h"
#import "MeetingView.h"

@interface SurvivorsView ()

@end

@implementation SurvivorsView

- (void)awakeFromNib {
    
    [super awakeFromNib];
    // Do any additional setup after loading the view.
    
    [nameButton setTitle:@"幸存者" forState:UIControlStateNormal];
    [nameButton sizeToFit];
    nameButton.frame = CGRectMake(nameButton.frame.origin.x, nameButton.frame.origin.y, nameButton.frame.size.width + 10.0f, 40.0f);
    
    [surviveDaysButton setTitle:[NSString stringWithFormat:@"第 %i 天 08:00", 1] forState:UIControlStateNormal];
    [surviveDaysButton sizeToFit];
    surviveDaysButton.frame = CGRectMake(SCREEN_WIDTH - 10.0f - surviveDaysButton.frame.size.width, nameButton.frame.origin.y, surviveDaysButton.frame.size.width, nameButton.frame.size.height);
    
    [survivorTableView reloadData];
}

- (IBAction)meetingButtonClicked:(id)sender {
    
    [[MeetingView sharedMeetingView] showWithSurvivors:[Base defaultBase].survivors];
}


#pragma mark UITableViewDataSource method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [Base defaultBase].survivors.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 1.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Survivor *survivor = [[Base defaultBase].survivors objectAtIndex:indexPath.row];
    NSString *identifier = @"SpaceSurvivorTableViewCell";
    SpaceSurvivorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
        cell = (SpaceSurvivorTableViewCell *)[UIView viewWithName:identifier];
    
    cell.survivor = survivor;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    Survivor *survivor = [[Base defaultBase].survivors objectAtIndex:indexPath.row];
    [[SurvivorView sharedSurvivorView] showWithSurvivor:survivor];
}

@end
