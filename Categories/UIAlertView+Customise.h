//
//  UIAlertView+Customise.h
//  QuicklyShop
//
//  Created by 梵天 on 14-7-16.
//  Copyright (c) 2014年 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (Customise)


+ (instancetype)alertViewWithTitle:(NSString *)title
                           message:(NSString *)msg
                      buttonTitles:(NSArray *)titleArray
                          callback:(void(^)(UIAlertView *alertView, NSInteger buttonIndex))callbackBlock;

- (UITextField *)nameTextField;
- (UITextField *)passwordTextField;


@end
