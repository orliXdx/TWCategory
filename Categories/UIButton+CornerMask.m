//
//  UIButton+CornerMask.m
//  XiaoLuobo
//
//  Created by devil on 16/2/27.
//  Copyright © 2016年 TaoWanTech. All rights reserved.
//

#import "UIButton+CornerMask.h"

@implementation UIButton (CornerMask)

- (void)addCornerMaskToBounds:(float)cornerRadius BorderWidth:(float)borderWidth BorderColor:(UIColor *)borderColor
{
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    
    CGPathRef maskPath = CGPathCreateWithRoundedRect(self.bounds, cornerRadius, cornerRadius, NULL);
    
    maskLayer.bounds = self.bounds;
    maskLayer.path = maskPath;
    maskLayer.fillColor = [UIColor blackColor].CGColor;
    
    CGPoint point = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    maskLayer.position = point;
    
    [self.layer setMask:maskLayer];
    
    if (borderWidth > 0)
    {
        CAShapeLayer*   shape   = [CAShapeLayer layer];
        shape.bounds            = self.bounds;
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
