//
//  AVColorUtility.h
//  Anniversary
//
//  Created by Alan Bouzek on 1/16/15.
//  Copyright (c) 2015 Alan Bouzek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ColorScheme) {
    Light,
    Dark
};

typedef NS_ENUM(NSInteger, ColorType) {
    BackgroundPrimary,
    BackgroundSecondary,
    TextPrimary,
    TextPlaceholder,
    TextFieldBorder,
    ButtonPrimary,
    ButtonSecondary
};

@interface AVColorUtility : NSObject

+(UIColor *)colorForType:(ColorType)colorType;

@end
