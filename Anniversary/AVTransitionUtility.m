//
//  AVTransitionUtility.m
//  Anniversary
//
//  Created by Alan Bouzek on 12/11/14.
//  Copyright (c) 2014 Alan Bouzek. All rights reserved.
//

#import "AVTransitionUtility.h"
#import "AVConstants.h"
#import "AVModalUtility.h"

@implementation AVTransitionUtility

+(void)slideTransitionFromView:(UIView *)fromView
                        toView:(UIView *)toView
                 usingDuration:(CGFloat)duration
             springWithDamping:(CGFloat)springDamping
         initialSpringVelocity:(CGFloat)springVelocity
                       options:(UIViewAnimationOptions)options
                 withDirection:(SlideDirection)direction
           withCompletionBlock:(AVCompletionBlock)completion {
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    CGRect toViewStartFrame = toView.frame;
    CGRect toViewEndFrame = fromView.superview.frame;
    CGRect fromViewEndFrame = fromView.frame;
    
    switch (direction) {
        case Up:
            toViewStartFrame.origin.y = -screenSize.height;
            fromViewEndFrame.origin.y = -screenSize.height;
            break;
        case Down:
            toViewStartFrame.origin.y = screenSize.height;
            fromViewEndFrame.origin.y = screenSize.height;
            break;
        case Left:
            toViewStartFrame.origin.x = screenSize.width;
            fromViewEndFrame.origin.x = -screenSize.width;
            break;
        case Right:
            toViewStartFrame.origin.x = -screenSize.width;
            fromViewEndFrame.origin.x = screenSize.width;
            break;
    }
    
    [fromView.superview addSubview:toView];
    toView.frame = toViewStartFrame;
    
    [UIView animateWithDuration:duration delay:0
         usingSpringWithDamping:springDamping
          initialSpringVelocity:springVelocity
                        options:options
                     animations:^{
        toView.frame = toViewEndFrame;
        fromView.frame = fromViewEndFrame;
    } completion:^(BOOL finished) {
        [fromView removeFromSuperview];
        !completion ?: completion();
    }];
}

+(void)slideTransitionFromView:(UIView *)fromView
                        toView:(UIView *)toView
                 withDirection:(SlideDirection)direction
           withCompletionBlock:(AVCompletionBlock)completion {
    [self slideTransitionFromView:fromView
                           toView:toView
                    usingDuration:DEFAULT_TRANSITION_DURATION
                springWithDamping:DEFAULT_TRANSITION_SPRING_DAMPING
            initialSpringVelocity:DEFAULT_TRANSITION_INITIAL_VELOCITY
                          options:0
                    withDirection:direction
              withCompletionBlock:completion];
}

+(void)popModalTransitionView:(UIView *)viewToPresent
     withCompletionBlock:(AVCompletionBlock)completionBlock {
    CGAffineTransform scaleTransform = CGAffineTransformScale(viewToPresent.transform, 0, 0);
    viewToPresent.transform = scaleTransform;
    
    [UIView animateWithDuration:DEFAULT_TRANSITION_DURATION
                          delay:0
         usingSpringWithDamping:DEFAULT_TRANSITION_SPRING_DAMPING
          initialSpringVelocity:DEFAULT_TRANSITION_INITIAL_VELOCITY
                        options:0
                     animations:^{
                         viewToPresent.transform = CGAffineTransformIdentity;
                     }
                     completion:^(BOOL finished) {
                         !completionBlock ?: completionBlock();
                     }];
}

+(void)shrinkModalTransitionView:(UIView *)viewToHide
        withCompletionBlock:(AVCompletionBlock)completionBlock {
    [UIView animateWithDuration:DEFAULT_TRANSITION_DURATION - 0.1
                          delay:0
         usingSpringWithDamping:DEFAULT_TRANSITION_SPRING_DAMPING
          initialSpringVelocity:DEFAULT_TRANSITION_INITIAL_VELOCITY
                        options:0
                     animations:^{
                        CGAffineTransform scaleTransform = CGAffineTransformScale(viewToHide.transform, 0.001, 0.001);
                        viewToHide.transform = scaleTransform;
                     }
                     completion:^(BOOL finished) {
                         !completionBlock ?: completionBlock();
    }];
}

@end
