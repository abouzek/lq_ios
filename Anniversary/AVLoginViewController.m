//
//  AVLoginViewController.m
//  Anniversary
//
//  Created by Alan Bouzek on 12/11/14.
//  Copyright (c) 2014 Alan Bouzek. All rights reserved.
//

#import "AVLoginViewController.h"
#import "AVLoginView.h"
#import "AVLoginViewModel.h"
#import "AVStringUtility.h"
#import "AVBaseLoginViewController.h"
#import "AVUserNetworkUtility.h"
#import <AFNetworking.h>
#import "AVUserManager.h"
#import "AVToken.h"

@interface AVLoginViewController ()

@property (strong, nonatomic) IBOutlet AVLoginView *loginView;

@end


@implementation AVLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    AVLoginViewModel *viewModel = [AVLoginViewModel new];
    self.loginView.viewModel = viewModel;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - utility methods

-(BOOL)fieldsAreValid {
    NSString *username = [AVStringUtility trimmedStringFromString:self.loginView.viewModel.username];
    NSString *password = [AVStringUtility trimmedStringFromString:self.loginView.viewModel.password];
    return username.length && password.length;
}


#pragma mark - AVLoginController methods

-(void)completeWithSuccessBlock:(AVCompletionBlock)successBlock
                   failureBlock:(AVErrorBlock)failureBlock {
    if ([self fieldsAreValid]) {
        AVUser *userToLogin = [AVUser userWithUsername:self.loginView.viewModel.username
                                              password:self.loginView.viewModel.password];
        [AVUserNetworkUtility loginUser:userToLogin
                           successBlock:successBlock
                           failureBlock:failureBlock];
    }
    else {
        !failureBlock ?: failureBlock(nil);
    }
}

@end
