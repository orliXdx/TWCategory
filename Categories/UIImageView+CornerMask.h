//
//  UIImageView+CornerMask.h
//  XiaoLuobo
//
//  Created by devil on 16/2/27.
//  Copyright © 2016年 TaoWanTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (CornerMask)

- (void)addRoundMaskToBounds:(CGRect)maskBounds BorderWidth:(float)borderWidth BorderColor:(UIColor *)borderColor;

@end
