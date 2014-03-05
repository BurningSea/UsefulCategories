//
//  UIAlertView+BlockSupport.h
//  Sea
//
//  Created by Sea on 13-8-18.
//  Copyright (c) 2013年 Sea All rights reserved.
//

typedef void (^ClickBlock)(int buttonIndex);
typedef void (^CancelBlock)();

@interface UIAlertView (CCBlockSupport)

@property (nonatomic, strong) ClickBlock clicked;
@property (nonatomic, strong) CancelBlock cancelled;

+ (UIAlertView *)   alertViewWithTitle      :(NSString *)title
                    message                 :(NSString *)message
                    cancelButtonTitle       :(NSString *)cancelButtonTitle
                    otherButtonTitles       :(NSArray *)otherButtons
                    onClick                 :(ClickBlock)clicked
                    onCancel                :(CancelBlock)cancelled;
+ (UIAlertView *)   showAlertViewWithTitle      :(NSString *)title
                    message                 :(NSString *)message
                    cancelButtonTitle       :(NSString *)cancelButtonTitle
                    otherButtonTitles       :(NSArray *)otherButtons
                    onClick                 :(ClickBlock)clicked
                    onCancel                :(CancelBlock)cancelled;

@end