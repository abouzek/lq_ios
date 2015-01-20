//
//  AVColorUtility.m
//  Anniversary
//
//  Created by Alan Bouzek on 1/16/15.
//  Copyright (c) 2015 Alan Bouzek. All rights reserved.
//

#import "AVColorUtility.h"
#import "AVUserManager.h"

@implementation AVColorUtility

+(UIColor *)colorForType:(ColorType)colorType {
    switch ([AVUserManager manager].colorScheme) {
        case Light:
            return [self lightColorForType:colorType];
        case Dark:
            return [self darkColorForType:colorType];
    }
}

+(UIColor *)lightColorForType:(ColorType)colorType {
    switch (colorType) {
        case BackgroundPrimary:
            return [self pinkColor];
        case BackgroundSecondary:
            return [self lightPinkColor];
        case TextPrimary:
            return [self whiteColor];
        case TextPlaceholder:
            return [self grayColor];
        case TextFieldBorder:
            return [self whiteColor];
        case ButtonPrimary:
            return [self lightBlueColor];
        case ButtonSecondary:
            return [self lightPinkColor];
    }
}

+(UIColor *)darkColorForType:(ColorType)colorType {
    if (colorType == BackgroundPrimary) {
        return [UIColor whiteColor];
    }
    return [[self lightColorForType:colorType] colorWithAlphaComponent:0.5];
}


#pragma mark - color definition methods

+(UIColor *)pinkColor {
    return [UIColor colorWithRed:252/255.0 green:136/255.0 blue:191/255.0 alpha:1];
}

+(UIColor *)lightPinkColor {
    return [UIColor colorWithRed:232/255.0 green:157/255.0 blue:206/255.0 alpha:1];
}

+(UIColor *)lightBlueColor {
    return [UIColor colorWithRed:61/255.0 green:194/255.0 blue:242/255.0 alpha:1];
}

+(UIColor *)whiteColor {
    return [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
}

+(UIColor *)grayColor {
    return [UIColor colorWithRed:177/255.0 green:179/255.0 blue:190/255.0 alpha:1];
}

@end
