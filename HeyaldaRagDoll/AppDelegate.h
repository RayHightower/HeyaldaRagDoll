//
//  AppDelegate.h
//  HeyaldaRagDoll
//
//  Created by Jim Range on 7/16/12.
//  Copyright 2012 Heyalda Corporation 2012. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window_;
	RootViewController	*viewController_;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) RootViewController *viewController;

@end
