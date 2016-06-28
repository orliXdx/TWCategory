//
//  UIImageView+VerifiedSignal.h
//  XiaoLuobo
//
//  Created by xu on 15/9/30.
//  Copyright (c) 2015年 OuerTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (VerifiedSignal)

/* 设置右下角标示(如加v认证) */
- (void)showSignal;

/* 清除控件 */
- (void)hideSignal;

@end
