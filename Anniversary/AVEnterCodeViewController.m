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
    NSDictionary *parametersToSend = [MTLJSONAdapter JSONDictionaryFromModel:linkConnector];
    
    NSString *requestURL = [AVBaseNetworkUtility requestURLStringForRequestEntity:CreateLink];
    AFHTTPRequestOperationManager *manager = [AVBaseNetworkUtility managerForLoggedInUser];
    
    [manager POST:requestURL
       parameters:parametersToSend
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              AVLink *link = [MTLJSONAdapter modelOfClass:[AVLink class]
                                       fromJSONDictionary:responseObject
                                                    error:nil];
              [AVUserManager manager].linkedUserId = link.secondUser.id;
              
              [self.enterCodeView animateForSuccessWithCompletionBlock:^{
                  [self.delegate enterCodeViewControllerDidCompleteLinking:self];
              }];
              
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
              NSLog(@"%@", error.description);
              [self.enterCodeView animateForFailureWithCompletionBlock:nil];
              
          }
     ];
}

@end
