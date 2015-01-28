//
//  AVCouponsTableViewController.m
//  Anniversary
//
//  Created by Alan Bouzek on 1/21/15.
//  Copyright (c) 2015 Alan Bouzek. All rights reserved.
//

#import "AVCouponTableViewController.h"
#import "AVArrayTableViewAdapter.h"
#import "AVCouponTableViewCell.h"
#import "AVConstants.h"
#import "AVUserManager.h"
#import "AVCouponNetworkUtility.h"
#import "AVEnterCodeViewController.h"
#import <MZFormSheetController.h>
#import "AVUserNetworkUtility.h"

@interface AVCouponTableViewController () <AVCouponTableViewCellDelegate, AVEnterCodeViewControllerDelegate>

@property (strong, nonatomic) NSMutableArray *coupons;
@property (strong, nonatomic) AVArrayTableViewAdapter *tableViewAdapter;
@property (strong, nonatomic) MZFormSheetController *formSheetController;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation AVCouponTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.coupons = [NSMutableArray new];
    
    NSString *cellClassName = NSStringFromClass([AVCouponTableViewCell class]);
    [self.tableView registerNib:[UINib nibWithNibName:cellClassName bundle:nil] forCellReuseIdentifier:cellClassName];
    self.tableViewAdapter = [[AVArrayTableViewAdapter alloc] initWithItems:self.coupons
                                                            cellIdentifier:cellClassName
                                                        cellConfigureBlock:^(AVCouponTableViewCell *cell, id item) {
                                                            
                                                            cell.cellDelegate = self;
                                                            [cell styleForCoupon:item];
                                                            
                                                        } selectItemBlock:nil
                             ];
    self.tableView.delegate = self.tableViewAdapter;
    self.tableView.dataSource = self.tableViewAdapter;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.rowHeight = COUPON_CELL_HEIGHT;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.parentViewController.navigationItem setRightBarButtonItem:nil];
    
    [AVUserNetworkUtility refreshLinkForLoggedInUserWithSuccessBlock:^{
        if (![[AVUserManager manager] linkedUserId]) {
            [self showLinkCodeEntry];
        }
    }];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self refresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - utility methods

-(void)refresh {
    [self.coupons removeAllObjects];
    
    NSInteger userId = [AVUserManager manager].currentUser.id;
    [AVCouponNetworkUtility fetchCouponsForUserId:userId
                                     successBlock:^(NSArray *coupons) {
                                         
                                         [self.coupons addObjectsFromArray:coupons];
                                         [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
                                         
                                     }
                                     failureBlock:^(NSError *error) {
                                         
                                     }
     ];
}


#pragma mark - AVSegmentedInternalViewController methods

-(NSString *)titleForSegment {
    return @"YOURS";
}


#pragma mark - AVCouponsTableViewCellDelegate methods

-(void)couponTableViewCellDidPerformDecrement:(AVCouponTableViewCell *)cell {
    cell.userInteractionEnabled = NO;
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    AVCoupon *coupon = self.coupons[indexPath.row];
    coupon.count--;
    
    [AVCouponNetworkUtility updateCoupon:coupon
                            successBlock:^{
                                
                                [self couponSaved:coupon atIndexPath:indexPath];
                                
                            }
                            failureBlock:^(NSError *error) {
                                
                            }
     ];
}

-(void)couponSaved:(AVCoupon *)coupon atIndexPath:(NSIndexPath *)indexPath {
    AVCouponTableViewCell *newCell = (AVCouponTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    if (newCell) {
        newCell.userInteractionEnabled = YES;
    }
    
    if (coupon.count) {
        [self.tableView reloadRowsAtIndexPaths:@[indexPath]
                              withRowAnimation:UITableViewRowAnimationFade];
    }
    else {
        [self.coupons removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath]
                              withRowAnimation:UITableViewRowAnimationLeft];
    }
}


#pragma mark - link code entry

-(void)showLinkCodeEntry {
    AVEnterCodeViewController *viewController = [[AVEnterCodeViewController alloc] initWithNibName:nil
                                                                                            bundle:nil];
    viewController.delegate = self;
    
    self.formSheetController = [[MZFormSheetController alloc] initWithViewController:viewController];
    [self.formSheetController presentAnimated:YES completionHandler:nil];
}


#pragma mark - AVEnterCodeViewControllerDelegate methods

-(void)enterCodeViewControllerDidCompleteLinking:(AVEnterCodeViewController *)enterCodeViewController {
    [self.formSheetController dismissAnimated:YES completionHandler:^(UIViewController *presentedFSViewController) {
        [self refresh];
    }];
}


@end
