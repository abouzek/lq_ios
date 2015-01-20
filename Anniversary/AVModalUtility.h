//
//  AVModalUtility.h
//  Anniversary
//
//  Created by Alan Bouzek on 12/19/14.
//  Copyright (c) 2014 Alan Bouzek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AVModalViewController.h"
#import "AVConstants.h"

@interface AVModalUtility : NSObject

+(AVModalUtility *)sharedInstance;

-(void)presentModalViewController:(AVModalViewController *)modalViewController
                 onViewController:(UIViewController *)viewController;
-(void)dismissModalViewWithCompletionBlock:(AVCompletionBlock)completionBlock;

@end
