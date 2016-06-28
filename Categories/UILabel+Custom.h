//
//  UILabel+Custom.h
//  XiaoLuobo
//
//  Created by Siv on 15-3-20.
//  Copyright (c) 2015年 OuerTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel(CustomFont)

- (void)setCustomFontText:(NSString *)text;

-(void)setMultipleText:(NSString *)text withLineSpacing:(CGFloat)lineSpacing;

//CGFloat lineSpacing;
@end
