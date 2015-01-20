//
//  AVModalUtility.m
//  Anniversary
//
//  Created by Alan Bouzek on 12/19/14.
//  Copyright (c) 2014 Alan Bouzek. All rights reserved.
//

#import "AVModalUtility.h"
#import "AVAppDelegate.h"
#import "AVTransitionUtility.h"
#import "AVModalContainerViewController.h"
#import "AVModalViewController.h"

@interface AVModalUtility ()

@property (strong, nonatomic) AVModalContainerViewController *modalContainerViewController;
@property (weak, nonatomic) AVModalViewController *customModalViewController;

@end


@implementation AVModalUtility

+(AVModalUtility *)sharedInstance {
    static AVModalUtility *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
        instance.modalContainerViewController = [[AVModalContainerViewController alloc]
                                             initWithNibName:@"AVModalContainerViewController"
                                             bundle:nil];
    });
    return instance;
}

-(AVModalContainerViewController *)modalContainerViewController {
    if (!_modalContainerViewController) {
        _modalContainerViewController = [[AVModalContainerViewController alloc]
                                             initWithNibName:@"AVModalContainerViewController"
                                             bundle:nil];
    }
    return _modalContainerViewController;
}


#pragma mark - presentation methods

-(void)presentModalViewController:(AVModalViewController *)customModalViewController
                 onViewController:(UIViewController *)viewController {
    viewController.definesPresentationContext = YES;
    viewController.providesPresentationContextTransitionStyle = YES;
    self.modalContainerViewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    // Present the modal container view controller
    [viewController presentViewController:self.modalContainerViewController
                                 animated:NO
                               completion:^{
                                
                                   // Show the blurred background
                                   [self.modalContainerViewController showBlurViewWithCompletionBlock:^{
                                       
                                       // Add the actual modal view controller
                                       [self.modalContainerViewController.view addSubview:customModalViewController.view];
                                       [AVTransitionUtility popModalTransitionView:customModalViewController.view
                                                               withCompletionBlock:^{
                                                                   
                                                                   // Set modal view controller as a child of the container view controller
                                                                   [self.modalContainerViewController addChildViewController:customModalViewController];
                                                                   self.customModalViewController = customModalViewController;
                                                               }];
                                   }];
                               }];
}

-(void)dismissModalViewWithCompletionBlock:(AVCompletionBlock)completionBlock {
    // Hide modal view controller, then hide blur view and dismiss modal container view controller
    [AVTransitionUtility shrinkModalTransitionView:self.customModalViewController.view withCompletionBlock:^{
        [self.customModalViewController.view removeFromSuperview];
        [self.customModalViewController removeFromParentViewController];
        self.customModalViewController = nil;
        
        [self.modalContainerViewController hideBlurViewWithCompletionBlock:^{
            [self.modalContainerViewController dismissViewControllerAnimated:NO completion:^{
                self.modalContainerViewController = nil;
                
                !completionBlock ?: completionBlock();
            }];
        }];
    }];
}

@end
