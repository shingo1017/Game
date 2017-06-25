//
//  Untitled4ViewController.h
//  Untitled4
//
//  Created by jy on 11-3-14.
//  Copyright 2011 jy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Untitled4ViewController : UIViewController {
	IBOutlet UIButton *btnGo;
	IBOutlet UIButton *btnChangeMap;
	UIImageView *player;
	UIImageView *dest;
	int count;
	UIView *pathView;
	UIView *mapView;
}
- (IBAction)btnGoTapped;
- (IBAction)btnChangeMapTapped;
typedef struct 
{
	int w,step,state,x,y;
}QueData;
int astarSearch();
- (void)movePlayer;
@end

