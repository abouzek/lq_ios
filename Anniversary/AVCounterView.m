//
//  AVCounterView.m
//  Anniversary
//
//  Created by Alan Bouzek on 12/18/14.
//  Copyright (c) 2014 Alan Bouzek. All rights reserved.
//

#import "AVCounterView.h"

@interface AVCounterView ()

@property (strong, nonatomic) IBOutlet UILabel *numberLabel;

@end


@implementation AVCounterView

-(void)awakeFromNib {
    self.numberLabel.text = @"1";
}


#pragma mark - AVCounterViewControllerDelegate methods

-(void)counterViewController:(AVCounterViewController *)counterViewController
            didUpdateToCount:(NSInteger)count {
    self.numberLabel.text = [NSString stringWithFormat:@"%@", @(count)];
}


#pragma mark - IBAction methods

- (IBAction)plusButtonPressed:(UIButton *)sender {
    [self.delegate counterViewDidIncrement:self];
}

- (IBAction)minusButtonPressed:(UIButton *)sender {
    [self.delegate counterViewDidDecrement:self];
}


@end
