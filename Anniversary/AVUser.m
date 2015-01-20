//
//  AVUser.m
//  Anniversary
//
//  Created by Alan Bouzek on 12/12/14.
//  Copyright (c) 2014 Alan Bouzek. All rights reserved.
//

#import "AVUser.h"
#import "AVCoupon.h"

@implementation AVUser

+(instancetype)userWithId:(NSInteger)id {
    AVUser *user = [AVUser new];
    user.id = id;
    return user;
}

+(instancetype)userWithUsername:(NSString *)username
                  password:(NSString *)password {
    AVUser *user = [AVUser new];
    user.username = username;
    user.password = password;
    return user;
}

+(instancetype)userWithUsername:(NSString *)username
                  password:(NSString *)password
                  linkCode:(NSString *)linkCode{
    AVUser *user = [self userWithUsername:username password:password];
    user.linkCode = linkCode;
    return user;
}


#pragma mark - MTLJSONSerializing methods

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"id":@"id",
             @"username":@"username",
             @"linkCode":@"link_code",
             @"coupons":@"coupons",
             @"sentCoupons":@"sent_coupons",
             @"password":@"password"};
}

+(NSValueTransformer*)couponsJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[AVCoupon class]];
}

+(NSValueTransformer*)sentCouponsJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[AVCoupon class]];
}

@end
