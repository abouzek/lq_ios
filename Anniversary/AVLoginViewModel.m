//
//  AVLoginViewModel.m
//  Anniversary
//
//  Created by Alan Bouzek on 12/11/14.
//  Copyright (c) 2014 Alan Bouzek. All rights reserved.
//

#import "AVLoginViewModel.h"
#import "AVStringUtility.h"

@implementation AVLoginViewModel

-(NSString *)username {
    return [AVStringUtility trimmedStringFromString:_username];
}

-(NSString *)password {
    return [AVStringUtility trimmedStringFromString:_password];
}

@end
