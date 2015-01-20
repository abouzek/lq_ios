//
//  AVColorChangingViewController.m
//  Anniversary
//
//  Created by Alan Bouzek on 1/16/15.
//  Copyright (c) 2015 Alan Bouzek. All rights reserved.
//

#import "AVColoredViewController.h"
#import "AVConstants.h"

@implementation AVColoredViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(colorSchemeDidChange)
                                                 name:COLOR_SCHEME_CHANGED_NOTIFICATION
                                               object:nil];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self colorSchemeDidChange];
    });
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:COLOR_SCHEME_CHANGED_NOTIFICATION
                                                  object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - abstract methods

-(void)colorSchemeDidChange {
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass",
     NSStringFromSelector(_cmd)];
}

@end
