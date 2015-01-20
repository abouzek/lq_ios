//
//  AVRegistrationViewController.m
//  Anniversary
//
//  Created by Alan Bouzek on 12/11/14.
//  Copyright (c) 2014 Alan Bouzek. All rights reserved.
//

#import "AVRegistrationViewController.h"
#import "AVBaseLoginTabController.h"
#import "AVRegistrationViewModel.h"
#import "AVRegistrationView.h"
#import "AVStringUtility.h"
#import <AFNetworking.h>
#import "AVUserNetworkUtility.h"
#import "AVUser.h"
#import "AVUserManager.h"

@interface AVRegistrationViewController ()

@property (strong, nonatomic) IBOutlet AVRegistrationView *registrationView;

@end


@implementation AVRegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    AVRegistrationViewModel *viewModel = [AVRegistrationViewModel new];
    self.registrationView.viewModel = viewModel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - utility methods

-(BOOL)fieldsAreValid {
    NSString *username = [AVStringUtility trimmedStringFromString:self.registrationView.viewModel.username];
    NSString *password = [AVStringUtility trimmedStringFromString:self.registrationView.viewModel.password];
    NSString *confirmPassword = [AVStringUtility trimmedStringFromString:self.registrationView.viewModel.confirmPassword];
    return username.length
    && password.length
    && confirmPassword.length
    && [password isEqualToString:confirmPassword];
}


#pragma mark - AVLoginController methods

-(void)completeWithSuccessBlock:(AVCompletionBlock)successBlock
                   failureBlock:(AVErrorBlock)failureBlock {
    if ([self fieldsAreValid]) {
        AVUser *userToRegister = [AVUser userWithUsername:self.registrationView.viewModel.username
                                                 password:self.registrationView.viewModel.password
                                                 linkCode:self.registrationView.viewModel.linkCode];
        [AVUserNetworkUtility registerUser:userToRegister
                              successBlock:successBlock
                              failureBlock:failureBlock];
    }
    else {
        !failureBlock ?: failureBlock(nil);
    }
}

@end
