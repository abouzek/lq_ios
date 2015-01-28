//
//  AVUserNetworkUtility.m
//  Anniversary
//
//  Created by Alan Bouzek on 1/19/15.
//  Copyright (c) 2015 Alan Bouzek. All rights reserved.
//

#import "AVUserNetworkUtility.h"
#import "AVUser.h"
#import "AVToken.h"
#import "AVUserManager.h"
#import "AVUserManager+AutoLogin.h"
#import "AVLink.h"

@implementation AVUserNetworkUtility

+(void)loginUser:(AVUser *)user
    successBlock:(AVCompletionBlock)successBlock
    failureBlock:(AVErrorBlock)failureBlock {
    // Get API token information and set it on the AVUserManager singleton
    [self fetchAPITokenForUser:user
            withSuccessBlock:^(AVToken *tokenWrapper) {
                
                [[AVUserManager manager] populateAPITokenFromToken:tokenWrapper];
                
                // Now fetch current user information and set it on the AVUserManager singleton
                [self fetchUserWithId:tokenWrapper.currentUserId
                         successBlock:^(AVUser *user) {
                             
                             [AVUserManager manager].currentUser = user;
                             [AVUserManager saveManager];
                             
                             [self refreshLinkForLoggedInUserWithSuccessBlock:^{
                                 
                                 !successBlock ?: successBlock();
                                 
                             }];
                             
                         }
                         failureBlock:^(NSError *error) {
                             
                             !failureBlock ?: failureBlock(error);
                             
                         }
                 ];
                
            }
            failureBlock:^(NSError *error) {
                
                !failureBlock ?: failureBlock(error);
                
            }
     ];
}

+(void)registerUser:(AVUser *)user
       successBlock:(AVCompletionBlock)successBlock
       failureBlock:(AVErrorBlock)failureBlock {
    AFHTTPRequestOperationManager *manager = [self baseManager];
    NSDictionary *parametersToSend = [MTLJSONAdapter JSONDictionaryFromModel:user];
    NSString *requestUrl = [AVBaseNetworkUtility requestURLStringForRequestEntity:CreateUser];
    
    // Register the new user and set it on AVUserManager singleton
    [manager POST:requestUrl
       parameters:parametersToSend
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              AVUser *newUser = [MTLJSONAdapter modelOfClass:[AVUser class]
                                          fromJSONDictionary:responseObject
                                                       error:nil];
              [AVUserManager manager].currentUser = newUser;
              
              // Now refresh the API token and save the user's current context
              [AVUserNetworkUtility refreshAPITokenForLoggedInUserWithSuccessBlock:^{
                  
                  [AVUserManager saveManager];
                  !successBlock ?: successBlock();
                  
              }];
              
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
              NSLog(@"%@", error.description);
              !failureBlock ?: failureBlock(error);
              
          }
     ];
}

+(void)refreshAPITokenForLoggedInUserWithSuccessBlock:(AVCompletionBlock)successBlock {
    [self fetchAPITokenForUser:[AVUserManager manager].currentUser
              withSuccessBlock:^(AVToken *tokenWrapper) {
                  
                  [[AVUserManager manager] populateAPITokenFromToken:tokenWrapper];
                  !successBlock ?: successBlock();
                  
              }
                  failureBlock:nil];
}

+(void)refreshLinkForLoggedInUserWithSuccessBlock:(AVCompletionBlock)successBlock {
    [self fetchLinkForUserWithId:[AVUserManager manager].currentUser.id
                    successBlock:^(AVLink *link) {
                        
                        [AVUserManager manager].link = link;
                        !successBlock ?: successBlock();
                        
                    } failureBlock:nil];
}

+(void)registerPush:(AVPushRegistration *)pushRegistration
       successBlock:(AVCompletionBlock)successBlock
       failureBlock:(AVErrorBlock)failureBlock {
    AFHTTPRequestOperationManager *manager = [self managerForLoggedInUser];
    NSDictionary *parametersToSend = [MTLJSONAdapter JSONDictionaryFromModel:pushRegistration];
    NSString *requestUrl = [AVBaseNetworkUtility requestURLStringForRequestEntity:CreatePush];
    
    [manager POST:requestUrl
       parameters:parametersToSend
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              !successBlock ?: successBlock();
              
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
              if ([operation.response statusCode] != 409) {
                  NSLog(@"%@", error.description);
              }
              !failureBlock ?: failureBlock(error);
              
          }
     ];
}


#pragma mark - helper network calls

+(void)fetchAPITokenForUser:(AVUser *)user
           withSuccessBlock:(AVResultBlock)successBlock
               failureBlock:(AVErrorBlock)failureBlock {
    AFHTTPRequestOperationManager *manager = [self managerToLoginUser:user];
    [manager GET:[AVBaseNetworkUtility requestURLStringForRequestEntity:GetToken]
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             
             AVToken *tokenWrapper = [MTLJSONAdapter modelOfClass:[AVToken class]
                                               fromJSONDictionary:responseObject
                                                            error:nil];
             !successBlock ?: successBlock(tokenWrapper);
             
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             
             NSLog(@"%@", error.description);
             !failureBlock ?: failureBlock(error);
             
         }
     ];
}

+(void)fetchUserWithId:(NSInteger)userId
          successBlock:(AVResultBlock)successBlock
          failureBlock:(AVErrorBlock)failureBlock {
    AFHTTPRequestOperationManager *manager = [self managerForLoggedInUser];
    NSString *requestString = [AVBaseNetworkUtility requestURLStringForParameterRequestEntity:GetUser
                                                                               withParameters:@[@(userId)]];
    [manager GET:requestString
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             
             AVUser *user = [MTLJSONAdapter modelOfClass:[AVUser class]
                                      fromJSONDictionary:responseObject
                                                   error:nil];
             !successBlock ?: successBlock(user);
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             
             NSLog(@"%@", error.description);
             !failureBlock ?: failureBlock(error);
             
         }
     ];
}

+(void)fetchLinkForUserWithId:(NSInteger)userId
                 successBlock:(AVResultBlock)successBlock
                 failureBlock:(AVErrorBlock)failureBlock {
    AFHTTPRequestOperationManager *manager = [self managerForLoggedInUser];
    NSString *requestString = [AVBaseNetworkUtility requestURLStringForParameterRequestEntity:GetLinkForUser
                                                                               withParameters:@[@(userId)]];
    [manager GET:requestString
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             
             AVLink *link = [MTLJSONAdapter modelOfClass:[AVLink class]
                                      fromJSONDictionary:responseObject
                                                   error:nil];
             !successBlock ?: successBlock(link);
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             
             NSLog(@"%@", error.description);
             !failureBlock ?: failureBlock(error);
             
         }
     ];
}

@end
