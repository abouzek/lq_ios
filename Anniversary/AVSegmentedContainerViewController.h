//
//  AVSegmentedViewController.h
//  Anniversary
//
//  Created by Alan Bouzek on 1/21/15.
//  Copyright (c) 2015 Alan Bouzek. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AVSegmentedInternalViewController <NSObject>

-(NSString *)titleForSegment;

@end


@interface AVSegmentedContainerViewController : UIViewController

+(instancetype)segmentedContainerViewControllerWithViewControllers:(NSArray *)viewControllers;

@end
