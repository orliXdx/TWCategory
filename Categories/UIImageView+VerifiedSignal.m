//
//  UIImageView+VerifiedSignal.m
//  XiaoLuobo
//
//  Created by xu on 15/9/30.
//  Copyright (c) 2015年 OuerTech. All rights reserved.
//

#import "UIImageView+VerifiedSignal.h"
#import <objc/runtime.h>

#define VerifiedSignal_MarginLeft (15.f)
#define VerifiedSignal_MarginTop (15.f)
#define VerifiedSignal_Size  12.f

static char signalBtnKey;

@implementation UIImageView (VerifiedSignal)

- (void)setSignalBtn:(UIButton *)button{
    
    objc_setAssociatedObject(self, &signalBtnKey, button, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIButton *)signalBtn{
    
    return objc_getAssociatedObject(self, &signalBtnKey);
}

/* 设置右下角标示(如加v认证) */
- (void)showSignal
{
    if (![self signalBtn]) {
        [self createSignalBtn];
    }

    [self signalBtn].hidden = NO;
}

- (void)createSignalBtn
{
    if (![self signalBtn]) {
        
        UIButton *signal_btn = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width-VerifiedSignal_Size-VerifiedSignal_Size/2, self.frame.size.height-VerifiedSignal_Size-VerifiedSignal_Size/2, VerifiedSignal_Size, VerifiedSignal_Size)];
        [signal_btn setBackgroundColor:[UIColor lightGrayColor]];
        [signal_btn setImage:[UIImage imageNamed:@"set_normal_new_v"] forState:UIControlStateNormal];
        signal_btn.layer.masksToBounds = YES;
        signal_btn.layer.cornerRadius = VerifiedSignal_Size*0.5;
        [signal_btn setHidden:NO];
        
        [self addSubview:signal_btn];
        [self setSignalBtn:signal_btn];
    }
}

/* 清除控件 */
- (void)hideSignal
{
    if ([self signalBtn]) {
        [self signalBtn].hidden = YES;
    }
}


@end
