//
//  AVModalContainerViewController.m
//  Anniversary
//
//  Created by Alan Bouzek on 12/20/14.
//  Copyright (c) 2014 Alan Bouzek. All rights reserved.
//

#import "AVModalContainerViewController.h"

@implementation AVModalContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.alpha = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - utility methods

-(void)showBlurViewWithCompletionBlock:(AVCompletionBlock)completionBlock {
    [UIView animateWithDuration:0.1 animations:^{
        self.view.alpha = 1;
    } completion:^(BOOL finished) {
        !completionBlock ?: completionBlock();
    }];
}

-(void)hideBlurViewWithCompletionBlock:(AVCompletionBlock)completionBlock {
    [UIView animateWithDuration:0.1 animations:^{
        self.view.alpha = 0;
    } completion:^(BOOL finished) {
        !completionBlock ?: completionBlock();
    }];
}

@end
