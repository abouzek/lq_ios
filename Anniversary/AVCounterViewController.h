//
//  AVCounterViewController.h
//  Anniversary
//
//  Created by Alan Bouzek on 12/19/14.
//  Copyright (c) 2014 Alan Bouzek. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AVCounterViewControllerDelegate;


@interface AVCounterViewController : UIViewController

@property (nonatomic) NSInteger count;
@property (weak, nonatomic) id<AVCounterViewControllerDelegate> delegate;

@end


@protocol AVCounterViewControllerDelegate <NSObject>

-(void)counterViewController:(AVCounterViewController *)counterViewController
            didUpdateToCount:(NSInteger)count;

@end
