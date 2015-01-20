//
//  AVCouponBaseTableViewController.m
//  Anniversary
//
//  Created by Alan Bouzek on 12/15/14.
//  Copyright (c) 2014 Alan Bouzek. All rights reserved.
//

#import "AVCouponBaseTableViewController.h"

@interface AVCouponBaseTableViewController ()

@property (strong, nonatomic) IBOutlet UIButton *actionButton;

@end


@implementation AVCouponBaseTableViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    [self.actionButton addTarget:self action:@selector(actionButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark - IBAction methods

-(void)actionButtonPressed:(UIButton *)actionButton {
    [self.delegate couponBaseTableViewController:self
                            didPressActionButton:actionButton];
}

@end
