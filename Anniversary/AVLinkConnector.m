//
//  AVLink.m
//  Anniversary
//
//  Created by Alan Bouzek on 1/13/15.
//  Copyright (c) 2015 Alan Bouzek. All rights reserved.
//

#import "AVLinkConnector.h"

@implementation AVLinkConnector

+(instancetype)linkConnectorWithUserId:(NSInteger)userId
                     linkCode:(NSString *)linkCode {
    AVLinkConnector *link = [AVLinkConnector new];
    link.userId = userId;
    link.linkCode = linkCode;
    return link;
}


#pragma mark - MTLJSONSerializing methods

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"linkCode":@"link_code",
             @"userId":@"user_id"};
}

@end
