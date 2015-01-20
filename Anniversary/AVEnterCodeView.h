//
//  AVEnterCodeView.h
//  Anniversary
//
//  Created by Alan Bouzek on 12/22/14.
//  Copyright (c) 2014 Alan Bouzek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AVEnterCodeViewModel.h"
#import "AVConstants.h"

@protocol AVEnterCodeViewDelegate;


@interface AVEnterCodeView : UIView

@property (weak, nonatomic) id<AVEnterCodeViewDelegate> delegate;
@property (strong, nonatomic) AVEnterCodeViewModel *viewModel;

-(void)animateForSuccessWithCompletionBlock:(AVCompletionBlock)completionBlock;
-(void)animateForFailureWithCompletionBlock:(AVCompletionBlock)completionBlock;

@end


@protocol AVEnterCodeViewDelegate <NSObject>

-(void)enterCodeView:(AVEnterCodeView *)enterCodeView
      didPressButton:(UIButton *)button;

@end
