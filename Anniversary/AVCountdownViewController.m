//
//  AVCountdownViewController.m
//  Anniversary
//
//  Created by Alan Bouzek on 12/11/14.
//  Copyright (c) 2014 Alan Bouzek. All rights reserved.
//

#import "AVCountdownViewController.h"

@interface AVCountdownViewController ()

@property (strong, nonatomic) IBOutlet UILabel *numberLabel;

@end


@implementation AVCountdownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:UIApplicationDidBecomeActiveNotification object:nil];
}

-(void)viewWillAppear:(BOOL)animated {
    [self refresh];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)refresh {
    NSDate *now = [NSDate new];
    
    NSDateComponents *thenComponents = [NSDateComponents new];
    thenComponents.day = 14;
    thenComponents.month = 11;
    thenComponents.year = 2015;
    NSDate *then = [[NSCalendar currentCalendar] dateFromComponents:thenComponents];
    
    NSCalendarUnit flags = NSCalendarUnitDay;
    NSDateComponents *components = [[NSCalendar currentCalendar] components:flags fromDate:now toDate:then options:NSCalendarMatchFirst];
    
    NSString *dayString = [NSString stringWithFormat:@"%ld", (long)components.day];
    if (![self.numberLabel.text isEqualToString:dayString]) {
        [UIView animateWithDuration:0.1 animations:^{
            self.numberLabel.alpha = 0;
        } completion:^(BOOL finished) {
            self.numberLabel.text = dayString;
            [UIView animateWithDuration:0.15 animations:^{
                self.numberLabel.alpha = 1;
            }];
        }];
    }
}

@end
