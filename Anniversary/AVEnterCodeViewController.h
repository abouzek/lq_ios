//
//  AVEnterCodeViewController.h
//  Anniversary
//
//  Created by Alan Bouzek on 12/22/14.
//  Copyright (c) 2014 Alan Bouzek. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AVEnterCodeViewControllerDelegate;


@interface AVEnterCodeViewController : UIViewController

@property (weak, nonatomic) id<AVEnterCodeViewControllerDelegate> delegate;

@end


@protocol AVEnterCodeViewControllerDelegate <NSObject>

-(void)enterCodeViewControllerDidCompleteLinking:(AVEnterCodeViewController *)enterCodeViewController;

@end
