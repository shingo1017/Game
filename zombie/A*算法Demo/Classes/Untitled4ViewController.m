//
//  Untitled4ViewController.m
//  Untitled4
//
//  Created by jy on 11-3-14.
//  Copyright 2011 jy. All rights reserved.
//  A*搜索算法，实现寻路

#import "Untitled4ViewController.h"

@implementation Untitled4ViewController
/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
int start,end;
int map[30][20];
int goCount;
int path[600][2],pathTop;
- (void)viewDidLoad {
    [super viewDidLoad];
	
	start = end = -1;
	mapView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	mapView.backgroundColor = [UIColor clearColor];
	[self.view addSubview:mapView];
	[mapView release];
	
	for (int i=0; i<30; i++) {
		for (int j=0; j<20; j++) {
			map[i][j] = arc4random()%3 + 1;
			if (map[i][j] == 1) {
				UIImageView *brick = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"brick.jpg"]];
				[mapView addSubview:brick];
				brick.frame = CGRectMake(j*16, i*16, 16, 16);
				[brick release];
			}
			else {
				map[i][j] = 0;
			}

		}
	}
	dest = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"destination.png"]];
	[self.view addSubview:dest];
	[dest release];
	
	player = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"player.png"]];
	[self.view addSubview:player];
	[player release];
	
	player.hidden = YES;
	btnGo.hidden = YES;
	dest.hidden = YES;
	
	pathView = [[UIView alloc] init];
	pathView.frame = CGRectMake(0, 0, 320, 480);
	pathView.backgroundColor = [UIColor clearColor];
	[self.view insertSubview:pathView belowSubview:dest];
	[pathView release];
	[self.view bringSubviewToFront:btnChangeMap];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" 
													message:@"点击两个点，分别放置起点和终点" 
												   delegate:nil 
										  cancelButtonTitle:@"OK" 
										  otherButtonTitles:nil];
	[alert show];
	[alert release];
	
	
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}
- (void)newGame
{
	btnGo.hidden = YES;
	goCount = 0;
	start = -1;
	end = -1;
	count = 0;
	pathTop = 0;
	player.hidden = YES;
	dest.hidden = YES;
	btnChangeMap.hidden = NO;
	for (UIView *view in [pathView subviews]) {
		[view removeFromSuperview];
	}
}
- (IBAction)btnGoTapped
{
	if (astarSearch() == 0){
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"路径不存在" 
														message:[NSString stringWithFormat:@"共探索%d次,点击以重新指定地点",goCount] 
													   delegate:nil 
											  cancelButtonTitle:@"OK" 
											  otherButtonTitles:nil];
		[alert show];
		[alert release];
		[self newGame];
	}
	else {
		btnGo.hidden = YES;
		NSLog(@"%d次",goCount);
		[self movePlayer];
	}
}
- (IBAction)btnChangeMapTapped
{
	for (UIView *view in mapView.subviews) {
		[view removeFromSuperview];
	}
	for (int i=0; i<30; i++) {
		for (int j=0; j<20; j++) {
			map[i][j] = arc4random()%3 + 1;
			if (map[i][j] == 1) {
				UIImageView *brick = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"brick.jpg"]];
				[mapView addSubview:brick];
				brick.frame = CGRectMake(j*16, i*16, 16, 16);
				[brick release];
			}
			else {
				map[i][j] = 0;
			}

		}
	}
}
- (void)movePlayer
{
	
	[UIView beginAnimations:@"Astar" context:nil];
	[UIView setAnimationDuration:0.3];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
	[UIView setAnimationDelegate:self];
	player.frame = CGRectMake(path[count][1] * 16, path[count][0] * 16, 16, 16);
	[UIView commitAnimations];
}
- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
	UIImageView *road = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"path.png"]];
	road.frame = CGRectMake(path[count][1] * 16, path[count][0] * 16, 16, 16);
	[pathView addSubview:road];
	[road release];
	count++;
	if (count < pathTop) {
		[self movePlayer];	
	}
	else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"寻路完成" 
														message:[NSString stringWithFormat:@"共%d步,共探索%d次,点击以重新指定地点",pathTop-1,goCount] 
													   delegate:self 
											  cancelButtonTitle:@"OK" 
											  otherButtonTitles:nil];
		[alert show];
		[alert release];
	}

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	[self newGame];
}
- (void) touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event
{
	UITouch * theTouch = [touches anyObject];
	CGPoint point = [theTouch locationInView:self.view];
	if (start == -1) {
		start = (int)point.y / 16 * 20 + (int)point.x / 16;
		if (map[start / 20][start % 20] == 1) {
			start = -1;
			return;
		}
		player.frame = CGRectMake(start % 20 * 16,start / 20 * 16, 16, 16);
		player.hidden = NO;
		btnChangeMap.hidden = YES;
	}
	else if (end == -1){
		end = (int)point.y / 16 * 20 + (int)point.x / 16;
		if (map[end / 20][end % 20] == 1) {
			end = -1;
			return;
		}
		dest.frame = CGRectMake(end % 20 * 16,end / 20 * 16, 16, 16);
		dest.hidden = NO;
		btnGo.hidden = NO;
		[self.view bringSubviewToFront:btnGo];
	}
}
#pragma mark AstarSearch
int d[4][2]={-1,0, 0,-1, 1,0, 0,1};
int pre[600],best[600];
QueData que[600];
void push_heap(QueData a[],int pa)
{
	int pos=pa-1;
	QueData tmp=a[pa-1];
	while(pos>0&&(a[(pos-1)>>1].w>tmp.w||a[(pos-1)>>1].w==tmp.w&&a[(pos-1)>>1].step>tmp.step)){
		a[pos]=a[(pos-1)>>1];
		pos=(pos-1)>>1;
	}
	a[pos]=tmp;
}
void pop_heap(QueData a[],int pa)
{
	int pos=1;
	QueData tmp=a[pa-1];
	if(pos+1<pa-1&&(a[pos].w>a[pos+1].w||a[pos].w==a[pos+1].w&&a[pos].step>a[pos+1].step)){
		pos++;
	}
	while(pos<pa-1&&(tmp.w>a[pos].w||tmp.w==a[pos].w&&tmp.step>a[pos].step)){
		a[(pos-1)>>1]=a[pos];
		pos=(pos<<1)+1;
		if(pos+1<pa-1&&(a[pos].w>a[pos+1].w||a[pos].w==a[pos+1].w&&a[pos].step>a[pos+1].step)){
			pos++;
		}
	}
	a[(pos-1)>>1]=tmp;
}

bool inside(int x,int y)
{
	return x>=0&&x<30&&y>=0&&y<20;
}
int abs(int x)
{
	return x>=0?x:-x;
}
int diff(int x,int y)
{
	return abs(x - end / 20) + abs(y - end % 20);
}
void getPath(int state)
{
	if(state==start){
		path[pathTop][0] = state / 20;
		path[pathTop++][1] = state % 20;
		return;
	}
	getPath(pre[state]);
	printf("%d,%d\n",state / 20, state % 20);
	path[pathTop][0] = state / 20;
	path[pathTop++][1] = state % 20;
}
int astarSearch()
{
	memset(best,-1,sizeof(best));
	que[0].step = 0;
	que[0].state = start;
	que[0].w = 0;
	que[0].x = start / 20;
	que[0].y = start % 20;
	best[start] = 0;
	QueData now,next;
	int ph=1;
	int i;
	while(ph){
		goCount++;
		now=que[0];
		pop_heap(que,ph--);
		if(now.state==end){
			getPath(now.state);
			putchar('\n');
			return 1;
		}
		if (best[now.state] != now.step) {
			continue;
		}
		for(i=0;i<4;i++){
			next.x=now.x+d[i][0];
			next.y=now.y+d[i][1];
			if(inside(next.x,next.y) && map[next.x][next.y] == 0){
				next.state=next.x * 20 + next.y;
				next.step=now.step+1;
				if(best[next.state] != -1 && best[next.state] <= next.step){
					continue;
				}
				best[next.state] = next.step;
				next.w=next.step+diff(next.x,next.y);
				que[ph++]=next;
				push_heap(que,ph);
				pre[next.state]=now.state;
			}
		}
	}
	return 0;
}
@end
