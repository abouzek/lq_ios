//
//  AVCouponAddViewModel.m
//  Anniversary
//
//  Created by Alan Bouzek on 12/17/14.
//  Copyright (c) 2014 Alan Bouzek. All rights reserved.
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
