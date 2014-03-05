//
//  AlertWrapper.h
//  Sea
//
//  Created by Sea on 1/23/14.
//  Copyright (c) 2014 Sea All rights reserved.
//

#import "CCUsefulCategories.pch"

typedef NS_ENUM(NSUInteger, AlertAnimationType) {
    AlertAnimationTypeNormal,
    AlertAnimationTypeRotate,
    AlertAnimationTypeScale
};

@interface CCAlertWrapper : NSObject

- (instancetype)initWithAlert:(UIView *)alert;
- (instancetype)initWithAlert:(UIView *)alert animationType:(AlertAnimationType)animationType;
- (void)show;
- (void)hide;

@end
