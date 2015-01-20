//
//  AVScrollViewKeyboardHelper.m
//  Anniversary
//
//  Created by Alan Bouzek on 1/13/15.
//  Copyright (c) 2015 Alan Bouzek. All rights reserved.
//

#import "AVScrollViewKeyboardAdapter.h"

@interface AVScrollViewKeyboardAdapter ()

@property (weak, nonatomic) UIScrollView *scrollView;

@end


@implementation AVScrollViewKeyboardAdapter

+(instancetype)scrollViewKeyboardAdapterWithScrollView:(UIScrollView *)scrollView {
    AVScrollViewKeyboardAdapter *adapter = [AVScrollViewKeyboardAdapter new];
    adapter.scrollView = scrollView;
    [adapter setupNotifications];
    return adapter;
}

-(void)setupNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - utility methods

-(CGFloat)overlapForKeyboardHeight:(CGFloat)keyboardHeight {
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    CGRect scrollViewBounds = self.scrollView.bounds;
    
    // The top of the keyboard's bounds is the screen height - the keyboard height
    CGFloat keyboardTop = screenBounds.size.height - keyboardHeight;
    
    // The bottom of the scroll view's bounds is the bounds top + the scroll view's height
    CGFloat scrollViewBottom = scrollViewBounds.origin.y + scrollViewBounds.size.height;
    
    // The overlap is the bottom of the scroll view bounds minus the top of the keyboard bounds with some padding
    return (scrollViewBottom + 30) - keyboardTop;
}


#pragma mark - keyboard hide/show methods

-(void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary* info = [notification userInfo];
    CGFloat keyboardHeight = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height;
    
    CGFloat overlap = [self overlapForKeyboardHeight:keyboardHeight];
    if (overlap < 0) return;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]];
    [UIView setAnimationCurve:[notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue]];
    
    UIEdgeInsets insets = self.scrollView.contentInset;
    insets.bottom += overlap;
    
    [self.scrollView setNeedsLayout];
    self.scrollView.contentInset = insets;
    self.scrollView.scrollIndicatorInsets = insets;
    [self.scrollView layoutIfNeeded];
    
    [UIView commitAnimations];
}

-(void)keyboardWillHide:(NSNotification *)notification {
    NSDictionary* info = [notification userInfo];
    CGFloat keyboardHeight = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height;
    CGFloat overlap = [self overlapForKeyboardHeight:keyboardHeight];
    
    if (overlap < 0) return;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]];
    [UIView setAnimationCurve:[notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue]];
    
    UIEdgeInsets insets = self.scrollView.contentInset;
    insets.bottom -= overlap;
    
    [self.scrollView setNeedsLayout];
    self.scrollView.contentInset = insets;
    self.scrollView.scrollIndicatorInsets = insets;
    [self.scrollView layoutIfNeeded];
    
    [UIView commitAnimations];
}

@end
