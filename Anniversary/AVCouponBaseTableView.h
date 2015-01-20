//
//  AVCouponBaseTableViewController.h
//  Anniversary
//
//  Created by Alan Bouzek on 12/15/14.
//  Copyright (c) 2014 Alan Bouzek. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AVCouponBaseTableViewControllerDelegate;


@interface AVCouponBaseTableViewController : UIViewController

@property (weak, nonatomic) id<AVCouponBaseTableViewControllerDelegate> delegate;

@end


@protocol AVCouponBaseTableViewControllerDelegate <NSObject>

-(void)couponBaseTableViewController:(AVCouponBaseTableViewController *)couponBaseTableViewController
                didPressActionButton:(UIButton *)actionButton;

@end
