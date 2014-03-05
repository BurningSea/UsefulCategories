//
//  UIViewController+ModalCompatibility.h
//  Sea
//
//  Created by Sea on 13-9-17.
//  Copyright (c) 2013年 Sea All rights reserved.
//

@interface UIViewController (CCModalCompatibility)

- (void)goBackAnimated:(BOOL)flag;
- (void)goToRootControllerAnimated:(BOOL)flag;
- (BOOL)isPresented;

@end
