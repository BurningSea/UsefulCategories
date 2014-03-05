//
//  UIActionSheet+BlockSupport.m
//  Sea
//
//  Created by Sea on 13-8-19.
//  Copyright (c) 2013年 Sea All rights reserved.
//

#import "UIActionSheet+CCBlockSupport.h"
#import <objc/runtime.h>

@interface UIActionSheet ()<UIActionSheetDelegate>

@end

@implementation UIActionSheet (CCBlockSupport)

@dynamic didClick;
static void *didClickKey;
- (void)setDidClick:(void(^)(NSInteger))didClick
{
    objc_setAssociatedObject(self, &didClickKey, didClick, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void(^)(NSInteger))didClick
{
    return objc_getAssociatedObject(self, &didClickKey);
}

@dynamic willPresent;
static void *willPresentKey;
- (void)setwillPresent:(void(^)())willPresent
{
    objc_setAssociatedObject(self, &willPresentKey, willPresent, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void(^)())willPresent
{
    return objc_getAssociatedObject(self, &willPresentKey);
}

@dynamic didPresent;
static void *didPresentKey;
- (void)setdidPresent:(void(^)())didPresent
{
    objc_setAssociatedObject(self, &didPresentKey, didPresent, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void(^)())didPresent
{
    return objc_getAssociatedObject(self, &didPresentKey);
}

@dynamic didDismiss;
static void *didDismissKey;
- (void)setDidDismiss:(void(^)(NSInteger buttonIndex))didDismiss
{
    objc_setAssociatedObject(self, &didDismissKey, didDismiss, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void(^)(NSInteger buttonIndex))didDismiss
{
    return objc_getAssociatedObject(self, &didDismissKey);
}

+ (UIActionSheet *)showActionSheetInView:(UIView *)view
                                   title:(NSString *)title
                       cancelButtonTitle:(NSString *)cancelButtonTitle
                  destructiveButtonTitle:(NSString *)destructiveButtonTitle
                       otherButtonTitles:(NSArray *)otherButtonTitles
                        didClickAtIndex:(void(^)(NSInteger index))didClick
{
    UIActionSheet *actionSheet = [self actionSheetWithTitle:title cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:otherButtonTitles didClickAtIndex:didClick];
    [actionSheet showInView:view];
    return actionSheet;
}

+ (UIActionSheet *)actionSheetWithTitle:(NSString *)title
                      cancelButtonTitle:(NSString *)cancelButtonTitle
                 destructiveButtonTitle:(NSString *)destructiveButtonTitle
                      otherButtonTitles:(NSArray *)otherButtonTitles
                        didClickAtIndex:(void(^)(NSInteger index))didClick
{
    UIActionSheet *actionSheet = [UIActionSheet alloc];
    actionSheet = [actionSheet initWithTitle:title delegate:actionSheet cancelButtonTitle:nil destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:nil];
    for (NSString *otherButtonTitle in otherButtonTitles) {
        [actionSheet addButtonWithTitle:otherButtonTitle];
    }
    [actionSheet addButtonWithTitle:cancelButtonTitle];
    actionSheet.cancelButtonIndex = otherButtonTitles.count;
    // 本来是回调didClick的，但是这样ios7上人人的授权弹窗会附到ActionSheet的window上，所以改用didDismiss
    // 二者回调的index相同，唯一的差别是调用时机
    actionSheet.didDismiss = didClick;
    return actionSheet;
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (self.didClick) {
        self.didClick(buttonIndex);
    }
}

- (void)willPresentActionSheet:(UIActionSheet *)actionSheet
{
    if (self.willPresent) {
        self.willPresent();
    }
}

- (void)didPresentActionSheet:(UIActionSheet *)actionSheet
{
    if (self.didPresent) {
        self.didPresent();
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (self.didDismiss) {
        self.didDismiss(buttonIndex);
    }
}

@end
