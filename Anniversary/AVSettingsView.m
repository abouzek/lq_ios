//
//  AVSettingsView.m
//  Anniversary
//
//  Created by Alan Bouzek on 12/19/14.
//  Copyright (c) 2014 Alan Bouzek. All rights reserved.
//

#import "AVSettingsView.h"
#import "AVUserManager.h"

@interface AVSettingsView ()

@property (strong, nonatomic) IBOutlet UIButton *saveButton;
@property (strong, nonatomic) IBOutlet UISwitch *colorSchemeSwitch;

@end


@implementation AVSettingsView

-(void)setupSize {
    CGRect screenRect = [UIScreen mainScreen].bounds;
    CGRect newFrame = self.frame;
    newFrame.size = CGSizeMake(screenRect.size.width * 0.75, screenRect.size.height * 0.65);
    self.frame = newFrame;
    self.center = CGPointMake(CGRectGetMidX(screenRect), CGRectGetMidY(screenRect));
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
}


#pragma mark - IBAction methods

- (IBAction)saveButtonPressed:(UIButton *)sender {
    [self.delegate settingsViewDidPressDoneButton:self];
}

- (IBAction)colorSchemeSwitchChanged:(UISwitch *)sender {
    [AVUserManager manager].colorScheme = (NSInteger)sender.isOn;
}

@end
