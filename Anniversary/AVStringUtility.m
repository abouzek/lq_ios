//
//  AVStringUtility.m
//  Anniversary
//
//  Created by Alan Bouzek on 12/11/14.
//  Copyright (c) 2014 Alan Bouzek. All rights reserved.
//

#import "AVStringUtility.h"

@implementation AVStringUtility

+(NSString *)stringFromInt:(int)theInt {
    return [NSString stringWithFormat:@"%d", theInt];
}

+(NSString *)base64StringFromString:(NSString *)string {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}

+(NSString *)trimmedStringFromString:(NSString *)string {
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

@end
