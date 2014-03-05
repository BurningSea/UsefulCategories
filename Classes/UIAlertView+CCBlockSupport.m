//
//  UIAlertView+BlockSupport.m
//  Sea
//
//  Created by Sea on 13-8-18.
//  Copyright (c) 2013年 Sea All rights reserved.
//

#import "UIAlertView+CCBlockSupport.h"
#import <objc/runtime.h>

@implementation UIAlertView (CCBlockSupport)

@dynamic clicked;
@dynamic cancelled;

static void *clickedKey;
- (void)setClicked:(ClickBlock)clicked
{
    objc_setAssociatedObject(self, &clickedKey, clicked, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (ClickBlock)clicked
{
    return objc_getAssociatedObject(self, &clickedKey);
}

static void *cancelledKey;
- (void)setCancelled:(CancelBlock)cancelled
{
    objc_setAssociatedObject(self, &cancelledKey, cancelled, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CancelBlock)cancelled
{
    return objc_getAssociatedObject(self, &cancelledKey);
}


+ (UIAlertView *)   showAlertViewWithTitle      :(NSString *)title
                        message                 :(NSString *)message
                        cancelButtonTitle       :(NSString *)cancelButtonTitle
                        otherButtonTitles       :(NSArray *)otherButtons
                        onClick                 :(ClickBlock)clicked
                        onCancel                :(CancelBlock)cancelled
{
    UIAlertView *alert = [self alertViewWithTitle:title message:message cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtons onClick:clicked onCancel:cancelled];
    [alert show];
    return alert;
}

+ (UIAlertView *)   alertViewWithTitle      :(NSString *)title
                    message                 :(NSString *)message
                    cancelButtonTitle       :(NSString *)cancelButtonTitle
                    otherButtonTitles       :(NSArray *)otherButtons
                    onClick                 :(ClickBlock)clicked
                    onCancel                :(CancelBlock)cancelled
{
    UIAlertView *alert = [self alloc];
    alert = [alert initWithTitle:title message:message delegate:alert cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
    alert.clicked = clicked;
    alert.cancelled = cancelled;

    NSInteger count = otherButtons.count;

    for (NSInteger i = 0; i < count; i++) {
        [alert addButtonWithTitle:[otherButtons objectAtIndex:i]];
    }

    return alert;
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == [alertView cancelButtonIndex]) {
        if (self.cancelled) {
            self.cancelled();
        }
    } else {
        if (self.clicked) {
            self.clicked(buttonIndex);
        }
    }
}


@end