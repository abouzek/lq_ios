//
//  AVModalViewController.h
//  Anniversary
//
//  Created by Alan Bouzek on 12/19/14.
//  Copyright (c) 2014 Alan Bouzek. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AVModalViewControllerDelegate;


@interface AVModalViewController : UIViewController

@property (weak, nonatomic) id<AVModalViewControllerDelegate> modalViewControllerDelegate;

@end


@protocol AVModalViewControllerDelegate <NSObject>

-(void)modalViewControllerShouldDismiss:(AVModalViewController *)modalViewController
                             withResult:(id)result;

@end
