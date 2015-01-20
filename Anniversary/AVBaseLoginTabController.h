//
//  AVBaseLoginTabController.h
//  Anniversary
//
//  Created by Alan Bouzek on 12/11/14.
//  Copyright (c) 2014 Alan Bouzek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AVBaseLoginViewController.h"

typedef NS_ENUM(NSInteger, LoginTabIndex) {
    Register,
    Title,
    Login
};

@interface AVBaseLoginTabController : UITabBarController <AVBaseLoginViewControllerDelegate>
@end