//
//  Untitled4AppDelegate.h
//  Untitled4
//
//  Created by jy on 11-3-14.
//  Copyright 2011 jy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Untitled4ViewController;

@interface Untitled4AppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    Untitled4ViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet Untitled4ViewController *viewController;

@end

