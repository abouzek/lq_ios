//
//  AVCouponsTableViewCell.h
//  Anniversary
//
//  Created by Alan Bouzek on 1/21/15.
//  Copyright (c) 2015 Alan Bouzek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MGSwipeTableCell.h>
#import "AVCoupon.h"

@protocol AVCouponTableViewCellDelegate;


@interface AVCouponTableViewCell : MGSwipeTableCell

@property (weak, nonatomic) id<AVCouponTableViewCellDelegate> cellDelegate;

-(void)styleForCoupon:(AVCoupon *)coupon;

@end


@protocol AVCouponTableViewCellDelegate <NSObject>

-(void)couponTableViewCellDidPerformDecrement:(AVCouponTableViewCell *)cell;

@end
