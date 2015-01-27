//
//  AVCouponsEditViewController.m
//  Anniversary
//
//  Created by Alan Bouzek on 1/22/15.
//  Copyright (c) 2015 Alan Bouzek. All rights reserved.
//

#import "AVCouponEditTableViewController.h"
#import "AVArrayTableViewAdapter.h"
#import "AVCouponEditTableViewCell.h"
#import "AVConstants.h"
#import <MZFormSheetController.h>
#import "AVCouponEditViewController.h"
#import "AVColorUtility.h"
#import "AVUserManager.h"
#import "AVCouponNetworkUtility.h"

@interface AVCouponEditTableViewController () <AVCouponEditViewControllerDelegate>

@property (strong, nonatomic) NSMutableArray *sentCoupons;
@property (strong, nonatomic) AVArrayTableViewAdapter *tableViewAdapter;
@property (strong, nonatomic) MZFormSheetController *formSheetController;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end


@implementation AVCouponEditTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sentCoupons = [NSMutableArray new];
    
    NSString *cellClassName = NSStringFromClass([AVCouponEditTableViewCell class]);
    [self.tableView registerNib:[UINib nibWithNibName:cellClassName bundle:nil] forCellReuseIdentifier:cellClassName];
    self.tableViewAdapter = [[AVArrayTableViewAdapter alloc] initWithItems:self.sentCoupons
                                                            cellIdentifier:cellClassName
                                                        cellConfigureBlock:^(AVCouponEditTableViewCell *cell, AVCoupon *item) {
                                                            
                                                            [cell styleForCoupon:item];
                                                            
                                                        } selectItemBlock:^(AVCoupon *item) {
                                                            
                                                            [self showEditViewControllerForCoupon:item];
                                                            
                                                        }
                             ];
    self.tableView.delegate = self.tableViewAdapter;
    self.tableView.dataSource = self.tableViewAdapter;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.rowHeight = COUPON_CELL_HEIGHT;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupAddButton];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self refresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - setup methods

-(void)setupAddButton {
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                  target:self
                                  action:@selector(showEditViewControllerForNewCoupon)];
    addButton.tintColor = [AVColorUtility colorForType:NavigationControllerButton];
    [self.parentViewController.navigationItem setRightBarButtonItem:addButton];
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


#pragma mark - transition methods

-(void)showEditViewControllerForNewCoupon {
    [self showEditViewControllerForCoupon:nil];
}

-(void)showEditViewControllerForCoupon:(AVCoupon *)coupon {
    AVCouponEditViewController *viewController = [[AVCouponEditViewController alloc] initWithNibName:nil
                                                                                          bundle:nil];
    viewController.coupon = coupon;
    viewController.delegate = self;
    
    self.formSheetController = [[MZFormSheetController alloc] initWithViewController:viewController];
    [self.formSheetController presentAnimated:YES completionHandler:nil];
}


#pragma mark - AVCouponsEditViewControllerDelegate methods

-(void)couponEditViewController:(AVCouponEditViewController *)editViewController
        shouldDismissWithResult:(AVCoupon *)result {
    if (result) {
        if (result.id) {
            [self updateCoupon:result];
        }
        else {
            [self createCoupon:result];
        }
    }
    [self.formSheetController dismissAnimated:YES completionHandler:nil];
}


#pragma mark - AVSegmentedInternalViewController methods

-(NSString *)titleForSegment {
    return @"THEIRS";
}

@end
