//
//  AVViewControllerUtility.h
//  Anniversary
//
//  Created by Alan Bouzek on 12/11/14.
//  Copyright (c) 2014 Alan Bouzek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AVViewControllerUtility : NSObject

+(UIViewController *)viewControllerWithIdentifier:(NSString *)identifier
                           fromStoryboardWithName:(NSString *)storyboardName;

+(UIView *)screenshotFromView:(UIView *)view;

@end
