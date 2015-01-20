//
//  AVChore.m
//  Anniversary
//
//  Created by Alan Bouzek on 12/12/14.
//  Copyright (c) 2014 Alan Bouzek. All rights reserved.
//

#import "AVCoupon.h"

@implementation AVCoupon

+(instancetype)couponWithId:(NSInteger)id
                       name:(NSString*)name
                      count:(NSInteger)count
                      owner:(AVUser *)owner
                     sender:(AVUser *)sender {
    AVCoupon *coupon = [AVCoupon new];
    coupon.id = id;
    coupon.name = name;
    coupon.count = count;
    coupon.owner = owner;
    coupon.sender = sender;
    return coupon;
}


#pragma mark - MTLJSONSerializing methods

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"owner":@"owner",
             @"sender":@"sender",
             @"name":@"name",
             @"count":@"count",
             @"id":@"id"};
}

+(NSValueTransformer*)ownerJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[AVUser class]];
}

+(NSValueTransformer*)senderJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[AVUser class]];
}

@end
