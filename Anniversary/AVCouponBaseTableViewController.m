//
//  AVCouponBaseTableViewController.m
//  Anniversary
//
//  Created by Alan Bouzek on 12/15/14.
//  Copyright (c) 2014 Alan Bouzek. All rights reserved.
//

#import "AVCouponBaseTableViewController.h"

@interface AVCouponBaseTableViewController ()

@property (strong, nonatomic) IBOutlet UIButton *switchButton;

@end


@implementation AVCouponBaseTableViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    [self.switchButton addTarget:self action:@selector(switchButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark - IBAction methods

-(void)switchButtonPressed:(UIButton *)switchButton {
    [self.delegate couponBaseTableViewController:self
                            didPressSwitchButton:switchButton];
}

@end
