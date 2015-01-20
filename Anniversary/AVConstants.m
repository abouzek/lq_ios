//
//  AVConstants.m
//  Anniversary
//
//  Created by Alan Bouzek on 12/11/14.
//  Copyright (c) 2014 Alan Bouzek. All rights reserved.
//

#import "AVConstants.h"

// Network constants
NSString * const SERVER_BASE_URL = @"http://192.168.1.70:5000/api/";

// Transition constants
CGFloat DEFAULT_TRANSITION_DURATION = 0.35;
CGFloat DEFAULT_TRANSITION_SPRING_DAMPING = 0.7;
CGFloat DEFAULT_TRANSITION_INITIAL_VELOCITY = 0.9;

// Login/Registration constants
NSString * const LOGIN_USERNAME_TEXT_FIELD_PLACEHOLDER = @"Username";
NSString * const LOGIN_PASSWORD_TEXT_FIELD_PLACEHOLDER = @"Password";
NSString * const LOGIN_CONFIRM_PASSWORD_TEXT_FIELD_PLACEHOLDER = @"Confirm Password";
NSString * const LOGIN_LINK_CODE_TEXT_FIELD_PLACEHOLDER = @"Link Code";

// Coupon constants
NSString * const COUPON_EDIT_NAME_TEXT_FIELD_PLACEHOLDER = @"Name";
NSString * const COUPON_EDIT_NEW_TITLE_TEXT = @"NEW";
NSString * const COUPON_EDIT_EDIT_TITLE_TEXT = @"EDIT";
int COUPON_MAX_COUNT = 10;

// Enter code constants
NSString * const ENTER_CODE_TEXT_FIELD_PLACEHOLDER = @"Link Code";
int ENTER_CODE_TEXT_FIELD_RIGHT_SPACE_CONSTRAINT_NO_BUTTON = 15;
int ENTER_CODE_TEXT_FIELD_RIGHT_SPACE_CONSTRAINT_WITH_BUTTON = 77;

// Keychain access constants
NSString * const KEYCHAIN_SERVICE_NAME = @"com.abouzek.Anniversary";
NSString * const KEYCHAIN_ACCOUNT_NAME = @"com.abouzek.Anniversary.savedToken";

// NSNotification constants
NSString * const AUTO_LOGIN_NOTIFICATION = @"AutoLoginNotification";
NSString * const COLOR_SCHEME_CHANGED_NOTIFICATION = @"ColorSchemeChangedNotification";

// Color scheme constants
NSString * const COLOR_SCHEME_DEFAULTS_KEY = @"AnniversaryColorScheme";
