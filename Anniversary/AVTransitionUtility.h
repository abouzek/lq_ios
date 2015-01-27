//
//  AVTransitionUtility.h
//  Anniversary
//
//  Created by Alan Bouzek on 12/11/14.
//  Copyright (c) 2014 Alan Bouzek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AVConstants.h"

typedef NS_ENUM(NSInteger, SlideDirection) {
    Up,
    Down,
    Left,
    Right
};


@interface AVTransitionUtility : NSObject

+(void)slideTransitionFromView:(UIView *)fromView
                        toView:(UIView *)toView
                 withDirection:(SlideDirection)direction
           withCompletionBlock:(AVCompletionBlock)completion;
+(void)slideTransitionFromView:(UIView *)fromView
                        toView:(UIView *)toView
                 usingDuration:(CGFloat)duration
             springWithDamping:(CGFloat)springDamping
         initialSpringVelocity:(CGFloat)springVelocity
                       options:(UIViewAnimationOptions)options
                 withDirection:(SlideDirection)direction
           withCompletionBlock:(AVCompletionBlock)completion;

@end
