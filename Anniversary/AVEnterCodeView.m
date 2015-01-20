//
//  AVEnterCodeView.m
//  Anniversary
//
//  Created by Alan Bouzek on 12/22/14.
//  Copyright (c) 2014 Alan Bouzek. All rights reserved.
//

#import "AVEnterCodeView.h"
#import "AVTextFieldAdapter.h"
#import "AVConstants.h"
#import <Pop.h>

@interface AVEnterCodeView ()

@property (strong, nonatomic) AVTextFieldAdapter *textFieldAdapter;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *codeTextFieldRightSpaceConstraint;
@property (strong, nonatomic) IBOutlet UITextField *codeTextField;
@property (strong, nonatomic) IBOutlet UIButton *linkButton;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *checkImageView;

@end


@implementation AVEnterCodeView

-(void)awakeFromNib {
    self.textFieldAdapter = [AVTextFieldAdapter new];
    [self.textFieldAdapter setupTextField:self.codeTextField withPlaceholder:ENTER_CODE_TEXT_FIELD_PLACEHOLDER];
    
    self.linkButton.alpha = 0;
    self.codeTextFieldRightSpaceConstraint.constant = ENTER_CODE_TEXT_FIELD_RIGHT_SPACE_CONSTRAINT_NO_BUTTON;
    [self.codeTextField layoutIfNeeded];
}


#pragma mark - utility methods

-(void)showLinkButton {
    [UIView animateWithDuration:0.1 animations:^{
        self.linkButton.alpha = 1;
        self.codeTextFieldRightSpaceConstraint.constant = ENTER_CODE_TEXT_FIELD_RIGHT_SPACE_CONSTRAINT_WITH_BUTTON;
        [self.codeTextField layoutIfNeeded];
    }];
}

-(void)hideLinkButton {
    self.linkButton.alpha = 0;
    [UIView animateWithDuration:0.1 animations:^{
        self.codeTextFieldRightSpaceConstraint.constant = ENTER_CODE_TEXT_FIELD_RIGHT_SPACE_CONSTRAINT_NO_BUTTON;
        [self.codeTextField layoutIfNeeded];
    }];
}

-(void)animateForSuccessWithCompletionBlock:(AVCompletionBlock)completionBlock {
    [UIView animateWithDuration:0.1 animations:^{
        self.codeTextField.alpha = 0;
        self.linkButton.alpha = 0;
        self.titleLabel.alpha = 0;
    } completion:^(BOOL finished) {
        self.checkImageView.alpha = 1;
        
        POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBounds];
        animation.springBounciness = 8;
        animation.springSpeed = 8;
        
        CGRect startRect = self.checkImageView.frame;
        startRect.size = CGSizeMake(0.1, 0.1);
        animation.fromValue = [NSValue valueWithCGRect:startRect];

        CGRect endRect = self.checkImageView.frame;
        animation.toValue = [NSValue valueWithCGRect:endRect];
        
        animation.completionBlock = ^(POPAnimation *anim, BOOL finished) {
            !completionBlock ?: completionBlock();
        };
        [self.checkImageView.layer pop_addAnimation:animation forKey:@"scale"];
    }];
}

-(void)animateForFailureWithCompletionBlock:(AVCompletionBlock)completionBlock {
    // Add a failure animation
    !completionBlock ?: completionBlock();
}


#pragma mark - IBAction methods

- (IBAction)linkButtonPressed:(UIButton *)sender {
    if (self.codeTextField.text.length) {
        [self.delegate enterCodeView:self didPressButton:sender];
    }
}

- (IBAction)codeTextFieldTextChanged:(UITextField *)sender {
    self.viewModel.linkCode = sender.text;
    
    if (sender.text.length && !self.linkButton.alpha) {
        [self showLinkButton];
    }
    else if (!sender.text.length && self.linkButton.alpha) {
        [self hideLinkButton];
    }
}

@end
