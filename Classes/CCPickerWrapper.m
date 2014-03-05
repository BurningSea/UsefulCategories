//
//  PickerWrapperView.m
//  Sea
//
//  Created by Sea on 11/25/13.
//  Copyright (c) 2013 Sea All rights reserved.
//

#import "CCPickerWrapper.h"
#import "UIViewAdditions.h"

@interface CCPickerWrapper ()

@property (nonatomic, strong) UIWindow *presentWindow;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, cc_weak) UIView *picker;

@end

@implementation CCPickerWrapper

- (id)initWithPicker:(UIView *)picker
{
    if (self = [super init]) {
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        _presentWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, screenSize.height)];
        _presentWindow.backgroundColor = RGB_A(0, 0);
        _presentWindow.windowLevel = UIWindowLevelNormal + 1;
        _backgroundView = [[UIView alloc] initWithFrame:_presentWindow.bounds];
        _backgroundView.backgroundColor = RGB_A(0, 0.8);
        _backgroundView.alpha = 0;
        [_presentWindow addSubview:_backgroundView];

        [_backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)]];

        _picker = picker;
    }
    return self;
}

- (void)show
{
    self.picker.top = self.presentWindow.bottom;
    [self.presentWindow addSubview:self.picker];
    self.presentWindow.hidden = NO;
    [UIView animateWithDuration:0.2121 animations:^{
        self.backgroundView.alpha = 1;
        self.picker.bottom = self.presentWindow.bottom;
    }];
}

- (void)hide
{
    [UIView animateWithDuration:0.2121 animations:^{
        self.backgroundView.alpha = 0;
        self.picker.top = self.presentWindow.bottom;
    } completion:^(BOOL finished) {
        self.presentWindow.hidden = YES;
        [self.delegate pickerDidHide];
    }];
}

@end
