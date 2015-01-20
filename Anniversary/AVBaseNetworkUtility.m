//
//  AVNetworkUtility.m
//  Anniversary
//
//  Created by Alan Bouzek on 1/12/15.
//  Copyright (c) 2015 Alan Bouzek. All rights reserved.
//

#import "AVBaseNetworkUtility.h"
#import "AVUserManager.h"
#import "AVStringUtility.h"

@implementation AVBaseNetworkUtility

#pragma mark - manager methods

+(AFHTTPRequestOperationManager *)baseManager {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.HTTPMethodsEncodingParametersInURI = nil;
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    return manager;
}

+(NSString *)base64AuthStringFromUsername:(NSString *)username password:(NSString *)password {
    NSString *authString = [NSString stringWithFormat:@"%@:%@", username, password];
    return [NSString stringWithFormat:@"Basic %@", [AVStringUtility base64StringFromString:authString]];
}

+(AFHTTPRequestOperationManager *)managerToLoginUser:(AVUser *)user {
    AFHTTPRequestOperationManager *manager = [self baseManager];
    NSString *authValue = [self base64AuthStringFromUsername:user.username password:user.password];
    [manager.requestSerializer setValue:authValue forHTTPHeaderField:@"Authorization"];
    return manager;
}

+(AVTokenRefreshHTTPRequestOperationManager *)managerForLoggedInUser {
    AVTokenRefreshHTTPRequestOperationManager *manager = [AVTokenRefreshHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.HTTPMethodsEncodingParametersInURI = nil;
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSString *apiToken = [AVUserManager manager].apiToken;
    NSString *authValue = [self base64AuthStringFromUsername:apiToken password:@"xxx"];
    [manager.requestSerializer setValue:authValue forHTTPHeaderField:@"Authorization"];
    return manager;
}


#pragma mark - utility methods

+(NSString *)urlSuffixForRequestEntity:(RequestEntity)requestEntity {
    switch (requestEntity) {
        case CreateUser:
            return @"users";
        case GetToken:
            return @"token";
        case CreateLink:
            return @"links";
        case CreateCoupon:
            return @"coupons";
        case CreatePush:
            return @"push";
    }
}

+(NSString *)requestURLStringForRequestEntity:(RequestEntity)requestEntity {
    NSString *suffixForURL = [self urlSuffixForRequestEntity:requestEntity];
    return [NSString stringWithFormat:@"%@%@", SERVER_BASE_URL, suffixForURL];
}


+(NSString *)urlSuffixForParameterRequestEntity:(ParameterRequestEntity)parameterRequestEntity {
    switch (parameterRequestEntity) {
        case GetUser:
            return @"users/@";
        case GetLink:
        case DeleteLink:
            return @"links/@";
        case GetCoupon:
        case UpdateCoupon:
        case DeleteCoupon:
            return @"coupons/@";
        case GetLinkForUser:
            return @"users/@/link";
        case GetCouponsForUser:
            return @"users/@/coupons";
        case GetSentCouponsForUser:
            return @"users/@/sentCoupons";
    }
}

+(NSString *)requestURLStringForParameterRequestEntity:(ParameterRequestEntity)parameterRequestEntity
                                        withParameters:(NSArray *)parameters {
    NSString *suffixForURL = [self urlSuffixForParameterRequestEntity:parameterRequestEntity];
    
    for (id parameter in parameters) {
        
        NSString *stringParameter;
        if (![parameter isKindOfClass:[NSString class]]) {
            stringParameter = [NSString stringWithFormat:@"%@", parameter];
        }
        else {
            stringParameter = parameter;
        }
        
        NSRange rangeToReplace = [suffixForURL rangeOfString:@"@"];
        if (rangeToReplace.location != NSNotFound) {
            suffixForURL = [suffixForURL stringByReplacingCharactersInRange:rangeToReplace
                                                                 withString:stringParameter];
        }
    }
    
    return [NSString stringWithFormat:@"%@%@", SERVER_BASE_URL, suffixForURL];
}

@end
