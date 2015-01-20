//
//  AVNetworkUtility.h
//  Anniversary
//
//  Created by Alan Bouzek on 1/12/15.
//  Copyright (c) 2015 Alan Bouzek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "AVUser.h"
#import "AVConstants.h"
#import "AVTokenRefreshHTTPRequestOperationManager.h"

typedef NS_ENUM(NSInteger, RequestEntity) {
    CreateUser,
    GetToken,
    CreateLink,
    CreateCoupon,
    CreatePush
};

typedef NS_ENUM(NSInteger, ParameterRequestEntity) {
    GetUser,
    GetCoupon,
    UpdateCoupon,
    DeleteCoupon,
    GetLink,
    DeleteLink,
    GetCouponsForUser,
    GetSentCouponsForUser,
    GetLinkForUser
};


@interface AVBaseNetworkUtility : NSObject

+(AFHTTPRequestOperationManager *)baseManager;
+(AFHTTPRequestOperationManager *)managerToLoginUser:(AVUser *)user;
+(AVTokenRefreshHTTPRequestOperationManager *)managerForLoggedInUser;

+(NSString *)requestURLStringForRequestEntity:(RequestEntity)requestEntity;
+(NSString *)requestURLStringForParameterRequestEntity:(ParameterRequestEntity)requestEntity
                                        withParameters:(NSArray *)parameters;

@end
