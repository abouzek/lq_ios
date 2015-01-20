//
//  AVStringUtility.h
//  Anniversary
//
//  Created by Alan Bouzek on 12/11/14.
//  Copyright (c) 2014 Alan Bouzek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AVStringUtility : NSObject

+(NSString *)stringFromInt:(int)theInt;
+(NSString *)base64StringFromString:(NSString *)string;
+(NSString *)trimmedStringFromString:(NSString *)string;

@end
