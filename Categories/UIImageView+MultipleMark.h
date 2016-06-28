//
//  UIImageView+MultipleMark.h
//  XiaoLuobo
//
//  Created by xu on 15/5/8.
//  Copyright (c) 2015年 OuerTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (MultipleMark)

/* 设置右上角标示 */
- (void)setMarkWithCount:(NSInteger)count;

/* 底部价格标示 */
- (void)setMaskWithPrice:(NSInteger)price;

/* 清除控件 */
- (void)HideMark;

@end
