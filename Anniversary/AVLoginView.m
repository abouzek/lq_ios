//
//  AVLoginView.m
//  Anniversary
//
//  Created by Alan Bouzek on 12/11/14.
//  Copyright (c) 2014 Alan Bouzek. All rights reserved.
//

#import "AVLoginView.h"
#import "AVTextFieldAdapter.h"
#import "AVConstants.h"
#import "AVScrollViewKeyboardAdapter.h"

@interface AVLoginView ()

@property (strong, nonatomic) AVScrollViewKeyboardAdapter *keyboardAdapter;
@property (strong, nonatomic) AVTextFieldAdapter *textFieldAdapter;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;

@end


@implementation AVLoginView

-(void)awakeFromNib {
    [super awakeFromNib];
    
    self.textFieldAdapter = [AVTextFieldAdapter new];
    [self.textFieldAdapter setupTextField:self.usernameTextField
                          withPlaceholder:LOGIN_USERNAME_TEXT_FIELD_PLACEHOLDER];
    [self.textFieldAdapter setupTextField:self.passwordTextField
                          withPlaceholder:LOGIN_PASSWORD_TEXT_FIELD_PLACEHOLDER];
    
    self.keyboardAdapter = [AVScrollViewKeyboardAdapter scrollViewKeyboardAdapterWithScrollView:self.scrollView];
}


#pragma mark - view model update methods

-(IBAction)usernameTextFieldDidChange:(UITextField *)sender {
    self.viewModel.username = sender.text;
}

-(IBAction)passwordTextFieldDidChange:(UITextField *)sender {
    self.viewModel.password = sender.text;
}


@end
