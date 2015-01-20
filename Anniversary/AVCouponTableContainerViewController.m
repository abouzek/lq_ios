//
//  AVCouponTableContainerViewController.m
//  Anniversary
//
//  Created by Alan Bouzek on 12/11/14.
//  Copyright (c) 2014 Alan Bouzek. All rights reserved.
//

#import "AVCouponTableContainerViewController.h"
#import "AVViewControllerUtility.h"
#import "AVCouponEditTableViewController.h"
#import "AVCouponTableViewController.h"
#import "AVTransitionUtility.h"
#import "AVCouponEditViewController.h"

@interface AVCouponTableContainerViewController () <AVCouponBaseTableViewControllerDelegate>

@property (strong, nonatomic) AVCouponBaseTableViewController *currentViewController;

@end


@implementation AVCouponTableContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self embedInitialChildViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - child view controller swapping

-(void)embedInitialChildViewController {
    self.currentViewController = (AVCouponBaseTableViewController *)[AVViewControllerUtility
                                  viewControllerWithIdentifier:@"AVCouponTableViewController"
                                  fromStoryboardWithName:@"Coupons"];
    [self addChildViewController:self.currentViewController];
    self.currentViewController.view.frame = self.view.bounds;
    [self.view addSubview:self.currentViewController.view];
    self.currentViewController.delegate = self;
}

-(void)swapChildViewControllers {
    AVCouponBaseTableViewController *newViewController;
    if ([self.currentViewController isKindOfClass:[AVCouponTableViewController class]]) {
        // Showing view table, switch to edit view table
        newViewController = (AVCouponBaseTableViewController *)[AVViewControllerUtility
                             viewControllerWithIdentifier:@"AVCouponEditTableViewController"
                             fromStoryboardWithName:@"Coupons"];
    }
    else if ([self.currentViewController isKindOfClass:[AVCouponEditTableViewController class]]) {
        // Showing edit view table, switch to view table
        newViewController = (AVCouponBaseTableViewController *)[AVViewControllerUtility
                             viewControllerWithIdentifier:@"AVCouponTableViewController"
                             fromStoryboardWithName:@"Coupons"];
    }
    
    [newViewController willMoveToParentViewController:self];
    [self addChildViewController:newViewController];
    
    [AVTransitionUtility slideTransitionFromView:self.currentViewController.view
                                          toView:newViewController.view
                                   usingDuration:0.4
                               springWithDamping:1
                           initialSpringVelocity:1
                                         options:UIViewAnimationOptionCurveEaseInOut
                                   withDirection:Down
                             withCompletionBlock:^{
        [self.currentViewController removeFromParentViewController];
        [newViewController didMoveToParentViewController:self];
                                 
        newViewController.delegate = self;
        self.currentViewController = newViewController;
    }];
}


#pragma mark - AVCouponBaseTableViewControllerDelegate methods

-(void)couponBaseTableViewController:(AVCouponBaseTableViewController *)couponBaseTableViewController
                didPressSwitchButton:(UIButton *)switchButton {
    [self swapChildViewControllers];
}


@end
