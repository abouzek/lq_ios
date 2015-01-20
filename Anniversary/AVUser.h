//
//  AVUser.h
//  Anniversary
//
//  Created by Alan Bouzek on 12/12/14.
//  Copyright (c) 2014 Alan Bouzek. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface AVUser : MTLModel <MTLJSONSerializing>

+(instancetype)userWithId:(NSInteger)id;
+(instancetype)userWithUsername:(NSString *)username
                  password:(NSString *)password;
+(instancetype)userWithUsername:(NSString *)username
                   password:(NSString *)password
                   linkCode:(NSString *)linkCode;

@property (nonatomic) NSInteger id;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *linkCode;
@property (strong, nonatomic) NSArray *coupons;
@property (strong, nonatomic) NSArray *notes;
@property (strong, nonatomic) NSArray *sentNotes;
@property (strong, nonatomic) NSArray *sentCoupons;

@end
