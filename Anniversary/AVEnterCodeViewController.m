//
//  AVEnterCodeViewController.m
//  Anniversary
//
//  Created by Alan Bouzek on 12/22/14.
//  Copyright (c) 2014 Alan Bouzek. All rights reserved.
//

#import "AVEnterCodeViewController.h"
#import "AVEnterCodeView.h"
#import "AVEnterCodeViewModel.h"
#import "AVBaseNetworkUtility.h"
#import "AVLinkConnector.h"
#import "AVUserManager.h"
#import "AVLink.h"
#import "AVLinkNetworkUtility.h"

@interface AVEnterCodeViewController () <AVEnterCodeViewDelegate>

@property (strong, nonatomic) IBOutlet AVEnterCodeView *enterCodeView;

@end


@implementation AVEnterCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.enterCodeView.delegate = self;
    
    AVEnterCodeViewModel *viewModel = [AVEnterCodeViewModel new];
    self.enterCodeView.viewModel = viewModel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - AVEnterCodeViewDelegate methods

-(void)enterCodeView:(AVEnterCodeView *)enterCodeView
      didPressButton:(UIButton *)button {
    // Do the link up
    NSInteger userId = [AVUserManager manager].currentUser.id;
    AVLinkConnector *linkConnector = [AVLinkConnector linkConnectorWithUserId:userId
                                 linkCode:self.enterCodeView.viewModel.linkCode];
    
    [AVLinkNetworkUtility createLinkFromLinkConnector:linkConnector
                        successBlock:^(AVLink *link) {
        
                            [AVUserManager manager].link = link;
                            
                            [self.enterCodeView animateForSuccessWithCompletionBlock:^{
                                [self.delegate enterCodeViewControllerDidCompleteLinking:self];
                            }];
        
                        } failureBlock:^(NSError *error) {
        
                            [self.enterCodeView animateForFailureWithCompletionBlock:nil];
        
                        }
     ];
}

@end
