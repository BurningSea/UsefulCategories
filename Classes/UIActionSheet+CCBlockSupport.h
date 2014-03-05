//
//  UIActionSheet+BlockSupport.h
//  Sea
//
//  Created by Sea on 13-8-19.
//  Copyright (c) 2013年 Sea All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIActionSheet (CCBlockSupport)

+ (UIActionSheet *)showActionSheetInView:(UIView *)view
                                   title:(NSString *)title
                       cancelButtonTitle:(NSString *)cancelButtonTitle
                  destructiveButtonTitle:(NSString *)destructiveButtonTitle
                       otherButtonTitles:(NSArray *)otherButtonTitles
                         didClickAtIndex:(void(^)(NSInteger index))didClick;
+ (UIActionSheet *)actionSheetWithTitle:(NSString *)title
                      cancelButtonTitle:(NSString *)cancelButtonTitle
                 destructiveButtonTitle:(NSString *)destructiveButtonTitle
                      otherButtonTitles:(NSArray *)otherButtonTitles
                        didClickAtIndex:(void(^)(NSInteger index))didClick;
@property (nonatomic, strong) void(^didClick)(NSInteger buttonIndex);
@property (nonatomic, strong) void(^willPresent)();
@property (nonatomic, strong) void(^didPresent)();
@property (nonatomic, strong) void(^didDismiss)(NSInteger buttonIndex);

@end
