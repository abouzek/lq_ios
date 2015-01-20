//
//  AVChoreTableViewCell.h
//  Anniversary
//
//  Created by Alan Bouzek on 12/11/14.
//  Copyright (c) 2014 Alan Bouzek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AVCoupon.h"

@protocol AVCouponTableViewCellDelegate;


@interface AVCouponTableViewCell : UITableViewCell

@property (weak, nonatomic) id<AVCouponTableViewCellDelegate> delegate;

-(void)styleForCoupon:(AVCoupon *)coupon;
-(void)disable;
-(void)enable;

@end


@protocol AVCouponTableViewCellDelegate <NSObject>

-(void)checkTappedInCell:(AVCouponTableViewCell *)cell;

@end
