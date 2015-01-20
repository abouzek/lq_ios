//
//  AVConstants.h
//  Anniversary
//
//  Created by Alan Bouzek on 12/11/14.
//  Copyright (c) 2014 Alan Bouzek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^AVCompletionBlock)();
typedef void(^AVErrorBlock)(NSError *error);
typedef void(^AVResultBlock)(id result);
typedef void(^AVCellConfigureBlock)(id cell, id item);
typedef void(^AVSelectItemBlock)(id item);

// Network constants (should be externalized later)
extern NSString * const SERVER_BASE_URL;

// Transition constants
extern CGFloat DEFAULT_TRANSITION_DURATION;
extern CGFloat DEFAULT_TRANSITION_SPRING_DAMPING;
extern CGFloat DEFAULT_TRANSITION_INITIAL_VELOCITY;

// Login/Registration constants
extern NSString * const LOGIN_USERNAME_TEXT_FIELD_PLACEHOLDER;
extern NSString * const LOGIN_PASSWORD_TEXT_FIELD_PLACEHOLDER;
extern NSString * const LOGIN_CONFIRM_PASSWORD_TEXT_FIELD_PLACEHOLDER;
extern NSString * const LOGIN_LINK_CODE_TEXT_FIELD_PLACEHOLDER;

// Coupon constants
extern NSString * const COUPON_EDIT_NAME_TEXT_FIELD_PLACEHOLDER;
extern NSString * const COUPON_EDIT_NEW_TITLE_TEXT;
extern NSString * const COUPON_EDIT_EDIT_TITLE_TEXT;
extern int COUPON_MAX_COUNT;

// Enter code constants
extern NSString * const ENTER_CODE_TEXT_FIELD_PLACEHOLDER;
extern int ENTER_CODE_TEXT_FIELD_RIGHT_SPACE_CONSTRAINT_NO_BUTTON;
extern int ENTER_CODE_TEXT_FIELD_RIGHT_SPACE_CONSTRAINT_WITH_BUTTON;

// Keychain access constants
extern NSString * const KEYCHAIN_SERVICE_NAME;
extern NSString * const KEYCHAIN_ACCOUNT_NAME;
extern NSString * const USER_DEFAULTS_USER_KEY;

// NSNotification constants
extern NSString * const AUTO_LOGIN_NOTIFICATION;
extern NSString * const COLOR_SCHEME_CHANGED_NOTIFICATION;

// Color scheme constants
extern NSString * const COLOR_SCHEME_DEFAULTS_KEY;
