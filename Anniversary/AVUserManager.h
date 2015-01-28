//
//  AVUserManager.h
//  Anniversary
//
//  Created by Alan Bouzek on 1/12/15.
//  Copyright (c) 2015 Alan Bouzek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AVUser.h"
#import <Mantle.h>
#import "AVColorUtility.h"
#import "AVToken.h"
#import "AVLink.h"

@interface AVUserManager : MTLModel <MTLJSONSerializing>

+(instancetype)manager;
-(void)populateFromDictionary:(NSDictionary *)dictionary;
-(void)populateAPITokenFromToken:(AVToken *)token;
-(BOOL)tokenNeedsRefreshing;
-(NSInteger)linkedUserId;

@property (strong, nonatomic) AVUser *currentUser;
@property (strong, readonly, nonatomic) NSString *apiToken;
@property (strong, nonatomic) AVLink *link;
@property (nonatomic) ColorScheme colorScheme;

@end
