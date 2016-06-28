//
//  UIImage+RCImage.h
//  RCloudMessage
//
//  Created by Liv on 15/4/7.
//  Copyright (c) 2015年 胡利武. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (RCImage)

/**
 *  修改图片size
 *
 *  @param image      原图片
 *  @param targetSize 要修改的size
 *
 *  @return 修改后的图片
 */
+ (UIImage *)image:(UIImage*)image byScalingToSize:(CGSize)targetSize;

- (UIImage *)imageByRoundCornerRadius:(CGFloat)radius;

@end
