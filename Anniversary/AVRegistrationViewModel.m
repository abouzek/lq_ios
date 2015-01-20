//
//  AVRegistrationViewModel.m
//  Anniversary
//
//  Created by Alan Bouzek on 12/11/14.
//  Copyright (c) 2014 Alan Bouzek. All rights reserved.
//

#import "AVRegistrationViewModel.h"
#import "AVStringUtility.h"

@implementation AVRegistrationViewModel

-(NSString *)confirmPassword {
    return [AVStringUtility trimmedStringFromString:_confirmPassword];
}

@end
