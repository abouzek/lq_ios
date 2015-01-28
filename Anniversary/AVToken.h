//
//  AVToken.h
//  Anniversary
//
//  Created by Alan Bouzek on 1/12/15.
//  Copyright (c) 2015 Alan Bouzek. All rights reserved.
//

#import "MTLModel.h"
#import <Mantle.h>

@interface AVToken : MTLModel <MTLJSONSerializing>

@property (strong, nonatomic) NSString *token;
@property (nonatomic) NSInteger tokenExpirationSeconds;
@property (nonatomic) NSInteger currentUserId;

@end
