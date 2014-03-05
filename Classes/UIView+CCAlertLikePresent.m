//
//  UIView+AlertLikePresent.m
//  Sea
//
//  Created by Sea on 1/24/14.
//  Copyright (c) 2014 Sea All rights reserved.
//

#import "UIView+CCAlertLikePresent.h"
#import <objc/runtime.h>

@interface UIView (Private)

@property (nonatomic, strong) CCAlertWrapper *wrapper;

@end

@implementation UIView (Private)

@dynamic wrapper;
static void *wrapperKey;
- (void)setWrapper:(CCAlertWrapper *)wrapper
{
    objc_setAssociatedObject(self, &wrapperKey, wrapper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CCAlertWrapper *)wrapper
{
    return objc_getAssociatedObject(self, &wrapperKey);
}

@end

@implementation UIView (CCAlertLikePresent)

@dynamic animationType;
static void *animationTypeKey;

- (void)setAnimationType:(AlertAnimationType)animationType
{
    objc_setAssociatedObject(self, &animationType, @(animationType), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (AlertAnimationType)animationType
{
    return [objc_getAssociatedObject(self, &animationTypeKey) integerValue];
}

- (void)showAlert
{
    self.wrapper = [[CCAlertWrapper alloc] initWithAlert:self animationType:self.animationType];
    [self.wrapper show];
}

- (void)hideAlert
{
    [self.wrapper hide];
    self.wrapper = nil;
}

@end
