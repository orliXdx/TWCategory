//
//  UIView+GestureBlock.m
//  XiaoLuobo
//
//  Created by Orientationsys on 15/2/26.
//  Copyright (c) 2015年 OuerTech. All rights reserved.
//

#import "UIView+GestureBlock.h"
#import <objc/runtime.h>

static const char *gestureBlockKey;

@implementation UIView (GestureBlock)

- (void)addGestureRecognizerWithBlock:(void(^)(void))gestureBlock
{
    UISwipeGestureRecognizer *gesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(actionSwipe)];
    [gesture setDirection:UISwipeGestureRecognizerDirectionRight];
    [self addGestureRecognizer:gesture];
    
    objc_setAssociatedObject(self, &gestureBlockKey, gestureBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

/* swipe guesture */
- (void)actionSwipe
{
    void(^gestureBlock)(void) = objc_getAssociatedObject(self, &gestureBlockKey);
    if (gestureBlock) {
        gestureBlock();
    }
}

- (void)removeGestureRecognizer
{
    
}

@end
