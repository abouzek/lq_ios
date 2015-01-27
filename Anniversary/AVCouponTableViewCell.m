//
//  AVCouponsTableViewCell.m
//  Anniversary
//
//  Created by Alan Bouzek on 1/21/15.
//  Copyright (c) 2015 Alan Bouzek. All rights reserved.
//

#import "AVCouponTableViewCell.h"
#import <MGSwipeButton.h>
#import "AVColorUtility.h"

@interface AVCouponTableViewCell ()

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *countLabel;
@property (strong, nonatomic) IBOutlet UILabel *leftLabel;

@end


@implementation AVCouponTableViewCell

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
    
    MGSwipeButton *rightButton = [MGSwipeButton buttonWithTitle:nil
                                                           icon:[UIImage imageNamed:@"white_check"]
                                                backgroundColor:[AVColorUtility colorForType:CellSwipeBackground]
                                                       callback:^BOOL(MGSwipeTableCell *sender) {
                                                           [self.cellDelegate couponTableViewCellDidPerformDecrement:self];
                                                           return YES;
                                                       }
                                  ];
    self.rightButtons = @[rightButton];
    self.rightExpansion.buttonIndex = 0;
    self.rightExpansion.fillOnTrigger = YES;
}

@end
