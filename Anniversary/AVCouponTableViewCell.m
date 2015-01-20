//
//  AVChoreTableViewCell.m
//  Anniversary
//
//  Created by Alan Bouzek on 12/11/14.
//  Copyright (c) 2014 Alan Bouzek. All rights reserved.
//

#import "AVCouponTableViewCell.h"
#import "AVCoupon.h"

@interface AVCouponTableViewCell ()

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *numberLabel;
@property (strong, nonatomic) IBOutlet UIButton *checkButton;

@end


@implementation AVCouponTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)styleForCoupon:(AVCoupon *)coupon {
    self.nameLabel.text = coupon.name;
    self.numberLabel.text = [NSString stringWithFormat:@" - %@ Uses Left", @(coupon.count)];
    [self.checkButton addTarget:self action:@selector(checkTapped) forControlEvents:UIControlEventTouchUpInside];
}

-(void)checkTapped {
    [self.delegate checkTappedInCell:self];
}

-(void)disable {
    self.userInteractionEnabled = NO;
    self.checkButton.userInteractionEnabled = NO;
}

-(void)enable {
    self.userInteractionEnabled = YES;
    self.checkButton.userInteractionEnabled = YES;
}

@end
