//
//  AVSegmentedContainerView.m
//  Anniversary
//
//  Created by Alan Bouzek on 1/22/15.
//  Copyright (c) 2015 Alan Bouzek. All rights reserved.
//

#import "AVSegmentedContainerView.h"
#import "AVColorUtility.h"
#import "AVSegmentedContainerViewController.h"
#import "AVShadowView.h"

@interface AVSegmentedContainerView ()

@property (strong, nonatomic) IBOutlet AVShadowView *segmentedControlView;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (strong, nonatomic) IBOutlet UIView *containerView;

@end


@implementation AVSegmentedContainerView

-(void)awakeFromNib {
    [self setupSegmentedControlStyle];
}

#pragma mark - setup methods

-(void)setupSegmentedControlStyle {
    self.segmentedControl.layer.cornerRadius = 0;
    self.segmentedControl.layer.borderWidth = 0;
    self.segmentedControl.layer.borderColor = [[UIColor clearColor] CGColor];
    
    UIFont *font = [UIFont fontWithName:DEFAULT_FONT size:16];
    NSNumber *kern = @3;
    [self.segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[[UIColor whiteColor] colorWithAlphaComponent:0.5],
                                                    NSFontAttributeName:font, NSKernAttributeName:kern}
                                         forState:UIControlStateNormal];
    [self.segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                    NSFontAttributeName:font, NSKernAttributeName:kern}
                                         forState:UIControlStateSelected];
}

-(void)setupSegmentedControlWithViewControllers:(NSArray *)viewControllers {
    [self.segmentedControl removeAllSegments];
    for (int i = 0; i < viewControllers.count; ++i) {
        id<AVSegmentedInternalViewController> viewController = viewControllers[i];
        [self.segmentedControl insertSegmentWithTitle:[viewController titleForSegment]
                                              atIndex:i
                                             animated:NO];
    }
    [self changeSegmentedControlColors];
    self.segmentedControl.selectedSegmentIndex = 0;
    
    UIViewController *firstViewController = viewControllers.firstObject;
    [self.containerView addSubview:firstViewController.view];
    firstViewController.view.frame = self.containerView.bounds;
}


#pragma mark - transition methods

-(void)changeSegmentedControlColors {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIColor *selectedColor = [AVColorUtility colorForType:ButtonPrimary];
        UIColor *deselectedColor = [AVColorUtility colorForType:ButtonPrimaryDeselected];
        for (id subview in self.segmentedControl.subviews) {
            if ([subview respondsToSelector:@selector(isSelected)]) {
                if ([subview isSelected]) {
                    [subview setTintColor:selectedColor];
                    [subview setBackgroundColor:selectedColor];
                }
                else {
                    [subview setTintColor:deselectedColor];
                    [subview setBackgroundColor:deselectedColor];
                }
            }
        }
    });
}


-(void)transitionFromView:(UIView *)fromView
                   toView:(UIView *)toView
            withDirection:(SlideDirection)direction
      withCompletionBlock:(AVCompletionBlock)completionBlock {
    self.segmentedControl.userInteractionEnabled = NO;
    
    [AVTransitionUtility slideTransitionFromView:fromView
                                          toView:toView
                                   usingDuration:0.35
                               springWithDamping:1
                           initialSpringVelocity:1
                                         options:0
                                   withDirection:direction
                             withCompletionBlock:^{
                                 
                                 toView.frame = self.containerView.bounds;
                                 
                                 self.segmentedControl.userInteractionEnabled = YES;
                                 !completionBlock ?: completionBlock();
                                 
                             }
     ];
}


#pragma mark - IBAction methods

- (IBAction)segmentedControlValueChanged:(UISegmentedControl *)sender {
    [self changeSegmentedControlColors];
    [self.delegate segmentedContainerView:self
                         didSwitchToIndex:sender.selectedSegmentIndex];
}

@end
