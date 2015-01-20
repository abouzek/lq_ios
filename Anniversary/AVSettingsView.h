//
//  AVSettingsView.h
//  Anniversary
//
//  Created by Alan Bouzek on 12/19/14.
//  Copyright (c) 2014 Alan Bouzek. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AVSettingsViewDelegate;


@interface AVSettingsView : UIView

@property (weak, nonatomic) id<AVSettingsViewDelegate> delegate;

-(void)setupSize;

@end


@protocol AVSettingsViewDelegate <NSObject>

-(void)settingsViewDidPressDoneButton:(AVSettingsView *)settingsView;

@end
