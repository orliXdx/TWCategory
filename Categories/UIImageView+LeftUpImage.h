//
//  UIImageView+LeftUpImage.h
//  XiaoLuobo
//
//  Created by xu on 16/3/22.
//  Copyright © 2016年 TaoWanTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (LeftUpImage)

/* 设置左上角图片 */
- (void)setLeftUpImage:(NSString *)imageName;

- (void)setBiggerLeftUpImage:(NSString *)imageName;

/* 清除控件 */
- (void)hideLeftUpImage;

@end
