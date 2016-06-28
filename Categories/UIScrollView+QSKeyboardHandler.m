//
//  UIScrollView+QSKeyboardHandler.m
//  QuicklyShop
//
//  Created by 梵天 on 14-8-4.
//  Copyright (c) 2014年 com. All rights reserved.
//

#import <objc/runtime.h>
#import "UIScrollView+QSKeyboardHandler.h"
#import "UIView+StringTag.h"

static char QSScrollViewContentInsetsKey;

@implementation UIScrollView (QSKeyboardHandler)

- (void)setEnableKeyboardHandler:(BOOL)enableKeyboardHandler{
    
    if (enableKeyboardHandler) {
        if (self.enableKeyboardHandler) {
            return;
        }else{
            
            NSValue *contentInsets = [NSValue valueWithUIEdgeInsets:self.contentInset];
            objc_setAssociatedObject(self, &QSScrollViewContentInsetsKey, contentInsets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(keyboardWillChangeFrame:)
                                                         name:UIKeyboardWillChangeFrameNotification
                                                       object:nil];
            
            [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleScrollViewTap:)]];
        }
    }else{
        objc_setAssociatedObject(self, &QSScrollViewContentInsetsKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    }
}

- (void)handleScrollViewTap:(UITapGestureRecognizer *)ges{
    
    if (ges.view == self) {
        [self endEditing:YES];
    }
}

- (NSValue *)originalContentInsets{
    
    return objc_getAssociatedObject(self, &QSScrollViewContentInsetsKey);
}

- (BOOL)enableKeyboardHandler{
    
    return !![self originalContentInsets];
}

- (void)keyboardWillChangeFrame:(NSNotification *)noti{
    
    if (!self.enableKeyboardHandler) {
        return;
    }
    
    CGRect endFrame = [[noti.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    double duration = [[noti.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    __weak typeof(self) weakSelf = self;
    if (endFrame.origin.y == self.window.bounds.size.height) {
        
        UIEdgeInsets originalInsets = [[self originalContentInsets] UIEdgeInsetsValue];
        [UIView animateWithDuration:duration animations:^{
            if (!weakSelf) {
                return;
            }
            weakSelf.contentInset = originalInsets;
        }];
    }else{
        
        UIView *firstResponder = (UIView *)[self findFirstResponder];
        if (firstResponder) {
            CGRect keyboardFrame = [self.window convertRect:endFrame toView:self];
            CGFloat adjustY = CGRectGetMaxY(firstResponder.frame) - CGRectGetMinY(keyboardFrame);
            
            [UIView animateWithDuration:duration animations:^{
                if (!weakSelf) {
                    return;
                }
                UIEdgeInsets insets = weakSelf.contentInset;
                weakSelf.contentInset = UIEdgeInsetsMake(insets.top - adjustY,
                                                         insets.left,
                                                         insets.bottom,
                                                         insets.right);
            }];
        }
    }
}

@end
