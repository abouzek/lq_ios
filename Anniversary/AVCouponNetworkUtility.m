//
//  AVCouponNetworkUtility.m
//  Anniversary
//
//  Created by Alan Bouzek on 1/19/15.
//  Copyright (c) 2015 Alan Bouzek. All rights reserved.
//

#import "AVCouponNetworkUtility.h"

@implementation AVCouponNetworkUtility

+(void)fetchCouponsForUserId:(NSInteger)userId
                successBlock:(AVResultBlock)successBlock
                failureBlock:(AVErrorBlock)failureBlock {
    AFHTTPRequestOperationManager *manager = [self managerForLoggedInUser];
    NSString *requestURL = [AVBaseNetworkUtility requestURLStringForParameterRequestEntity:GetCouponsForUser
                                                                        withParameters:@[@(userId)]];
    [manager GET:requestURL
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             
             NSArray *coupons = [MTLJSONAdapter modelsOfClass:[AVCoupon class]
                                                fromJSONArray:responseObject
                                                        error:nil];
             
             !successBlock ?: successBlock(coupons);
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             
             NSLog(@"%@", error.description);
             !failureBlock ?: failureBlock(error);
             
         }
     ];
}

+(void)fetchSentCouponsForUserId:(NSInteger)userId
                    successBlock:(AVResultBlock)successBlock
                    failureBlock:(AVErrorBlock)failureBlock {
    AFHTTPRequestOperationManager *manager = [self managerForLoggedInUser];
    NSString *requestURL = [AVBaseNetworkUtility requestURLStringForParameterRequestEntity:GetSentCouponsForUser
                                                                        withParameters:@[@(userId)]];
    [manager GET:requestURL
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             
             NSArray *sentCoupons = [MTLJSONAdapter modelsOfClass:[AVCoupon class]
                                                    fromJSONArray:responseObject
                                                            error:nil];
             !successBlock ?: successBlock(sentCoupons);
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             
             NSLog(@"%@", error.description);
             !failureBlock ?: failureBlock(error);
             
         }
     ];
}

+(void)createCoupon:(AVCoupon *)coupon
       successBlock:(AVResultBlock)successBlock
       failureBlock:(AVErrorBlock)failureBlock {
    AFHTTPRequestOperationManager *manager = [self managerForLoggedInUser];
    NSDictionary *parametersToSend = [MTLJSONAdapter JSONDictionaryFromModel:coupon];
    NSString *requestURL = [AVBaseNetworkUtility requestURLStringForRequestEntity:CreateCoupon];
    
    [manager POST:requestURL
       parameters:parametersToSend
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              AVCoupon *newCoupon = [MTLJSONAdapter modelOfClass:[AVCoupon class]
                                              fromJSONDictionary:responseObject
                                                           error:nil];
              !successBlock ?: successBlock(newCoupon);
              
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
              NSLog(@"%@", error.description);
              !failureBlock ?: failureBlock(error);
              
          }
     ];
}

+(void)updateCoupon:(AVCoupon *)coupon
       successBlock:(AVCompletionBlock)successBlock
       failureBlock:(AVErrorBlock)failureBlock {
    AFHTTPRequestOperationManager *manager = [self managerForLoggedInUser];
    NSDictionary *parametersToSend = [MTLJSONAdapter JSONDictionaryFromModel:coupon];
    NSString *requestURL = [AVBaseNetworkUtility requestURLStringForParameterRequestEntity:UpdateCoupon
                                                                        withParameters:@[@(coupon.id)]];
    [manager PUT:requestURL
      parameters:parametersToSend
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             
             !successBlock ?: successBlock();
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             
             NSLog(@"%@", error.description);
             !failureBlock ?: failureBlock(error);
             
         }
     ];
}

@end
