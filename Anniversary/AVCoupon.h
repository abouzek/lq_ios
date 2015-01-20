//
//  AVChore.h
//  Anniversary
//
//  Created by Alan Bouzek on 12/12/14.
//  Copyright (c) 2014 Alan Bouzek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>
#import "AVUser.h"

@interface AVCoupon : MTLModel <MTLJSONSerializing>

+(instancetype)couponWithId:(NSInteger)id
                    name:(NSString *)name
                     count:(NSInteger)count
                     owner:(AVUser *)owner
                    sender:(AVUser *)sender;

@property (nonatomic) NSInteger id;
@property (strong, nonatomic) AVUser *owner;
@property (strong, nonatomic) AVUser *sender;
@property (strong, nonatomic) NSString *name;
@property (nonatomic) NSInteger count;

@end
