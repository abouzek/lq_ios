//
//  AVCouponAddViewController.h
//  Anniversary
//
//  Created by Alan Bouzek on 12/17/14.
//  Copyright (c) 2014 Alan Bouzek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AVCoupon.h"
#import "AVModalViewController.h"

@interface AVCouponEditViewController : AVModalViewController

@property (weak, nonatomic) AVCoupon *coupon;

@end