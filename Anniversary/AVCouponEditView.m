//
//  AVCouponsEditView.m
//  Anniversary
//
//  Created by Alan Bouzek on 1/22/15.
//  Copyright (c) 2015 Alan Bouzek. All rights reserved.
//

#import "AVCouponEditView.h"
#import "AVConstants.h"
#import "AVCouponEditViewModel.h"
#import "AVTextFieldAdapter.h"

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
    [self.textFieldAdapter setupTextField:self.nameTextField withPlaceholder:COUPON_EDIT_NAME_TEXT_FIELD_PLACEHOLDER];
}


#pragma mark - setter methods

-(void)setViewModel:(AVCouponEditViewModel *)viewModel {
    _viewModel = viewModel;
    self.nameTextField.text = viewModel.name;
    self.titleLabel.text = viewModel.id ? COUPON_EDIT_EDIT_TITLE_TEXT : COUPON_EDIT_NEW_TITLE_TEXT;
    self.titleLabel.attributedText = [[NSAttributedString alloc]
                                      initWithString:self.titleLabel.text
                                      attributes:@{NSKernAttributeName:@3}];
}


#pragma mark - utility methods

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
