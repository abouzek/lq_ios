//
//  AVChoreEditTableViewCell.m
//  Anniversary
//
//  Created by Alan Bouzek on 12/11/14.
//  Copyright (c) 2014 Alan Bouzek. All rights reserved.
//

#import "AVCouponEditTableViewCell.h"

@interface AVCouponEditTableViewCell ()

@property (strong, nonatomic) IBOutlet UILabel *numberLabel;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@end


@implementation AVCouponEditTableViewCell

- (void)awakeFromNib {
    self.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)styleForCoupon:(AVCoupon *)coupon {
    self.nameLabel.text = coupon.name;
    self.numberLabel.text = [NSString stringWithFormat:@" - %@ Uses Left", @(coupon.count)];
}

@end
