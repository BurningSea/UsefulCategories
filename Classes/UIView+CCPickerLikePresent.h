//
//  UIView+PickerLikePresent.h
//  Sea
//
//  Created by Sea on 1/24/14.
//  Copyright (c) 2014 Sea All rights reserved.
//

typedef void(^PickerDidHide)(UIView *picker);

@interface UIView (CCPickerLikePresent)

- (void)showPickerWithCallback:(PickerDidHide)callback;
- (void)hidePicker;

@end
