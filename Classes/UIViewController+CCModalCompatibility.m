//
//  UIViewController+ModalCompatibility.m
//  Sea
//
//  Created by Sea on 13-9-17.
//  Copyright (c) 2013年 Sea All rights reserved.
//

#import <objc/runtime.h>
#import <QuartzCore/QuartzCore.h>
#import "CCUsefulCategories.pch"

@implementation UIViewController (CCModalCompatibility)

- (void)_compatible_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion
{
    [self presentModalViewController:viewControllerToPresent animated:flag];
    [self insertCompletion:completion whenDismissOrPresentController:viewControllerToPresent animated:flag];
}

- (void)_compatible_dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion
{
    [self dismissModalViewControllerAnimated:flag];
    [self insertCompletion:completion whenDismissOrPresentController:self.modalViewController animated:flag];
}

- (void)insertCompletion:(void (^)(void))completion whenDismissOrPresentController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag
{
    if (completion) {
        if (flag) {
            CAAnimation *animation = [viewControllerToPresent.view.layer animationForKey:@"position"];
            if (animation) {
                id delegate = animation.delegate;
                if (delegate) {
                    __cc_weak Class delegateClass = [delegate class];
                    
                    SEL selector = @selector(animationDidStop:finished:);
                    Method method = class_getInstanceMethod(delegateClass, selector);
                    IMP originCompletionImp = class_getMethodImplementation(delegateClass, selector);
                    
                    id block = ^(id _self, CAAnimation *animation, BOOL finishied) {
                        originCompletionImp(_self, selector, animation, finishied);
                        completion();
                        method_setImplementation(method, originCompletionImp);
                    };
                    IMP tmpCompletionImp = imp_implementationWithBlock(block);
                    method_setImplementation(method, tmpCompletionImp);
                }
            }
        } else {
            completion();
        }
    }
}

- (void)goBackAnimated:(BOOL)flag
{
    if ([self isPresented]) {
        [self dismissViewControllerAnimated:flag completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:flag];
    }
}

- (void)goToRootControllerAnimated:(BOOL)flag
{
    if ([self isPresented]) {
        [self dismissViewControllerAnimated:flag completion:^{
            [self.navigationController popToRootViewControllerAnimated:flag];
        }];
    } else {
        [self.navigationController popToRootViewControllerAnimated:flag];
    }
}

- (BOOL)isPresented
{
//    if (self.presentingViewController) {
//        if (self.presentingViewController == self.navigationController) {
//            // iOS 4.3，push
//        } else {
//            // present
//        }
//    } else {
//        // iOS 5.0+，push
//    }
//    return YES;
//    return self.presentingViewController && (self.presentingViewController != self.navigationController);


    if (self.navigationController) {
        return self.navigationController.presentingViewController != nil;
    } else {
        return self.presentingViewController && (self.presentingViewController != self.navigationController);
    }
}

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self exchangePresentAndDismiss];
    });
}

+ (void)exchangePresentAndDismiss
{
    [self changeSel:@selector(presentViewController:animated:completion:) toCompatibleSelIfNeeded:@selector(_compatible_presentViewController:animated:completion:)];
    [self changeSel:@selector(dismissViewControllerAnimated:completion:) toCompatibleSelIfNeeded:@selector(_compatible_dismissViewControllerAnimated:completion:)];
    [self changeSel:@selector(presentingViewController) toCompatibleSelIfNeeded:@selector(parentViewController)];
    [self changeSel:@selector(presentedViewController) toCompatibleSelIfNeeded:@selector(modalViewController)];
}

+ (void)changeSel:(SEL)selector toCompatibleSelIfCould:(SEL)compatibleSelector
{
    if ([self instancesRespondToSelector:compatibleSelector]) {
        [self changeSel:selector toCompatibleSel:compatibleSelector];
    }
}

+ (void)changeSel:(SEL)selector toCompatibleSelIfNeeded:(SEL)compatibleSelector
{
    if (![self instancesRespondToSelector:selector]) {
        [self changeSel:selector toCompatibleSel:compatibleSelector];
    }
}

+ (void)changeSel:(SEL)selector toCompatibleSel:(SEL)compatibleSelector
{
    Method method = class_getInstanceMethod(self, selector);
    IMP imp = class_getMethodImplementation(self, compatibleSelector);
    if (method) {
        method_setImplementation(method, imp);
    } else {
        Method compatibleMethod = class_getInstanceMethod(self, compatibleSelector);
        class_addMethod(self, selector, imp, method_getTypeEncoding(compatibleMethod));
    }
}

@end
