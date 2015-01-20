//
//  AVTextFieldAdapter.h
//  Anniversary
//
//  Created by Alan Bouzek on 12/11/14.
//  Copyright (c) 2014 Alan Bouzek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol AVTextFieldAdapterDelegate;


@interface AVTextFieldAdapter : NSObject <UITextFieldDelegate>

@property (weak, nonatomic) id<AVTextFieldAdapterDelegate> delegate;

+(instancetype)textFieldAdapterWithDelegate:(id<AVTextFieldAdapterDelegate>)delegate;
-(void)setupTextField:(UITextField *)textField withPlaceholder:(NSString *)placeholder;

@end


@protocol AVTextFieldAdapterDelegate <NSObject>

-(void)textFieldAdapter:(AVTextFieldAdapter *)textFieldAdapter lastTextFieldDidReturn:(UITextField *)textField;

@end
