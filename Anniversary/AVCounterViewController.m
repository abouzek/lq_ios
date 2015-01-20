//
//  AVCounterViewController.m
//  Anniversary
//
//  Created by Alan Bouzek on 12/19/14.
//  Copyright (c) 2014 Alan Bouzek. All rights reserved.
//

#import "AVCounterViewController.h"
#import "AVCounterView.h"
#import "AVConstants.h"

@interface AVCounterViewController () <AVCounterViewDelegate>

@property (strong, nonatomic) IBOutlet AVCounterView *counterView;

@end


@implementation AVCounterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.count = 1;
    
    self.counterView.delegate = self;
    self.delegate = self.counterView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setter methods

-(void)setCount:(NSInteger)count {
    _count = count;
    [self.delegate counterViewController:self
                        didUpdateToCount:_count];
}


#pragma mark - AVCounterViewDelegate methods

-(void)counterViewDidIncrement:(AVCounterView *)counterView {
    if (self.count < COUPON_MAX_COUNT) {
        self.count++;
    }
}

-(void)counterViewDidDecrement:(AVCounterView *)counterView {
    if (self.count > 1) {
        self.count--;
    }
}

@end
