//
//  AVCouponsEditViewController.h
//  Anniversary
//
//  Created by Alan Bouzek on 1/22/15.
//  Copyright (c) 2015 Alan Bouzek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AVCoupon.h"

@protocol AVCouponEditViewControllerDelegate;


@interface AVCouponEditViewController : UIViewController

@property (weak, nonatomic) id<AVCouponEditViewControllerDelegate> delegate;

@property (weak, nonatomic) AVCoupon *coupon;

@end


@protocol AVCouponEditViewControllerDelegate <NSObject>

-(void)couponEditViewController:(AVCouponEditViewController *)editViewController
        shouldDismissWithResult:(id)result;

@end