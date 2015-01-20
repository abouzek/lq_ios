//
//  AVMenuViewController.h
//  Anniversary
//
//  Created by Alan Bouzek on 12/11/14.
//  Copyright (c) 2014 Alan Bouzek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AVHeartView.h"
#import "AVConstants.h"

@interface AVMenuViewController : UIViewController

@property (strong, nonatomic) IBOutlet AVHeartView *heartView;
@property (strong, nonatomic) IBOutlet UIView *topContainerView;
@property (strong, nonatomic) IBOutlet UIView *bottomContainerView;

@end
