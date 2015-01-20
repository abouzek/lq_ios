//
//  AVModalContainerViewController.h
//  Anniversary
//
//  Created by Alan Bouzek on 12/20/14.
//  Copyright (c) 2014 Alan Bouzek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AVConstants.h"

@interface AVModalContainerViewController : UIViewController

-(void)showBlurViewWithCompletionBlock:(AVCompletionBlock)completionBlock;
-(void)hideBlurViewWithCompletionBlock:(AVCompletionBlock)completionBlock;

@end
