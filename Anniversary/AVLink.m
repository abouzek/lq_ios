//
//  AVLink.m
//  Anniversary
//
//  Created by Alan Bouzek on 1/14/15.
//  Copyright (c) 2015 Alan Bouzek. All rights reserved.
//

#import "AVLink.h"

@implementation AVLink

#pragma mark - MTLJSONSerializing methods

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"id":@"id",
             @"firstUser":@"first_user",
             @"secondUser":@"second_user"};
}

+(NSValueTransformer*)firstUserJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[AVUser class]];
}

+(NSValueTransformer*)secondUserJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[AVUser class]];
}

@end
