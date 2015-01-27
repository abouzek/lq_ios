//
//  AppDelegate.m
//  Anniversary
//
//  Created by Alan Bouzek on 12/11/14.
//  Copyright (c) 2014 Alan Bouzek. All rights reserved.
//

#import "AVAppDelegate.h"
#import "AVUserManager+AutoLogin.h"
#import "AVViewControllerUtility.h"
#import "AVUserNetworkUtility.h"
#import "AVSegmentedContainerViewController.h"
#import "AVConstants.h"
#import "AVCouponTableViewController.h"
#import "AVCouponEditTableViewController.h"
#import <MZFormSheetController.h>

@implementation AVAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self setupAppearances];
    
    // Auto login if necessary
    if ([AVUserManager savedManager]) {
        [self showMenu];
    }
    else {
        [self showLogin];
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceTokenData {
    AVUser *currentUser = [AVUserManager manager].currentUser;
    NSString *deviceToken = [[deviceTokenData description]
                             stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    deviceToken = [deviceToken stringByReplacingOccurrencesOfString:@" "
                                                         withString:@""];
    AVPushRegistration *pushRegistration = [AVPushRegistration pushRegistrationForUser:currentUser
                                                                           deviceToken:deviceToken];
    [AVUserNetworkUtility registerPush:pushRegistration
                          successBlock:nil
                          failureBlock:nil];
}


#pragma mark - utility methods

-(void)registerLoggedInUserForPushNotifications {
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge
                                                                             categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    [[UIApplication sharedApplication] registerForRemoteNotifications];
}

-(void)setWindowFromViewController:(UIViewController *)viewController {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = viewController;
    [self.window makeKeyAndVisible];
}


#pragma mark - appearance methods

-(void)setupAppearances {
    [self setupNavigationBarAppearance];
    [self setupFormSheetAppearance];
}

-(void)setupNavigationBarAppearance {
    UIFont *font = [UIFont fontWithName:DEFAULT_FONT size:16];
    NSDictionary *attributes = @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:font};
    [[UINavigationBar appearance] setTitleTextAttributes:attributes];
    [[UINavigationBar appearance] setTranslucent:NO];
    [[UINavigationBar appearance] setBarTintColor:[AVColorUtility colorForType:NavigationControllerBackground]];
}

-(void)setupFormSheetAppearance {
    [[MZFormSheetBackgroundWindow appearance] setBackgroundBlurEffect:YES];
    [[MZFormSheetBackgroundWindow appearance] setBlurRadius:5];
    [[MZFormSheetController appearance] setTransitionStyle:MZFormSheetTransitionStyleBounce];
    [[MZFormSheetController appearance] setCornerRadius:1];
    [[MZFormSheetController appearance] setPresentedFormSheetSize:CGSizeMake(280, 335)];
}


#pragma mark - view controller switching methods

-(void)showLogin {
    UIViewController *viewController = [AVViewControllerUtility viewControllerWithIdentifier:@"AVBaseLoginViewController"
                                                                      fromStoryboardWithName:@"Login"];
    [self setWindowFromViewController:viewController];
}

-(void)showMenu {
    UIViewController *couponTableViewController = [[AVCouponTableViewController alloc]
                                        initWithNibName:nil
                                        bundle:nil];
    UIViewController *couponEditTableViewController = [[AVCouponEditTableViewController alloc]
                                                       initWithNibName:nil
                                                       bundle:nil];
    UIViewController *segmentedViewController = [AVSegmentedContainerViewController segmentedContainerViewControllerWithViewControllers:@[couponTableViewController, couponEditTableViewController]];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:segmentedViewController];
    [self setWindowFromViewController:navigationController];
}

@end
