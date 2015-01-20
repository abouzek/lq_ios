//
//  AVLink.h
//  Anniversary
//
//  Created by Alan Bouzek on 1/14/15.
//  Copyright (c) 2015 Alan Bouzek. All rights reserved.
//

#import "MTLModel.h"
#import "AVUser.h"

@interface AVLink : MTLModel <MTLJSONSerializing>

@property (nonatomic) NSInteger id;
@property (strong, nonatomic) AVUser *firstUser;
@property (strong, nonatomic) AVUser *secondUser;

@end
