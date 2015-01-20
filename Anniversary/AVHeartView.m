//
//  AVHeartView.m
//  Anniversary
//
//  Created by Alan Bouzek on 12/11/14.
//  Copyright (c) 2014 Alan Bouzek. All rights reserved.
//

#import "AVHeartView.h"

@interface AVHeartView ()

@property (strong, nonatomic) IBOutlet UIImageView *heartImageView;

@end


@implementation AVHeartView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self addSubview:[[NSBundle mainBundle]
                          loadNibNamed:NSStringFromClass([self class])
                          owner:self
                          options: nil][0]];
    }
    return self;
}

-(void)awakeFromNib {
    self.alpha = 0.05;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didBecomeActive)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    [self startAnimating];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)didBecomeActive {
    [self startAnimating];
}

-(void)startAnimating {
    [UIView animateWithDuration:1.5
                          delay:0
                        options:UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat
                     animations:^{
        self.alpha = 0.05;
        self.alpha = 0.3;
    } completion:nil];
}

@end
