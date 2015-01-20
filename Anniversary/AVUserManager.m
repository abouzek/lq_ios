//
//  AVUserManager.m
//  Anniversary
//
//  Created by Alan Bouzek on 1/12/15.
//  Copyright (c) 2015 Alan Bouzek. All rights reserved.
//

#import "AVUserManager.h"
#import "AVConstants.h"

@interface AVUserManager ()

@property (strong, nonatomic) NSString *apiToken;
@property (strong, nonatomic) NSDate *apiTokenExpirationDate;

@end


@implementation AVUserManager

+(instancetype)manager {
    return [self managerFromManager:nil];
}

+(instancetype)managerFromManager:(AVUserManager *)manager
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    
    @synchronized(self) {
        if (manager) {
            sharedInstance = manager;
        }
    }

    return sharedInstance;
}

-(void)populateFromDictionary:(NSDictionary *)dictionary {
    AVUserManager *manager = [MTLJSONAdapter modelOfClass:[AVUserManager class]
                                       fromJSONDictionary:dictionary
                                                    error:nil];
    [AVUserManager managerFromManager:manager];
}


#pragma mark - utility methods

-(void)populateAPITokenFromToken:(AVToken *)token {
    self.apiToken = token.token;
    self.apiTokenExpirationDate = [[NSDate date] dateByAddingTimeInterval:token.tokenExpirationSeconds];
}

-(BOOL)tokenNeedsRefreshing {
    if (self.apiToken && self.apiTokenExpirationDate) {
        NSComparisonResult comparisonResult = [self.apiTokenExpirationDate compare:[NSDate date]];
        return comparisonResult == NSOrderedSame
            || comparisonResult == NSOrderedAscending;
    }
    return NO;
}


#pragma mark - getter and setter methods

-(ColorScheme)colorScheme {
    return [[NSUserDefaults standardUserDefaults] integerForKey:COLOR_SCHEME_DEFAULTS_KEY];
}

-(void)setColorScheme:(ColorScheme)colorScheme {
    [[NSUserDefaults standardUserDefaults] setInteger:colorScheme
                                              forKey:COLOR_SCHEME_DEFAULTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


#pragma mark - MTLJSONSerializing methods

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"linkedUserId":@"linkedUserId",
             @"apiToken":@"apiToken",
             @"currentUser":@"currentUser",
             @"apiTokenExpirationDate":@"apiTokenExpirationDate"};
}

+(NSValueTransformer*)currentUserJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[AVUser class]];
}

@end
