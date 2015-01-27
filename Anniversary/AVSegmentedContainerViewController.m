//
//  AVSegmentedViewController.m
//  Anniversary
//
//  Created by Alan Bouzek on 1/21/15.
//  Copyright (c) 2015 Alan Bouzek. All rights reserved.
//

#import "AVSegmentedContainerViewController.h"
#import "AVConstants.h"
#import "AVViewControllerUtility.h"
#import "AVTransitionUtility.h"
#import "AVSegmentedContainerView.h"

@interface AVSegmentedContainerViewController () <AVSegmentedContainerViewDelegate>

@property (nonatomic) NSUInteger lastIndex;
@property (strong, nonatomic) NSArray *viewControllers;

@property (strong, nonatomic) IBOutlet AVSegmentedContainerView *segmentedContainerView;

@end


@implementation AVSegmentedContainerViewController

+(instancetype)segmentedContainerViewControllerWithViewControllers:(NSArray *)viewControllers {
    if (!viewControllers || !viewControllers.count) {
        [NSException raise:NSInternalInconsistencyException format:@"AVSegmentedContainerViewController must be initialized with a non-empty array of UIViewControllers."];
    }
    for (UIViewController *viewController in viewControllers) {
        if (![viewController conformsToProtocol:@protocol(AVSegmentedInternalViewController)]) {
            [NSException raise:NSInternalInconsistencyException
                        format:@"AVSegmentedContainerViewController's internal view controllers must implement the AVSegmentedInternalViewController protocol."];
        }
    }
    
    AVSegmentedContainerViewController *container = [[AVSegmentedContainerViewController alloc] initWithNibName:nil
                                                                                                         bundle:nil];
    container.viewControllers = viewControllers;
    return container;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = COUPON_NAVIGATION_BAR_TITLE;
    
    self.lastIndex = 0;
    self.segmentedContainerView.delegate = self;
    [self.segmentedContainerView setupSegmentedControlWithViewControllers:self.viewControllers];
    
    [self addChildViewController:self.viewControllers.firstObject];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - AVSegmentedContainerViewDelegate methods

-(void)segmentedContainerView:(AVSegmentedContainerView *)segmentedContainerView
             didSwitchToIndex:(NSUInteger)index {
    UIViewController *fromViewController = self.viewControllers[self.lastIndex];
    UIViewController *toViewController = self.viewControllers[index];
    SlideDirection direction = self.lastIndex < index ? Left : Right;
    
    [fromViewController removeFromParentViewController];
    [self addChildViewController:toViewController];
    
    [self.segmentedContainerView transitionFromView:fromViewController.view
                                             toView:toViewController.view
                                      withDirection:direction
                                withCompletionBlock:^{
                                    
                                    self.lastIndex = index;
                                    
                                }
     ];
}

@end
