//
//  AVCouponsEditTableViewCell.m
//  Anniversary
//
//  Created by Alan Bouzek on 1/22/15.
//  Copyright (c) 2015 Alan Bouzek. All rights reserved.
//

#import "AVCouponEditTableViewCell.h"
#import "AVColorUtility.h"

@interface AVCouponEditTableViewCell ()

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *countLabel;
@property (strong, nonatomic) IBOutlet UILabel *leftLabel;

@end


@implementation AVCouponEditTableViewCell

- (void)awakeFromNib {
    self.separatorInset = UIEdgeInsetsZero;
    self.preservesSuperviewLayoutMargins = NO;
    self.layoutMargins = UIEdgeInsetsZero;
    
    [self setupColors];
}

-(void)setupColors {
    self.contentView.backgroundColor = [AVColorUtility colorForType:CellBackground];
    self.nameLabel.textColor = [AVColorUtility colorForType:TextPrimary];
    self.countLabel.textColor = [AVColorUtility colorForType:CellSubtitle];
    self.leftLabel.textColor = [AVColorUtility colorForType:CellSubtitle];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)styleForCoupon:(AVCoupon *)coupon {
    self.nameLabel.text = [coupon.name uppercaseString];
    self.countLabel.text = [NSString stringWithFormat:@"%@", @(coupon.count)];
}

@end
