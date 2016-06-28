//
//  UIImageView+CornerMask.m
//  XiaoLuobo
//
//  Created by devil on 16/2/27.
//  Copyright © 2016年 TaoWanTech. All rights reserved.
//

#import "UIImageView+CornerMask.h"

@implementation UIImageView (CornerMask)

- (void)addRoundMaskToBounds:(CGRect)maskBounds BorderWidth:(float)borderWidth BorderColor:(UIColor *)borderColor
{
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    
    CGPathRef maskPath = CGPathCreateWithEllipseInRect(maskBounds, NULL);
    maskLayer.bounds = maskBounds;
    maskLayer.path = maskPath;
    maskLayer.fillColor = [UIColor blackColor].CGColor;
    
    CGPoint point = CGPointMake(maskBounds.size.width/2, maskBounds.size.height/2);
    maskLayer.position = point;
    
    [self.layer setMask:maskLayer];
    
    if (borderWidth > 0)
    {
        CAShapeLayer*   shape   = [CAShapeLayer layer];
        shape.bounds            = maskBounds;
        shape.path              = maskPath;
        shape.lineWidth         = borderWidth;
        shape.strokeColor       = borderColor.CGColor;
        shape.fillColor         = [UIColor clearColor].CGColor;
        shape.position          = point;
        
        [self.layer addSublayer:shape];
    }
    
    CGPathRelease(maskPath);
}

@end
