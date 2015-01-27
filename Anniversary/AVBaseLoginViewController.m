//
//  AVBaseLoginViewController.m
//  Anniversary
//
//  Created by Alan Bouzek on 12/11/14.
//  Copyright (c) 2014 Alan Bouzek. All rights reserved.
//

#import "AVBaseLoginViewController.h"
#import "AVViewControllerUtility.h"
#import "AVBaseLoginTabController.h"
#import "AVUserManager+AutoLogin.h"
#import "AVAppDelegate.h"

// Constants
NSString * const LOGIN_BUTTON_PRIMARY_TITLE = @"LOGIN";
NSString * const LOGIN_BUTTON_SECONDARY_TITLE = @"DONE";
NSString * const REGISTER_BUTTON_PRIMARY_TITLE = @"REGISTER";
NSString * const REGISTER_BUTTON_SECONDARY_TITLE = @"BACK";


@interface AVBaseLoginViewController ()

@property (nonatomic) BOOL titleShowing;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end


@implementation AVBaseLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.titleShowing = YES;
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"EmbedTabViewController"]) {
        AVBaseLoginTabController *tabController = (AVBaseLoginTabController *)segue.destinationViewController;
        self.delegate = tabController;
    }
}

#pragma mark - color methods

-(void)colorSchemeDidChange {
    self.loginButton.backgroundColor = [AVColorUtility colorForType:ButtonPrimary];
    self.registerButton.backgroundColor = [AVColorUtility colorForType:ButtonSecondary];
    [self.loginButton setTitleColor:[AVColorUtility colorForType:TextPrimary]
                           forState:UIControlStateNormal];
    [self.registerButton setTitleColor:[AVColorUtility colorForType:TextPrimary]
                              forState:UIControlStateNormal];
    self.view.backgroundColor = [AVColorUtility colorForType:BackgroundPrimary];
}


#pragma mark - utility methods

-(void)showActivityIndicator {
    [self.activityIndicator startAnimating];
    self.loginButton.titleLabel.alpha = 0;
    self.activityIndicator.hidden = NO;
}

-(void)hideActivityIndicator {
    self.activityIndicator.hidden = YES;
    self.loginButton.titleLabel.alpha = 1;
}


#pragma mark - transition methods

-(void)toggleButtonTitles {
    self.loginButton.userInteractionEnabled = NO;
    self.registerButton.userInteractionEnabled = NO;
    
    NSString *loginButtonTitle = self.titleShowing ? LOGIN_BUTTON_SECONDARY_TITLE : LOGIN_BUTTON_PRIMARY_TITLE;
    NSString *registerButtonTitle = self.titleShowing ? REGISTER_BUTTON_SECONDARY_TITLE : REGISTER_BUTTON_PRIMARY_TITLE;
    
    [UIView setAnimationsEnabled:NO];
    [self.loginButton setTitle:loginButtonTitle forState:UIControlStateNormal];
    [self.registerButton setTitle:registerButtonTitle forState:UIControlStateNormal];
    [UIView setAnimationsEnabled:YES];
    
    self.titleShowing = !self.titleShowing;
    
    self.loginButton.userInteractionEnabled = YES;
    self.registerButton.userInteractionEnabled = YES;
}

#pragma mark - IBAction methods

-(void)handleTap {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder)
                                               to:nil
                                             from:nil
                                         forEvent:nil];
}

-(IBAction)registerButtonPressed:(UIButton *)sender {
    if (self.titleShowing) {
        // Title showing, so move to register view
        [self.delegate baseLoginViewControllerDidPressRegisterButton:self];
    }
    else {
        // Login or registration showing, move back to title view
        [self.delegate baseLoginViewControllerDidPressCancelButton:self];
    }
    // In either case, swap the button titles
    [self toggleButtonTitles];
}

-(IBAction)loginButtonPressed:(UIButton *)sender {
    if (self.titleShowing) {
        // Title showing, so move to login view and swap the button titles
        [self.delegate baseLoginViewControllerDidPressLoginButton:self];
        [self toggleButtonTitles];
    }
    else {
        // Login or registration showing, validate fields and transition
        [self showActivityIndicator];
        [self.delegate baseLoginViewControllerShouldPerformOperation:self
                                                    withSuccessBlock:^{
                                                        [self hideActivityIndicator];
                                                        // Show first view controller after login
                                                        AVAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
                                                        [appDelegate showMenu];
                                                    } failureBlock:^(NSError *error) {
                                                        [self hideActivityIndicator];
                                                    }
        ];
    }
}

@end
