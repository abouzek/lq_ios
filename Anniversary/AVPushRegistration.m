//
//  AVPushRegistration.m
//  Anniversary
//
//  Created by Alan Bouzek on 1/19/15.
//  Copyright (c) 2015 Alan Bouzek. All rights reserved.
//

#import "AVPushRegistration.h"

@implementation AVPushRegistration

+(instancetype)pushRegistrationForUser:(AVUser *)user
                           deviceToken:(NSString *)deviceToken {
    AVPushRegistration *pushRegistration = [AVPushRegistration new];
    pushRegistration.user = user;
    pushRegistration.deviceToken = deviceToken;
    return pushRegistration;
}

#pragma mark - MTLJSONSerializing methods

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"id":@"id",
             @"user":@"user",
             @"deviceToken":@"device_token"};
}

+(NSValueTransformer*)userJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[AVUser class]];
}

@end
