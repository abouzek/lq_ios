//
//  AVLink.h
//  Anniversary
//
//  Created by Alan Bouzek on 1/13/15.
//  Copyright (c) 2015 Alan Bouzek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>

@interface AVLinkConnector : MTLModel <MTLJSONSerializing>

+(instancetype)linkConnectorWithUserId:(NSInteger)userId
                     linkCode:(NSString *)linkCode;

@property (nonatomic) NSInteger userId;
@property (strong, nonatomic) NSString *linkCode;

@end
