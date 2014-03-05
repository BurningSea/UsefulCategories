//
//  PickerWrapperView.h
//  Sea
//
//  Created by Sea on 11/25/13.
//  Copyright (c) 2013 Sea All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCUsefulCategories.pch"

@protocol CCPickerWrapperDelegate <NSObject>

- (void)pickerDidHide;

@end

@interface CCPickerWrapper : NSObject

@property (nonatomic, cc_weak) id<CCPickerWrapperDelegate> delegate;

- (id)initWithPicker:(UIView *)picker;
- (void)show;
- (void)hide;

@end
