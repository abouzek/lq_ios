//
//  AVCounterView.h
//  Anniversary
//
//  Created by Alan Bouzek on 12/18/14.
//  Copyright (c) 2014 Alan Bouzek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AVCounterViewController.h"

@protocol AVCounterViewDelegate;


@interface AVCounterView : UIView <AVCounterViewControllerDelegate>

@property (weak, nonatomic) id<AVCounterViewDelegate> delegate;

@end


@protocol AVCounterViewDelegate <NSObject>

-(void)counterViewDidIncrement:(AVCounterView *)counterView;
-(void)counterViewDidDecrement:(AVCounterView *)counterView;

@end