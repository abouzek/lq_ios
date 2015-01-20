//
//  AppDelegate.h
//  Anniversary
//
//  Created by Alan Bouzek on 12/11/14.
//  Copyright (c) 2014 Alan Bouzek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AVAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

-(void)registerLoggedInUserForPushNotifications;
-(void)showLogin;
-(void)showMenu;

@end


