//
//  AVMenuViewController.m
//  Anniversary
//
//  Created by Alan Bouzek on 12/11/14.
//  Copyright (c) 2014 Alan Bouzek. All rights reserved.
//

#import "AVMenuViewController.h"
#import "AVCouponTableContainerViewController.h"
#import "AVViewControllerUtility.h"
#import "AVTransitionUtility.h"
#import "AVSettingsViewController.h"
#import "AVModalViewController.h"
#import "AVModalUtility.h"
#import "AVCountdownViewController.h"
#import "AVEnterCodeViewController.h"
#import "AVUserManager+AutoLogin.h"
#import "AVLoginToMenuTransitionManager.h"
#import "AVAppDelegate.h"

@interface AVMenuViewController () <AVModalViewControllerDelegate, AVEnterCodeViewControllerDelegate>

// Top view controllers
@property (strong, nonatomic) AVCountdownViewController *countdownViewController;
@property (strong, nonatomic) AVEnterCodeViewController *enterCodeViewController;

// Bottom view controller
@property (strong, nonatomic) AVCouponTableContainerViewController *couponsContainerViewController;

@end


@implementation AVMenuViewController


#pragma mark - lazy loaders

-(AVEnterCodeViewController *)enterCodeViewController {
    if (!_enterCodeViewController) {
        _enterCodeViewController = [[AVEnterCodeViewController alloc]
                                        initWithNibName:@"AVEnterCodeViewController"
                                        bundle:nil];
        _enterCodeViewController.delegate = self;
    }
    return _enterCodeViewController;
}

-(AVCountdownViewController *)countdownViewController {
    if (!_countdownViewController) {
        _countdownViewController = [[AVCountdownViewController alloc]
                                        initWithNibName:@"AVCountdownViewController"
                                        bundle:nil];
    }
    return _countdownViewController;
}


#pragma mark - view lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.couponsContainerViewController = (AVCouponTableContainerViewController *)[AVViewControllerUtility
                                                                                 viewControllerWithIdentifier:@"AVCouponTableContainerViewController"
                                                                                 fromStoryboardWithName:@"Coupons"];
    [self embedBottomViewController];
    [self embedTopViewController];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.heartView startAnimating];
    
    AVAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate registerLoggedInUserForPushNotifications];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - utility methods

-(void)embedTopViewController {
    if ([AVUserManager manager].linkedUserId) {
        [self embedTopViewController:self.countdownViewController];
    }
    else {
        [self embedTopViewController:self.enterCodeViewController];
    }
}

-(void)embedTopViewController:(UIViewController *)viewController {
    viewController.view.alpha = 0;
    
    [self addChildViewController:viewController];
    viewController.view.frame = self.topContainerView.bounds;
    [self.topContainerView addSubview:viewController.view];
    [viewController didMoveToParentViewController:self];
    
    [UIView animateWithDuration:0.1 animations:^{
        viewController.view.alpha = 1;
    }];
}

-(void)embedBottomViewController {
    [self addChildViewController:self.couponsContainerViewController];
    self.couponsContainerViewController.view.frame = self.bottomContainerView.bounds;
    [self.bottomContainerView addSubview:self.couponsContainerViewController.view];
    [self.couponsContainerViewController didMoveToParentViewController:self];
}

-(void)showSettingsView {
    AVSettingsViewController *settingsViewController = (AVSettingsViewController *)[AVViewControllerUtility
                                                viewControllerWithIdentifier:@"AVSettingsViewController"
                                                fromStoryboardWithName:@"Settings"];
    settingsViewController.modalViewControllerDelegate = self;
    [[AVModalUtility sharedInstance] presentModalViewController:settingsViewController
                                               onViewController:self];
}

-(void)hideSettingsView {
    [[AVModalUtility sharedInstance] dismissModalViewWithCompletionBlock:^{
        // For now, settings dismissal functions as log out
        [AVUserManager removeSavedManager];
        
        AVAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        [appDelegate showLogin];
    }];
}


#pragma mark - AVModalViewControllerDelegate methods

-(void)modalViewControllerShouldDismiss:(AVModalViewController *)modalViewController
                             withResult:(id)result {
    [self hideSettingsView];
}


#pragma mark - AVEnterCodeViewControllerDelegate methods

-(void)enterCodeViewControllerDidCompleteLinking:(AVEnterCodeViewController *)enterCodeViewController {
    [UIView animateWithDuration:0.1 animations:^{
        self.enterCodeViewController.view.alpha = 0;
    } completion:^(BOOL finished) {
        self.enterCodeViewController = nil;
        [self embedTopViewController];
    }];
}


#pragma mark - IBAction methods

-(void)handleTap {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder)
                                               to:nil
                                             from:nil
                                         forEvent:nil];
}

- (IBAction)settingsButtonPressed:(UIButton *)sender {
    [self showSettingsView];
}


@end
