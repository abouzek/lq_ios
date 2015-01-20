//
//  AVHTTPRequestOperationManager.h
//  Anniversary
//
//  Created by Alan Bouzek on 1/19/15.
//  Copyright (c) 2015 Alan Bouzek. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

/*
 * Wraps AFHTTPRequestOperationManager methods with automatic token refeshing functionality
 *
 */

@interface AVTokenRefreshHTTPRequestOperationManager : AFHTTPRequestOperationManager
@end
