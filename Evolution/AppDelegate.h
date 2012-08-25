//
//  AppDelegate.h
//  Evolution
//
//  Created by Richard Adem on 7/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;
@interface AppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end