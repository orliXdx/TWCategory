//
//  UIImageView+MultipleMark.m
//  XiaoLuobo
//
//  Created by xu on 15/5/8.
//  Copyright (c) 2015年 OuerTech. All rights reserved.
//

#import "UIImageView+MultipleMark.h"
#import <objc/runtime.h>

#define MARK_BTN_WIDTH 31
#define MARK_BTN_HEIGHT 16
#define MARK_BTN_EDGE 5
#define PADDING       4
#define LIKE_VIEW_WIDTH     floor(([UIScreen mainScreen].bounds.size.width)-PADDING)/2
#define LIKE_VIEW_HEIGHT    floor(LIKE_VIEW_WIDTH*1.0+PADDING)
#define PRICE_VIEW_HEIGHT   26
#define PRICE_VIEW_WIDTH    70

static char markBtnKey;
static char bottomMarkBtnKey;

@implementation UIImageView (MultipleMark)

- (void)setMarkBtn:(UIButton *)button{
    
    objc_setAssociatedObject(self, &markBtnKey, button, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIButton *)markBtn{
    
    return objc_getAssociatedObject(self, &markBtnKey);
}

- (void)setBottomMarkBtn:(UIButton *)button {
    
    objc_setAssociatedObject(self, &bottomMarkBtnKey, button, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIButton *)bottomMarkBtn {
    
    return objc_getAssociatedObject(self, &bottomMarkBtnKey);
}

/* 设置右上角标示 */
- (void)setMarkWithCount:(NSInteger)count
{
    if (count > 1) {
        if (![self markBtn]) {
            [self createMarkBtn];
        }
        
        [[self markBtn] setTitle:[NSString stringWithFormat:@"%zd张", count] forState:UIControlStateNormal];
        [self markBtn].hidden = NO;
    }
    else{
        if (![self markBtn]) {
            [self createMarkBtn];
        }
        
        [[self markBtn] setTitle:@"" forState:UIControlStateNormal];
        [self markBtn].hidden = YES;
    }
}

- (void)createMarkBtn
{
    if (![self markBtn]) {
        UIButton *mark_btn = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width-MARK_BTN_WIDTH-MARK_BTN_EDGE,MARK_BTN_EDGE, MARK_BTN_WIDTH, MARK_BTN_HEIGHT)];
        [mark_btn setBackgroundImage:[UIImage imageNamed:@"tip_bg"] forState:UIControlStateNormal];
        [mark_btn.titleLabel setFont:[UIFont systemFontOfSize:(11)]];
        mark_btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [mark_btn setHidden:NO];
        
        [self addSubview:mark_btn];
        [self setMarkBtn:mark_btn];
    }
}

/* 清除控件 */
- (void)HideMark
{
    if ([self markBtn]) {
        [[self markBtn] setTitle:@"" forState:UIControlStateNormal];
        [self markBtn].hidden = YES;
    }
    
    if ([self bottomMarkBtn]) {
        [[self bottomMarkBtn] setTitle:@"" forState:UIControlStateNormal];
        [self bottomMarkBtn].hidden = YES;
    }
}

- (void)setMaskWithPrice:(NSInteger)price {
    if (price > 0) {
        if (![self bottomMarkBtn]) {
            [self createBottomMarkBtn];
        }
        
        [[self bottomMarkBtn] setTitle:[self getPirceWithUnit:price] forState:UIControlStateNormal];
        [self bottomMarkBtn].hidden = NO;
    }
    else{
        if (![self bottomMarkBtn]) {
            [self createBottomMarkBtn];
        }
        
        [[self bottomMarkBtn] setTitle:@"" forState:UIControlStateNormal];
        [self bottomMarkBtn].hidden = YES;
    }
}

- (void)createBottomMarkBtn {
    
    if (![self bottomMarkBtn]) {
        UIButton *bottomBtn = [[UIButton alloc] initWithFrame:CGRectMake(LIKE_VIEW_HEIGHT-PRICE_VIEW_WIDTH, LIKE_VIEW_HEIGHT-PRICE_VIEW_HEIGHT, PRICE_VIEW_WIDTH, PRICE_VIEW_HEIGHT)];
        //[bottomBtn setBackgroundImage:[UIImage imageNamed:@"tip_bg"] forState:UIControlStateNormal];
        bottomBtn.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        [bottomBtn.titleLabel setFont:[UIFont systemFontOfSize:(13)]];
        bottomBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        bottomBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [bottomBtn setHidden:NO];
        
        [self addSubview:bottomBtn];
        [self setBottomMarkBtn:bottomBtn];
    }
}

- (NSString *)getPirceWithUnit:(NSInteger)originalPrice
{
    NSString *priceStr = [NSString stringWithFormat:@"¥%zd",originalPrice];
    NSString *price = @"";
    if (priceStr.length > 9) {
        price = [NSString stringWithFormat:@"%@.%@亿",[priceStr substringToIndex:priceStr.length-8],[priceStr substringWithRange:NSMakeRange(priceStr.length-8, 2)]];
    }
    else if (priceStr.length > 5) {
        price = [NSString stringWithFormat:@"%@.%@万",[priceStr substringToIndex:priceStr.length-4],[priceStr substringWithRange:NSMakeRange(priceStr.length-4, 2)]];
    } else {
        price = priceStr;
    }
    return price;
}

@end
