//
//  AVBaseLoginTabController.m
//  Anniversary
//
//  Created by Alan Bouzek on 12/11/14.
//  Copyright (c) 2014 Alan Bouzek. All rights reserved.
//

#import "AVBaseLoginTabController.h"
#import "AVTransitionUtility.h"

@implementation AVBaseLoginTabController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectedIndex = Title;
    self.tabBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - AVBaseLoginViewControllerDelegate methods

-(void)baseLoginViewControllerShouldPerformOperation:(AVBaseLoginViewController *)baseLoginViewController withSuccessBlock:(AVCompletionBlock)successBlock failureBlock:(AVErrorBlock)failureBlock {
    id<AVLoginController> currentController = (id<AVLoginController>)self.selectedViewController;
    [currentController completeWithSuccessBlock:successBlock failureBlock:failureBlock];
}

-(void)baseLoginViewControllerShouldPerformOperation:(AVBaseLoginViewController *)baseLoginViewController {
    id<AVLoginController> currentController = (id<AVLoginController>)self.selectedViewController;
    [currentController completeWithSuccessBlock:^{
    } failureBlock:nil];
}

-(void)baseLoginViewControllerDidPressRegisterButton:(AVBaseLoginTabController *)baseLoginViewController {
    [self transitionToViewAtIndex:Register];
}

-(void)baseLoginViewControllerDidPressLoginButton:(AVBaseLoginViewController *)baseLoginViewController {
    [self transitionToViewAtIndex:Login];
}

-(void)baseLoginViewControllerDidPressCancelButton:(AVBaseLoginViewController *)baseLoginViewController {
    [self transitionToViewAtIndex:Title];
}


#pragma mark - utility methods

-(void)transitionToViewAtIndex:(LoginTabIndex)toIndex {
    UIView *fromView = self.selectedViewController.view;
    UIView *toView = ((UIViewController*)self.viewControllers[toIndex]).view;
    SlideDirection direction = toIndex > self.selectedIndex ? Left : Right;

    // Block interaction and perform the transition
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [AVTransitionUtility slideTransitionFromView:fromView
                                          toView:toView
                                   withDirection:direction
                             withCompletionBlock:^{
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        self.selectedIndex = toIndex;
    }];
}


@end
