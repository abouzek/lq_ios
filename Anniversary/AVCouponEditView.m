//
//  AVCouponAddView.m
//  Anniversary
//
//  Created by Alan Bouzek on 12/17/14.
//  Copyright (c) 2014 Alan Bouzek. All rights reserved.
//

#import "AVCouponEditView.h"
#import "AVTextFieldAdapter.h"
#import "AVConstants.h"

@interface AVCouponEditView ()

@property (strong, nonatomic) AVTextFieldAdapter *textFieldAdapter;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UIButton *cancelButton;
@property (strong, nonatomic) IBOutlet UIButton *saveButton;

@end


@implementation AVCouponEditView

-(void)awakeFromNib {
    self.textFieldAdapter = [AVTextFieldAdapter new];
    [self.textFieldAdapter setupTextField:self.nameTextField
                          withPlaceholder:COUPON_EDIT_NAME_TEXT_FIELD_PLACEHOLDER];
}


#pragma mark - setter methods

-(void)setViewModel:(AVCouponEditViewModel *)viewModel {
    _viewModel = viewModel;
    self.nameTextField.text = viewModel.name;
    self.titleLabel.text = viewModel.id ? COUPON_EDIT_EDIT_TITLE_TEXT : COUPON_EDIT_NEW_TITLE_TEXT;
}


#pragma mark - utility methods

-(void)setupSize {
    CGRect screenRect = [UIScreen mainScreen].bounds;
    CGRect newFrame = self.frame;
    newFrame.size = CGSizeMake(screenRect.size.width * 0.75, screenRect.size.height * 0.65);
    self.frame = newFrame;
    self.center = CGPointMake(CGRectGetMidX(screenRect), CGRectGetMidY(screenRect));
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
}

-(BOOL)fieldsAreValid {
    return self.nameTextField.text.length > 0;
}


#pragma mark - IBAction methods

- (IBAction)nameTextFieldDidChange:(UITextField *)sender {
    self.viewModel.name = sender.text;
}

- (IBAction)saveButtonPressed:(UIButton *)sender {
    if ([self fieldsAreValid]) {
        [self.delegate couponEditView:self didPressSaveButton:sender];
    }
    else {
        // Show the user what they need to do pass validation
    }
}

- (IBAction)cancelButtonPressed:(UIButton *)sender {
    [self.delegate couponEditView:self didPressCancelButton:sender];
}

@end
