//
//  UILabel+Custom.m
//  XiaoLuobo
//
//  Created by Siv on 15-3-20.
//  Copyright (c) 2015年 OuerTech. All rights reserved.
//

#import "UILabel+Custom.h"

@implementation UILabel(CustomFont)

- (void)setCustomFontText:(NSString *)text{
    self.text = text;
    if (text.length != 0) {
        NSString *regex = @"^[a-zA-Z0-9]*$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        BOOL isMatch = [pred evaluateWithObject:text];
        if (isMatch) {
            if (![self.font.fontName isEqualToString:@"OpenSans-Semibold"]) {
                self.font = [UIFont fontWithName:@"OpenSans" size:self.font.pointSize];
            }
        }
    }
}

-(void)setMultipleText:(NSString *)text withLineSpacing:(CGFloat)lineSpacing
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    self.attributedText = attributedString;
    self.numberOfLines = 0;
}

@end
