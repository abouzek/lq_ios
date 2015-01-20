//
//  AVBaseLoginViewController.h
//  Anniversary
//
//  Created by Alan Bouzek on 12/11/14.
//  Copyright (c) 2014 Alan Bouzek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AVHeartView.h"
#import "AVConstants.h"
#import "AVColoredViewController.h"

@protocol AVBaseLoginViewControllerDelegate;
@protocol AVLoginController;


@interface AVBaseLoginViewController : AVColoredViewController

@property (weak, nonatomic) id<AVBaseLoginViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet AVHeartView *heartView;
@property (strong, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UIButton *registerButton;

@end


@protocol AVBaseLoginViewControllerDelegate <NSObject>

-(void)baseLoginViewControllerShouldPerformOperation:(AVBaseLoginViewController *)baseLoginViewController
                                    withSuccessBlock:(AVCompletionBlock)successBlock
                                        failureBlock:(AVErrorBlock)failureBlock;
-(void)baseLoginViewControllerDidPressRegisterButton:(AVBaseLoginViewController *)baseLoginViewController;
-(void)baseLoginViewControllerDidPressLoginButton:(AVBaseLoginViewController *)baseLoginViewController;
-(void)baseLoginViewControllerDidPressCancelButton:(AVBaseLoginViewController *)baseLoginViewController;

@end


@protocol AVLoginController <NSObject>

-(void)completeWithSuccessBlock:(AVCompletionBlock)successBlock
                   failureBlock:(AVErrorBlock)failureBlock;

@end
