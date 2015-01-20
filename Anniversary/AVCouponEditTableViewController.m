//
//  AVChoreEditTableViewController.m
//  Anniversary
//
//  Created by Alan Bouzek on 12/11/14.
//  Copyright (c) 2014 Alan Bouzek. All rights reserved.
//

#import "AVCouponEditTableViewController.h"
#import "AVArrayTableViewAdapter.h"
#import "AVViewControllerUtility.h"
#import "AVTransitionUtility.h"
#import "AVCouponEditViewController.h"
#import "AVMenuViewController.h"
#import "AVCouponEditTableViewCell.h"
#import "AVModalUtility.h"
#import "AVCouponNetworkUtility.h"
#import "AVUserManager.h"

@interface AVCouponEditTableViewController () <AVModalViewControllerDelegate>

@property (strong, nonatomic) AVCouponEditViewController *couponEditViewController;

@property (strong, nonatomic) AVArrayTableViewAdapter *tableViewAdapter;
@property (strong, nonatomic) NSMutableArray *sentCoupons;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation AVCouponEditTableViewController

#pragma mark - lazy loaders

-(AVCouponEditViewController *)couponEditViewController {
    if (!_couponEditViewController) {
        _couponEditViewController = (AVCouponEditViewController *)[AVViewControllerUtility viewControllerWithIdentifier:@"AVCouponEditViewController"
                                                             fromStoryboardWithName:@"Coupons"];
        _couponEditViewController.modalViewControllerDelegate = self;
    }
    return _couponEditViewController;
}


#pragma mark - view lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sentCoupons = [NSMutableArray new];
    self.tableViewAdapter = [[AVArrayTableViewAdapter alloc] initWithItems:self.sentCoupons
                                                            cellIdentifier:@"AVCouponEditTableViewCell"
                                                        cellConfigureBlock:^(AVCouponEditTableViewCell *cell, AVCoupon *item) {
                                                            [cell styleForCoupon:item];
                                                        } selectItemBlock:^(AVCoupon *item) {
                                                            [self showCouponEditModalViewForCoupon:item];
                                                        }];
    self.tableView.dataSource = self.tableViewAdapter;
    self.tableView.delegate = self.tableViewAdapter;
    
    [self refresh];
    
    // Do not show empty cells in table
    self.tableView.tableFooterView = [UIView new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - utility methods

-(void)refresh {
    [self.sentCoupons removeAllObjects];
    
    NSInteger userId = [AVUserManager manager].currentUser.id;
    [AVCouponNetworkUtility fetchSentCouponsForUserId:userId
                                   successBlock:^(NSArray *sentCoupons) {
                                       
                                       [self.sentCoupons addObjectsFromArray:sentCoupons];
                                       [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];

                                   }
                                   failureBlock:^(NSError *error) {
                                       
                                   }
     ];
}

-(void)createCoupon:(AVCoupon *)coupon {
    [AVCouponNetworkUtility createCoupon:coupon
                      successBlock:^(AVCoupon *newCoupon) {
                          
                          [self.sentCoupons addObject:newCoupon];
                          [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0]
                                        withRowAnimation:UITableViewRowAnimationAutomatic];

                      }
                      failureBlock:^(NSError *error) {
                          
                      }
     ];
}

-(void)updateCoupon:(AVCoupon *)coupon {
    [AVCouponNetworkUtility updateCoupon:coupon
                      successBlock:^{
                          
                          [self couponUpdated:coupon];
                          [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0]
                                        withRowAnimation:UITableViewRowAnimationAutomatic];
                          
                      }
                      failureBlock:^(NSError *error) {
                          
                      }
     ];
}

-(void)couponUpdated:(AVCoupon *)updatedCoupon {
    for (int i = 0; i < self.sentCoupons.count; ++i) {
        AVCoupon *coupon = self.sentCoupons[i];
        if (coupon.id == updatedCoupon.id) {
            self.sentCoupons[i] = updatedCoupon;
            break;
        }
    }
}


#pragma mark - AVCouponAddViewController presentation methods

-(void)showCouponEditModalViewForCoupon:(AVCoupon *)coupon {
    self.couponEditViewController.coupon = coupon;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[AVModalUtility sharedInstance] presentModalViewController:self.couponEditViewController
                                                   onViewController:self.parentViewController.parentViewController];
    });
}

-(void)hideCouponEditModalView {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[AVModalUtility sharedInstance] dismissModalViewWithCompletionBlock:nil];
    });
}


#pragma mark - AVModalViewControllerDelegate methods

-(void)modalViewControllerShouldDismiss:(AVModalViewController *)modalViewController
                             withResult:(AVCoupon *)coupon {
    [self hideCouponEditModalView];
    if (coupon) {
        if (coupon.id) {
            // Existing coupon, update it
            [self updateCoupon:coupon];
        }
        else {
            // New coupon
            [self createCoupon:coupon];
        }
    }
}


#pragma mark - IBAction methods

- (IBAction)addButtonPressed:(UIButton *)sender {
    [self showCouponEditModalViewForCoupon:nil];
}

@end
