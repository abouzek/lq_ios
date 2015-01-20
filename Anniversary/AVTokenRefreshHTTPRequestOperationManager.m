//
//  AVHTTPRequestOperationManager.m
//  Anniversary
//
//  Created by Alan Bouzek on 1/19/15.
//  Copyright (c) 2015 Alan Bouzek. All rights reserved.
//

#import "AVTokenRefreshHTTPRequestOperationManager.h"
#import "AVConstants.h"
#import "AVUserManager.h"
#import "AVBaseNetworkUtility.h"
#import "AVUserNetworkUtility.h"

@implementation AVTokenRefreshHTTPRequestOperationManager

- (AFHTTPRequestOperation *)GET:(NSString *)URLString
                     parameters:(id)parameters
                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    if ([[AVUserManager manager] tokenNeedsRefreshing]) {
        [AVUserNetworkUtility refreshAPITokenForLoggedInUserWithSuccessBlock:^{
            AVTokenRefreshHTTPRequestOperationManager *manager = [AVBaseNetworkUtility managerForLoggedInUser];
            [manager GET:URLString parameters:parameters success:success failure:failure];
        }];
    }
    else {
        return [super GET:URLString parameters:parameters success:success failure:failure];
    }
    return nil;
}

- (AFHTTPRequestOperation *)HEAD:(NSString *)URLString
                      parameters:(id)parameters
                         success:(void (^)(AFHTTPRequestOperation *operation))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    if ([[AVUserManager manager] tokenNeedsRefreshing]) {
        [AVUserNetworkUtility refreshAPITokenForLoggedInUserWithSuccessBlock:^{
            AVTokenRefreshHTTPRequestOperationManager *manager = [AVBaseNetworkUtility managerForLoggedInUser];
            [manager HEAD:URLString parameters:parameters success:success failure:failure];
        }];
    }
    else {
        return [super HEAD:URLString parameters:parameters success:success failure:failure];
    }
    return nil;
}

- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(id)parameters
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    if ([[AVUserManager manager] tokenNeedsRefreshing]) {
        [AVUserNetworkUtility refreshAPITokenForLoggedInUserWithSuccessBlock:^{
            [super POST:URLString parameters:parameters success:success failure:failure];
        }];
    }
    else {
        return [super POST:URLString parameters:parameters success:success failure:failure];
    }
    return nil;
}

- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(id)parameters
       constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    if ([[AVUserManager manager] tokenNeedsRefreshing]) {
        [AVUserNetworkUtility refreshAPITokenForLoggedInUserWithSuccessBlock:^{
            AVTokenRefreshHTTPRequestOperationManager *manager = [AVBaseNetworkUtility managerForLoggedInUser];
            [manager POST:URLString parameters:parameters constructingBodyWithBlock:block success:success failure:failure];
        }];
    }
    else {
        return [super POST:URLString parameters:parameters constructingBodyWithBlock:block success:success failure:failure];
    }
    return nil;
}

- (AFHTTPRequestOperation *)PUT:(NSString *)URLString
                     parameters:(id)parameters
                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    if ([[AVUserManager manager] tokenNeedsRefreshing]) {
        [AVUserNetworkUtility refreshAPITokenForLoggedInUserWithSuccessBlock:^{
            AVTokenRefreshHTTPRequestOperationManager *manager = [AVBaseNetworkUtility managerForLoggedInUser];
            [manager PUT:URLString parameters:parameters success:success failure:failure];
        }];
    }
    else {
        return [self PUT:URLString parameters:parameters success:success failure:failure];
    }
    return nil;
}

- (AFHTTPRequestOperation *)PATCH:(NSString *)URLString
                       parameters:(id)parameters
                          success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    if ([[AVUserManager manager] tokenNeedsRefreshing]) {
        [AVUserNetworkUtility refreshAPITokenForLoggedInUserWithSuccessBlock:^{
            AVTokenRefreshHTTPRequestOperationManager *manager = [AVBaseNetworkUtility managerForLoggedInUser];
            [manager PATCH:URLString parameters:parameters success:success failure:failure];
        }];
    }
    else {
        return [self PATCH:URLString parameters:parameters success:success failure:failure];
    }
    return nil;
}

- (AFHTTPRequestOperation *)DELETE:(NSString *)URLString
                        parameters:(id)parameters
                           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    if ([[AVUserManager manager] tokenNeedsRefreshing]) {
        [AVUserNetworkUtility refreshAPITokenForLoggedInUserWithSuccessBlock:^{
            AVTokenRefreshHTTPRequestOperationManager *manager = [AVBaseNetworkUtility managerForLoggedInUser];
            [manager DELETE:URLString parameters:parameters success:success failure:failure];
        }];
    }
    else {
        return [self DELETE:URLString parameters:parameters success:success failure:failure];
    }
    return nil;
}

@end
