//
//  AVTextFieldAdapter.m
//  Anniversary
//
//  Created by Alan Bouzek on 12/11/14.
//  Copyright (c) 2014 Alan Bouzek. All rights reserved.
//

#import "AVTextFieldAdapter.h"
#import "AVConstants.h"

// Constants
int const MAX_TEXT_LENGTH = 15;
CGFloat const TEXTFIELD_BORDER_WIDTH = 1.0;
CGFloat const TEXTFIELD_CORNER_RADIUS = 1.0;

@interface AVTextFieldAdapter ()

@property (strong, nonatomic) NSMutableArray *textFields;

@end


@implementation AVTextFieldAdapter

-(instancetype)init {
    if (self = [super init]) {
        self.textFields = [NSMutableArray new];
    }
    return self;
}

+(instancetype)textFieldAdapterWithDelegate:(id<AVTextFieldAdapterDelegate>)delegate {
    AVTextFieldAdapter *adapter = [AVTextFieldAdapter new];
    adapter.delegate = delegate;
    return adapter;
}


#pragma mark - setup methods

-(void)setupTextField:(UITextField *)textField withPlaceholder:(NSString *)placeholder {
    [self setPlaceholder:placeholder forTextField:textField];
    textField.tintColor = [UIColor whiteColor];
    textField.layer.borderColor = [[UIColor whiteColor] CGColor];
    textField.layer.cornerRadius = TEXTFIELD_CORNER_RADIUS;
    textField.layer.borderWidth = TEXTFIELD_BORDER_WIDTH;
    textField.font = [UIFont fontWithName:TEXT_FIELD_FONT size:textField.font.pointSize];
    textField.delegate = self;
    
    [self.textFields addObject:textField];
}

-(void)setPlaceholder:(NSString *)placeholder forTextField:(UITextField *)textField {
    NSDictionary *attributes = @{NSForegroundColorAttributeName : [[UIColor whiteColor] colorWithAlphaComponent:0.85],
                                 NSFontAttributeName : [UIFont fontWithName:TEXT_FIELD_FONT size:textField.font.pointSize]};
    textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:attributes];
}


#pragma mark - utility methods

-(UITextField *)textFieldAfterTextField:(UITextField *)currentTextField {
    // Loop through text fields in order until the current is found
    for (int i = 0; i < self.textFields.count - 1; ++i) {
        UITextField *textField = self.textFields[i];
        if (currentTextField == textField) {
            // When the current text field is found, return the one after it
            return self.textFields[i + 1];
        }
    }
    return nil;
}


#pragma mark - UITextFieldDelegate methods

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return !(textField.text.length > MAX_TEXT_LENGTH && string.length > range.length);
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    UITextField *nextTextField = [self textFieldAfterTextField:textField];
    if (!nextTextField) {
        [textField resignFirstResponder];
        [self.delegate textFieldAdapter:self lastTextFieldDidReturn:textField];
    }
    else {
        [nextTextField becomeFirstResponder];
    }
    return YES;
}


@end
