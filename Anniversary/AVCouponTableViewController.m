//
//  AVChoreTableViewController.m
//  Anniversary
//
//  Created by Alan Bouzek on 12/11/14.
//  Copyright (c) 2014 Alan Bouzek. All rights reserved.
//

#import "AVCouponTableViewController.h"
#import "AVCoupon.h"
#import "AVCouponTableViewCell.h"
#import "AVArrayTableViewAdapter.h"
#import "AVCouponNetworkUtility.h"
#import "AVUserManager.h"
#import "AVStringUtility.h"

@interface AVCouponTableViewController () <AVCouponTableViewCellDelegate>

@property (strong, nonatomic) AVArrayTableViewAdapter *tableViewAdapter;
@property (strong, nonatomic) NSMutableArray *coupons;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end


@implementation AVCouponTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.coupons = [NSMutableArray new];
    self.tableViewAdapter = [[AVArrayTableViewAdapter alloc] initWithItems:self.coupons
                                                            cellIdentifier:@"AVCouponTableViewCell"
                                                        cellConfigureBlock:^(AVCouponTableViewCell *cell, id item) {
                                                            [cell styleForCoupon:item];
                                                            cell.delegate = self;
                                                        }
                                                        selectItemBlock:nil
                             ];
    self.tableView.dataSource = self.tableViewAdapter;
    self.tableView.tableFooterView = [UIView new];
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


#pragma mark - AVCouponTableViewCellDelegate methods

-(void)checkTappedInCell:(AVCouponTableViewCell *)cell {
    [cell disable];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    AVCoupon *coupon = self.coupons[indexPath.row];
    --coupon.count;
    
    [AVCouponNetworkUtility updateCoupon:coupon
                      successBlock:^{
                          
                          [self couponSaved:coupon atIndexPath:indexPath];

                      }
                      failureBlock:^(NSError *error) {
                          
                      }
     ];
}

-(void)couponSaved:(AVCoupon *)coupon atIndexPath:(NSIndexPath *)indexPath {
    AVCouponTableViewCell *newCell = (AVCouponTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    if (newCell) {
        [newCell enable];
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

@end
