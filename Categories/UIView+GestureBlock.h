//
//  UIView+GestureBlock.h
//  XiaoLuobo
//
//  Created by Orientationsys on 15/2/26.
//  Copyright (c) 2015年 OuerTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (GestureBlock)

- (void)addGestureRecognizerWithBlock:(void(^)(void))gestureBlock;
- (void)removeGestureRecognizer;

@end
