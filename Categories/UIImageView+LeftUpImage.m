//
//  UIImageView+LeftUpImage.m
//  XiaoLuobo
//
//  Created by xu on 16/3/22.
//  Copyright © 2016年 TaoWanTech. All rights reserved.
//

#import "UIImageView+LeftUpImage.h"
#import <objc/runtime.h>

#define UIImageViewLeftUpImage_Left_Img_Size 50.f
#define UIImageViewLeftUpImage_Left_Img_Edge 8
#define UIImageViewLeftUpImage_PADDING       8
#define UIImageViewLeftUpImage_LIKE_VIEW_WIDTH     floor(currentDeviceWidth-PADDING*3)/2
#define UIImageViewLeftUpImage_LIKE_VIEW_HEIGHT    floor(LIKE_VIEW_WIDTH*1.0+PADDING)

@implementation UIImageView (LeftUpImage)

static char leftImgKey;

/* 设置左上角图片 */
- (void)setLeftUpImage:(NSString *)imageName
{
    if (![self isEmpty:imageName]) {
        if (![self leftImg]) {
            [self createLeftImg:imageName];
        }
        
        UIButton *left_img = [self leftImg];
        [left_img setFrame:CGRectMake(UIImageViewLeftUpImage_Left_Img_Edge, UIImageViewLeftUpImage_Left_Img_Edge, UIImageViewLeftUpImage_Left_Img_Size, UIImageViewLeftUpImage_Left_Img_Size)];
        [left_img setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [left_img setHidden:NO];
    }
    else{
        if (![self leftImg]) {
            [self createLeftImg:imageName];
        }
        
        UIButton *left_img = [self leftImg];
        [left_img setImage:nil forState:UIControlStateNormal];
        [left_img setHidden:YES];
    }
}

- (void)setBiggerLeftUpImage:(NSString *)imageName
{
    if (![self isEmpty:imageName]) {
        if (![self leftImg]) {
            [self createLeftImg:imageName];
        }
        
        UIButton *left_img = [self leftImg];
        [left_img setFrame:CGRectMake(UIImageViewLeftUpImage_Left_Img_Edge, UIImageViewLeftUpImage_Left_Img_Edge, UIImageViewLeftUpImage_Left_Img_Size*2, UIImageViewLeftUpImage_Left_Img_Size*2)];
        [left_img setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [left_img setHidden:NO];
    }
    else{
        if (![self leftImg]) {
            [self createLeftImg:imageName];
        }
        
        UIButton *left_img = [self leftImg];
        [left_img setImage:nil forState:UIControlStateNormal];
        [left_img setHidden:YES];
    }
}

- (void)setLeftImg:(UIButton *)button{
    objc_setAssociatedObject(self, &leftImgKey, button, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIButton *)leftImg{
    return objc_getAssociatedObject(self, &leftImgKey);
}

- (void)createLeftImg:(NSString *)imageName
{
    if (![self leftImg]) {
        UIButton *left_btn = [[UIButton alloc] initWithFrame:CGRectMake(UIImageViewLeftUpImage_Left_Img_Edge, UIImageViewLeftUpImage_Left_Img_Edge, UIImageViewLeftUpImage_Left_Img_Size, UIImageViewLeftUpImage_Left_Img_Size)];
        [left_btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [left_btn setHidden:NO];
        [self addSubview:left_btn];
        [self setLeftImg:left_btn];
    }
}

/* 清除控件 */
- (void)hideLeftUpImage
{
    if ([self leftImg]) {
        [[self leftImg] setImage:nil forState:UIControlStateNormal];
        [[self leftImg] setHidden:YES];
    }
}

- (BOOL)isEmpty:(NSString *)string
{
    if (![string isKindOfClass:[NSString class]])
        string = [string description];
    if (string == nil || string == NULL)
        return YES;
    if ([string isKindOfClass:[NSNull class]])
        return YES;
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0)
        return YES;
    if ([string isEqualToString:@"(null)"])
        return YES;
    if ([string isEqualToString:@"(null)(null)"])
        return YES;
    if ([string isEqualToString:@"<null>"])
        return YES;
    
    // return Default
    return NO;
}

@end
