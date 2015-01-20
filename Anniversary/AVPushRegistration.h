//
//  AVPushRegistration.h
//  Anniversary
//
//  Created by Alan Bouzek on 1/19/15.
//  Copyright (c) 2015 Alan Bouzek. All rights reserved.
//

#import <Mantle.h>
#import "AVUser.h"

@interface AVPushRegistration : MTLModel <MTLJSONSerializing>

+(instancetype)pushRegistrationForUser:(AVUser *)user
                            deviceToken:(NSString *)deviceToken;

@property (nonatomic) NSInteger id;
@property (nonatomic) AVUser *user;
@property (strong, nonatomic) NSString *deviceToken;

@end
