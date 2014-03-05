//
//  AlertWrapper.m
//  Sea
//
//  Created by Sea on 1/23/14.
//  Copyright (c) 2014 Sea All rights reserved.
//

#import "CCAlertWrapper.h"

#define ANIMATION_LONG_DURATION 0.4
#define ANIMATION_SHORT_DURATION 0.2121

@interface CCAlertWrapper ()

@property AlertAnimationType animationType;
@property (nonatomic, cc_weak) UIView *alert;
@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) UIView *backgroundView;

@end

@implementation CCAlertWrapper

- (instancetype)initWithAlert:(UIView *)alert
{
    return [self initWithAlert:alert animationType:AlertAnimationTypeNormal];
}

- (instancetype)initWithAlert:(UIView *)alert animationType:(AlertAnimationType)animationType
{
    if (self = [super init]) {
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        _window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, screenSize.height)];
        _window.backgroundColor = RGB_A(0, 0);
        _window.windowLevel = UIWindowLevelNormal + 1;
        _backgroundView = [[UIView alloc] initWithFrame:_window.bounds];
        _backgroundView.backgroundColor = RGB_A(0, 0.8);
        _backgroundView.alpha = 0;
        [_window addSubview:_backgroundView];

        _alert = alert;
        _animationType = animationType;
    }
    return self;
}

#pragma mark - Show

- (void)show
{
    [self.window addSubview:self.alert];
    self.window.hidden = NO;
    [UIView animateWithDuration:ANIMATION_LONG_DURATION animations:^{
        self.backgroundView.alpha = 1;
    }];
    switch (self.animationType) {
        case AlertAnimationTypeScale:
            [self showWithScaleAniamtion];
            break;
        case AlertAnimationTypeNormal:
        case AlertAnimationTypeRotate:
        default:
            [self showWithNormalAnimation];
    }
}

- (void)showWithNormalAnimation
{
    self.alert.bottom = self.window.top;
    [UIView animateWithDuration:ANIMATION_LONG_DURATION animations:^{
        self.alert.center = self.window.center;
    }];
}

- (void)showWithScaleAniamtion
{
    self.alert.center = self.window.center;
    self.alert.transform = CGAffineTransformMakeScale(0.1, 0.1);
    [UIView animateWithDuration:0.75 * ANIMATION_LONG_DURATION animations:^{
        self.alert.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25 * ANIMATION_LONG_DURATION animations:^{
            self.alert.transform = CGAffineTransformIdentity;
        }];
    }];
}

#pragma mark - Hide

- (void)hide
{
    [UIView animateWithDuration:ANIMATION_LONG_DURATION animations:^{
        self.backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        self.window.hidden = YES;
    }];

    switch (self.animationType) {
        case AlertAnimationTypeRotate:
            [self hideWithRotateAnimation];
            break;
        case AlertAnimationTypeScale:
            [self hideWithScaleAniamtion];
            break;
        case AlertAnimationTypeNormal:
            [self hideWithNormalAnimation];
        default:
            break;
    }
}

- (void)hideWithNormalAnimation
{
    [UIView animateWithDuration:ANIMATION_LONG_DURATION animations:^{
        self.alert.top = self.window.bottom;
    }];
}

- (void)hideWithRotateAnimation
{
    [UIView animateWithDuration:ANIMATION_LONG_DURATION animations:^{
        self.alert.transform = CGAffineTransformMakeRotation(arc4random() % 2 == 0 ? M_PI / 12:-M_PI / 12);
        self.alert.top = self.window.bottom;
    }];
}

- (void)hideWithScaleAniamtion
{
    [UIView animateWithDuration:ANIMATION_SHORT_DURATION delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.alert.transform = CGAffineTransformMakeScale(0, 0);
    } completion:nil];
}

@end
