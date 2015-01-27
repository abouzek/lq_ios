//
//  AVCouponsEditViewModel.h
//  Anniversary
//
//  Created by Alan Bouzek on 1/22/15.
//  Copyright (c) 2015 Alan Bouzek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AVCoupon.h"

@interface AVCouponEditViewModel : NSObject

+(instancetype)couponEditViewModelFromCoupon:(AVCoupon *)coupon;

@property (nonatomic) NSInteger id;
@property (strong, nonatomic) NSString *name;

@end
