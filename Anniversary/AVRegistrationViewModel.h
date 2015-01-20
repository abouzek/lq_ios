//
//  AVRegistrationViewModel.h
//  Anniversary
//
//  Created by Alan Bouzek on 12/11/14.
//  Copyright (c) 2014 Alan Bouzek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AVLoginViewModel.h"

@interface AVRegistrationViewModel : AVLoginViewModel

@property (strong, nonatomic) NSString *confirmPassword;
@property (strong, nonatomic) NSString *linkCode;

@end
