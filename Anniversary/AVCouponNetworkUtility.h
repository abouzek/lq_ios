//
//  AVCouponNetworkUtility.h
//  Anniversary
//
//  Created by Alan Bouzek on 1/19/15.
//  Copyright (c) 2015 Alan Bouzek. All rights reserved.
//

#import "AVBaseNetworkUtility.h"
#import "AVCoupon.h"

@interface AVCouponNetworkUtility : AVBaseNetworkUtility

+(void)fetchCouponsForUserId:(NSInteger)userId
                successBlock:(AVResultBlock)successBlock
                failureBlock:(AVErrorBlock)failureBlock;
+(void)fetchSentCouponsForUserId:(NSInteger)userId
                    successBlock:(AVResultBlock)successBlock
                    failureBlock:(AVErrorBlock)failureBlock;
+(void)createCoupon:(AVCoupon *)coupon
       successBlock:(AVResultBlock)successBlock
       failureBlock:(AVErrorBlock)failureBlock;
+(void)updateCoupon:(AVCoupon *)coupon
       successBlock:(AVCompletionBlock)successBlock
       failureBlock:(AVErrorBlock)failureBlock;

@end
