//
//  AVCouponAddView.h
//  Anniversary
//
//  Created by Alan Bouzek on 12/17/14.
//  Copyright (c) 2014 Alan Bouzek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AVCouponEditViewModel.h"

@protocol AVCouponEditViewDelegate;


@interface AVCouponEditView : UIView

@property (weak, nonatomic) id<AVCouponEditViewDelegate> delegate;
@property (strong, nonatomic) AVCouponEditViewModel *viewModel;

@property (strong, nonatomic) IBOutlet UIView *counterContainerView;


-(void)setupSize;

@end


@protocol AVCouponEditViewDelegate <NSObject>

-(void)couponEditView:(AVCouponEditView *)couponEditView
    didPressSaveButton:(UIButton *)saveButton;
-(void)couponEditView:(AVCouponEditView *)couponEditView
    didPressCancelButton:(UIButton *)cancelButton;

@end

