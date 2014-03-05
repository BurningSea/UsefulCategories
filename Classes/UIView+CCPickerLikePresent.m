//
//  UIView+PickerLikePresent.m
//  Sea
//
//  Created by Sea on 1/24/14.
//  Copyright (c) 2014 Sea All rights reserved.
//

#import "UIView+CCPickerLikePresent.h"
#import "CCPickerWrapper.h"
#import <objc/runtime.h>

@interface UIView (Private)<CCPickerWrapperDelegate>

@property (nonatomic, strong) CCPickerWrapper *wrapper;
@property (nonatomic, copy) PickerDidHide callback;

@end

@implementation UIView (Private)

@dynamic wrapper;
static void *wrapperKey;
- (void)setWrapper:(CCPickerWrapper *)wrapper
{
    objc_setAssociatedObject(self, &wrapperKey, wrapper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CCPickerWrapper *)wrapper
{
    return objc_getAssociatedObject(self, &wrapperKey);
}

@dynamic callback;
static void *callbackKey;
- (void)setCallback:(PickerDidHide)callback
{
    objc_setAssociatedObject(self, &callbackKey, callback, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (PickerDidHide)callback
{
    return objc_getAssociatedObject(self, &callbackKey);
}

- (void)pickerDidHide
{
    if (self.callback) {
        self.callback(self);
    }
    self.wrapper = nil;
    self.callback = nil;
}

@end

@implementation UIView (CCPickerLikePresent)

- (void)showPickerWithCallback:(PickerDidHide)callback
{
    self.callback = callback;
    self.wrapper = [[CCPickerWrapper alloc] initWithPicker:self];
    self.wrapper.delegate = self;
    [self.wrapper show];
}

- (void)hidePicker
{
    [self.wrapper hide];
}

@end
