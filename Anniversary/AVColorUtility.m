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
        case NavigationControllerBackground:
            return [self mediumBlueColor];
        case NavigationControllerButton:
            return [self whiteColor];
        case BackgroundPrimary:
            return [self lightGreenColor];
        case BackgroundSecondary:
            return [self lightGreenYellowColor];
        case TextPrimary:
            return [self whiteColor];
        case TextDeselected:
            return [[self whiteColor] colorWithAlphaComponent:0.5];
        case TextPlaceholder:
            return [self grayColor];
        case TextFieldBorder:
            return [self whiteColor];
        case ButtonPrimary:
            return [self lightMediumBlueColor];
        case ButtonPrimaryDeselected:
            return [self darkBlueColor];
        case ButtonSecondary:
            return [self lightBlueColor];
        case ButtonSecondaryDeselected:
            return [self lightPinkColor];
        case CellBackground:
            return [self darkestBlueColor];
        case CellSubtitle:
            return [self offWhiteColor];
        case CellSwipeBackground:
            return [self lightBlueColor];
    }
}

+(UIColor *)darkColorForType:(ColorType)colorType {
    if (colorType == BackgroundPrimary) {
        return [UIColor whiteColor];
    }
    return [[self lightColorForType:colorType] colorWithAlphaComponent:0.5];
}


#pragma mark - color definition methods

+(UIColor *)darkestBlueColor {
    return [UIColor colorWithRed:22/255.0 green:38/255.0 blue:59/255.0 alpha:1];
}

+(UIColor *)darkBlueColor {
    return [UIColor colorWithRed:25/255.0 green:52/255.0 blue:65/255.0 alpha:1];
}

+(UIColor *)mediumBlueColor {
    return [UIColor colorWithRed:39/255.0 green:82/255.0 blue:102/255.0 alpha:1];
}

+(UIColor *)lightMediumBlueColor {
    return [UIColor colorWithRed:39/255.0 green:82/255.0 blue:119/255.0 alpha:1];
}

+(UIColor *)lightBlueColor {
    return [UIColor colorWithRed:62/255.0 green:96/255.0 blue:111/255.0 alpha:1];
}

+(UIColor *)lightGreenColor {
    return [UIColor colorWithRed:129/255.0 green:154/255.0 blue:138/255.0 alpha:1];
}

+(UIColor *)lightGreenYellowColor {
    return [UIColor colorWithRed:209/255.0 green:219/255.0 blue:189/255.0 alpha:1];
}

+(UIColor *)offWhiteColor {
    return [UIColor colorWithRed:252/255.0 green:255/255.0 blue:245/255.0 alpha:1];
}

+(UIColor *)pinkColor {
    return [UIColor colorWithRed:252/255.0 green:136/255.0 blue:191/255.0 alpha:1];
}

+(UIColor *)lightPinkColor {
    return [UIColor colorWithRed:232/255.0 green:157/255.0 blue:206/255.0 alpha:1];
}

//+(UIColor *)lightBlueColor {
//    return [UIColor colorWithRed:61/255.0 green:194/255.0 blue:242/255.0 alpha:1];
//}

+(UIColor *)whiteColor {
    return [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
}

+(UIColor *)grayColor {
    return [UIColor colorWithRed:177/255.0 green:179/255.0 blue:190/255.0 alpha:1];
}

@end
