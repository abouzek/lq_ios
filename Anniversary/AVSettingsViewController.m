//
//  AVSettingsViewController.m
//  Anniversary
//
//  Created by Alan Bouzek on 12/19/14.
//  Copyright (c) 2014 Alan Bouzek. All rights reserved.
//

#import "AVSettingsViewController.h"
#import "AVSettingsView.h"

@interface AVSettingsViewController () <AVSettingsViewDelegate>

@property (strong, nonatomic) IBOutlet AVSettingsView *settingsView;

@end


@implementation AVSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.settingsView.delegate = self;
    [self.settingsView setupSize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - AVSettingsViewDelegate methods

-(void)settingsViewDidPressDoneButton:(AVSettingsView *)settingsView {
    [self.modalViewControllerDelegate modalViewControllerShouldDismiss:self withResult:nil];
}

@end
