//
//  UIView+AlertLikePresent.h
//  Sea
//
//  Created by Sea on 1/24/14.
//  Copyright (c) 2014 Sea All rights reserved.
//

#import "CCAlertWrapper.h"

@interface UIView (CCAlertLikePresent)

@property (nonatomic) AlertAnimationType animationType;

- (void)showAlert;
- (void)hideAlert;

@end
