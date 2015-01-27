//
//  AVCouponsEditViewController.m
//  Anniversary
//
//  Created by Alan Bouzek on 1/22/15.
//  Copyright (c) 2015 Alan Bouzek. All rights reserved.
//

#import "AVCouponEditViewController.h"
#import "AVCounterViewController.h"
#import "AVCouponEditView.h"
#import "AVCouponEditViewModel.h"
#import "AVUserManager.h"

@interface AVCouponEditViewController () <AVCouponEditViewDelegate>

@property (strong, nonatomic) AVCounterViewController *counterViewController;

@property (strong, nonatomic) IBOutlet AVCouponEditView *couponEditView;

@end


@implementation AVCouponEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.couponEditView.delegate = self;
    
    AVCouponEditViewModel *viewModel = [AVCouponEditViewModel couponEditViewModelFromCoupon:self.coupon];
    self.couponEditView.viewModel = viewModel;
    
    [self embedCounterViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - utility methods

-(void)embedCounterViewController {
    self.counterViewController = [[AVCounterViewController alloc]
                                  initWithNibName:@"AVCounterViewController"
                                  bundle:nil];
    [self addChildViewController:self.counterViewController];
    self.counterViewController.view.frame = self.couponEditView.counterContainerView.bounds;
    [self.couponEditView.counterContainerView addSubview:self.counterViewController.view];
    
    if (self.coupon) {
        self.counterViewController.count = self.coupon.count;
    }
}


#pragma mark - AVCouponAddViewDelegate methods

-(void)couponEditView:(AVCouponEditView *)couponEditView didPressSaveButton:(UIButton *)saveButton {
    // Form the coupon from the data and call the delegate
    NSInteger ownerUserId = [AVUserManager manager].linkedUserId;
    if (!ownerUserId) {
        ownerUserId = [AVUserManager manager].currentUser.id;
    }
    AVUser *owner = [AVUser userWithId:ownerUserId];
    AVUser *sender = [AVUser userWithId:[AVUserManager manager].currentUser.id];
    
    AVCoupon *newCoupon = [AVCoupon couponWithId:self.couponEditView.viewModel.id
                                            name:self.couponEditView.viewModel.name
                                           count:self.counterViewController.count
                                           owner:owner
                                          sender:sender];
    [self.delegate couponEditViewController:self shouldDismissWithResult:newCoupon];
}

-(void)couponEditView:(AVCouponEditView *)couponEditView didPressCancelButton:(UIButton *)cancelButton {
    [self.delegate couponEditViewController:self shouldDismissWithResult:nil];
}


@end
