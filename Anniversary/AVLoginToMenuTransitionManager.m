//
//  AVLoginToMenuTransitionManager.m
//  Anniversary
//
//  Created by Alan Bouzek on 12/11/14.
//  Copyright (c) 2014 Alan Bouzek. All rights reserved.
//

#import "AVLoginToMenuTransitionManager.h"
#import "AVMenuViewController.h"
#import "AVBaseLoginViewController.h"

@interface AVLoginToMenuTransitionManager ()

@property (nonatomic) BOOL presenting;

@end


@implementation AVLoginToMenuTransitionManager

-(instancetype)init {
    if (self = [super init]) {
        self.presenting = YES;
    }
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning methods

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = [transitionContext containerView];
    
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    AVMenuViewController *menuViewController = self.presenting ? (AVMenuViewController *)toViewController : (AVMenuViewController *)fromViewController;
    AVBaseLoginViewController *baseLoginViewController = self.presenting ? (AVBaseLoginViewController *)fromViewController : (AVBaseLoginViewController *)toViewController;
    
    if (self.presenting) {
        [self offStageMenuViewController:menuViewController];
    }
    else {
        [self offStageBaseLoginViewController:baseLoginViewController];
    }
    
    UIView *menuView = menuViewController.view;
    UIView *baseLoginView = baseLoginViewController.view;
    
    [containerView addSubview:baseLoginView];
    [containerView addSubview:menuView];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0.2 options:0 animations:^{
        if (self.presenting) {
            [self offStageBaseLoginViewController:baseLoginViewController];
            [self onStageMenuViewController:menuViewController];
        }
        else {
            [self offStageMenuViewController:menuViewController];
            [self onStageBaseLoginViewController:baseLoginViewController];
        }
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.85;
}


#pragma mark - UIViewControllerTransitioningDelegate methods

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.presenting = YES;
    return self;
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.presenting = NO;
    return self;
}


#pragma mark - utility methods

-(CGAffineTransform)offStageXByAmount:(CGFloat)amount {
    return CGAffineTransformMakeTranslation(amount, 0);
}

-(CGAffineTransform)offStageYByAmount:(CGFloat)amount {
    return CGAffineTransformMakeTranslation(0, amount);
}

-(void)offStageBaseLoginViewController:(AVBaseLoginViewController *)baseLoginViewController {
    baseLoginViewController.heartView.alpha = 0;
    baseLoginViewController.containerView.transform = [self offStageXByAmount:-baseLoginViewController.view.frame.size.width];
    CGFloat offset = baseLoginViewController.loginButton.frame.size.width;
    baseLoginViewController.loginButton.transform = [self offStageXByAmount:offset];
    baseLoginViewController.registerButton.transform = [self offStageXByAmount:-offset];
}

-(void)onStageBaseLoginViewController:(AVBaseLoginViewController *)baseLoginViewController {
    baseLoginViewController.heartView.alpha = 0.05;
    baseLoginViewController.containerView.transform = CGAffineTransformIdentity;
    baseLoginViewController.loginButton.transform = CGAffineTransformIdentity;
    baseLoginViewController.registerButton.transform = CGAffineTransformIdentity;
}

-(void)offStageMenuViewController:(AVMenuViewController *)menuViewController {
    menuViewController.view.alpha = 0;
    menuViewController.heartView.alpha = 0;
    CGFloat offset = menuViewController.view.frame.size.height;
    menuViewController.topContainerView.transform = [self offStageYByAmount:-offset * 3];
    menuViewController.bottomContainerView.transform = [self offStageYByAmount:offset];
}

-(void)onStageMenuViewController:(AVMenuViewController *)menuViewController {
    menuViewController.view.alpha = 1;
    menuViewController.heartView.alpha = 0.05;
    menuViewController.topContainerView.transform = CGAffineTransformIdentity;
    menuViewController.bottomContainerView.transform = CGAffineTransformIdentity;
}

@end
