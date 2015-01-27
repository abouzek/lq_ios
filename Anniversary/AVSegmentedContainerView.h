//
//  AVSegmentedContainerView.h
//  Anniversary
//
//  Created by Alan Bouzek on 1/22/15.
//  Copyright (c) 2015 Alan Bouzek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AVTransitionUtility.h"
#import "AVConstants.h"

@protocol AVSegmentedContainerViewDelegate;


@interface AVSegmentedContainerView : UIView

@property (weak, nonatomic) id<AVSegmentedContainerViewDelegate> delegate;

-(void)setupSegmentedControlWithViewControllers:(NSArray *)viewControllers;
-(void)transitionFromView:(UIView *)fromView
                   toView:(UIView *)toView
            withDirection:(SlideDirection)direction
      withCompletionBlock:(AVCompletionBlock)completionBlock;

@end


@protocol AVSegmentedContainerViewDelegate <NSObject>

-(void)segmentedContainerView:(AVSegmentedContainerView *)segmentedContainerView
             didSwitchToIndex:(NSUInteger)index;

@end
