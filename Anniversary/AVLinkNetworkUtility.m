//
//  AVLinkNetworkUtility.m
//  Anniversary
//
//  Created by Alan Bouzek on 1/28/15.
//  Copyright (c) 2015 Alan Bouzek. All rights reserved.
//

#import "AVLinkNetworkUtility.h"
#import "AVLink.h"

@implementation AVLinkNetworkUtility

+(void)createLinkFromLinkConnector:(AVLinkConnector *)linkConnector
                      successBlock:(AVResultBlock)successBlock
                      failureBlock:(AVErrorBlock)failureBlock {
    NSDictionary *parametersToSend = [MTLJSONAdapter JSONDictionaryFromModel:linkConnector];
    
    NSString *requestURL = [AVBaseNetworkUtility requestURLStringForRequestEntity:CreateLink];
    AFHTTPRequestOperationManager *manager = [AVBaseNetworkUtility managerForLoggedInUser];
    
    [manager POST:requestURL
       parameters:parametersToSend
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              AVLink *link = [MTLJSONAdapter modelOfClass:[AVLink class]
                                       fromJSONDictionary:responseObject
                                                    error:nil];
              !successBlock ?: successBlock(link);
              
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
              NSLog(@"%@", error.description);
              !failureBlock ?: failureBlock(error);
              
          }
     ];

}

@end
