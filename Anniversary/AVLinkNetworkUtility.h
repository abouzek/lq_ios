//
//  AVLinkNetworkUtility.h
//  Anniversary
//
//  Created by Alan Bouzek on 1/28/15.
//  Copyright (c) 2015 Alan Bouzek. All rights reserved.
//

#import "AVBaseNetworkUtility.h"
#import "AVLinkConnector.h"

@interface AVLinkNetworkUtility : AVBaseNetworkUtility

+(void)createLinkFromLinkConnector:(AVLinkConnector *)linkConnector
                      successBlock:(AVResultBlock)successBlock
                      failureBlock:(AVErrorBlock)failureBlock;

@end
