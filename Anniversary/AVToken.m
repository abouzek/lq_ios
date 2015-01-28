//
//  AVToken.m
//  Anniversary
//
//  Created by Alan Bouzek on 1/12/15.
//  Copyright (c) 2015 Alan Bouzek. All rights reserved.
//

#import "AVToken.h"

@implementation AVToken

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"token":@"token",
             @"currentUserId":@"user_id",
             @"tokenExpirationSeconds":@"token_expiration_seconds"};
}

@end
