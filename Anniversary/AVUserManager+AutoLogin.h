//
//  AVUserManager+AutoLogin.h
//  Anniversary
//
//  Created by Alan Bouzek on 1/19/15.
//  Copyright (c) 2015 Alan Bouzek. All rights reserved.
//

#import "AVUserManager.h"

@interface AVUserManager (AutoLogin)

+(AVUserManager *)savedManager;
+(void)saveManager;
+(void)removeSavedManager;

@end
