//
//  AVUserManager+AutoLogin.m
//  Anniversary
//
//  Created by Alan Bouzek on 1/19/15.
//  Copyright (c) 2015 Alan Bouzek. All rights reserved.
//

#import "AVUserManager+AutoLogin.h"
#import "AVConstants.h"
#import <FDKeychain.h>

@implementation AVUserManager (AutoLogin)

+(AVUserManager *)savedManager {
    NSError *error;
    NSDictionary *managerDictionary = [FDKeychain itemForKey:KEYCHAIN_ACCOUNT_NAME
                                                  forService:KEYCHAIN_SERVICE_NAME
                                                       error:&error];
    if (managerDictionary) {
        [[AVUserManager manager] populateFromDictionary:managerDictionary];
        return [AVUserManager manager];
    }
    return nil;
}

+(void)saveManager {
    NSDictionary *managerDictionary = [MTLJSONAdapter JSONDictionaryFromModel:[AVUserManager manager]];
    NSError *error;
    [FDKeychain saveItem:managerDictionary
                  forKey:KEYCHAIN_ACCOUNT_NAME
              forService:KEYCHAIN_SERVICE_NAME
                   error:&error];
}

+(void)removeSavedManager {
    NSError *error;
    [FDKeychain deleteItemForKey:KEYCHAIN_ACCOUNT_NAME
                      forService:KEYCHAIN_SERVICE_NAME
                           error:&error];
}

@end
