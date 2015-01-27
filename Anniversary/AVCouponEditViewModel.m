//
//  AVCouponsEditViewModel.m
//  Anniversary
//
//  Created by Alan Bouzek on 1/22/15.
//  Copyright (c) 2015 Alan Bouzek. All rights reserved.
//

#import "AVCouponEditViewModel.h"

@implementation AVCouponEditViewModel

+(instancetype)couponEditViewModelFromCoupon:(AVCoupon *)coupon {
    AVCouponEditViewModel *viewModel = [AVCouponEditViewModel new];
    viewModel.name = coupon.name;
    viewModel.id = coupon.id;
    return viewModel;
}

@end
