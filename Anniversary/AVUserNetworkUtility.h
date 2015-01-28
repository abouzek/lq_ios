//
//  AVUserNetworkUtility.h
//  Anniversary
//
//  Created by Alan Bouzek on 1/19/15.
//  Copyright (c) 2015 Alan Bouzek. All rights reserved.
//

#import "AVBaseNetworkUtility.h"
#import "AVPushRegistration.h"

@interface AVUserNetworkUtility : AVBaseNetworkUtility

+(void)loginUser:(AVUser *)user
    successBlock:(AVCompletionBlock)successBlock
    failureBlock:(AVErrorBlock)failureBlock;
+(void)registerUser:(AVUser *)user
       successBlock:(AVCompletionBlock)successBlock
       failureBlock:(AVErrorBlock)failureBlock;
+(void)refreshAPITokenForLoggedInUserWithSuccessBlock:(AVCompletionBlock)successBlock;
+(void)refreshLinkForLoggedInUserWithSuccessBlock:(AVCompletionBlock)successBlock;
+(void)registerPush:(AVPushRegistration *)pushRegistration
       successBlock:(AVCompletionBlock)successBlock
       failureBlock:(AVErrorBlock)failureBlock;

@end
