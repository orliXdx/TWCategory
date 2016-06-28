//
//  UIAlertView+Customise.m
//  QuicklyShop
//
//  Created by 梵天 on 14-7-16.
//  Copyright (c) 2014年 com. All rights reserved.
//

#import <objc/runtime.h>
#import "UIAlertView+Customise.h"

static char *AlertViewCallbackBlockKey;

@implementation UIAlertView (Customise)

+ (instancetype)alertViewWithTitle:(NSString *)title
                           message:(NSString *)msg
                      buttonTitles:(NSArray *)titleArray
                          callback:(void (^)(UIAlertView *alertView, NSInteger buttonIndex))callbackBlock
{
    NSUInteger count = titleArray.count;
    NSString *cancelTitle = nil;
    NSString *otherTitle1 = nil;
    NSString *otherTitle2 = nil;
    
    switch (count) {
        case 1:{
            cancelTitle = titleArray[0];
            break;
        }
        case 2:{
            cancelTitle = titleArray[0];
            otherTitle1 = titleArray[1];
            break;
        }
        case 3:{
            cancelTitle = titleArray[0];
            otherTitle1 = titleArray[1];
            otherTitle2 = titleArray[2];
            break;
        }
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:cancelTitle
                                              otherButtonTitles:otherTitle1, otherTitle2, nil];
    
    if (callbackBlock) {
        objc_setAssociatedObject(alertView, &AlertViewCallbackBlockKey, callbackBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    alertView.delegate = alertView;
    
    return alertView;
}

- (UITextField *)nameTextField{
    return [self textFieldAtIndex:0];
}

- (UITextField *)passwordTextField{
    return [self textFieldAtIndex:1];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    alertView.delegate = nil;
    void (^callbackBlock) (UIAlertView *alertView, NSInteger buttonIndex) = objc_getAssociatedObject(alertView, &AlertViewCallbackBlockKey);

    if (callbackBlock) {
        callbackBlock(alertView, buttonIndex);
    }
}

@end
