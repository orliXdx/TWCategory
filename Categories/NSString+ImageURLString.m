//
//  NSString+ImageURLString.m
//  XiaoLuobo
//
//  Created by 梵天 on 14/11/27.
//  Copyright (c) 2014年 OuerTech. All rights reserved.
//

#import "NSString+ImageURLString.h"


@implementation NSString (ImageURLString)

- (NSString *)URLStringWithImageSize:(CGSize)imgSize {
    
    CGFloat scaleRate = [UIScreen mainScreen].scale;
    NSString *URLString = [self stringByReplacingOccurrencesOfString:@"$w$"
                                                          withString:[NSString stringWithFormat:@"%0.f", imgSize.width*scaleRate]];
    URLString = [URLString stringByReplacingOccurrencesOfString:@"$h$"
                                                     withString:[NSString stringWithFormat:@"%0.f", imgSize.height*scaleRate]];
    URLString = [URLString stringByReplacingOccurrencesOfString:@"@" withString:@""];
    
    return URLString;
}

+ (NSString *)operationImgURL:(NSString *)imageURL withImgSize:(CGSize)imageSize {
    imageURL = [imageURL stringByReplacingOccurrencesOfString:@"$w$" withString:[NSString stringWithFormat:@"%0.f",imageSize.width*2]];
    imageURL = [imageURL stringByReplacingOccurrencesOfString:@"$h$" withString:[NSString stringWithFormat:@"%0.f",imageSize.height*2]];
    imageURL = [imageURL stringByReplacingOccurrencesOfString:@"@" withString:@""];
    return imageURL;
}

- (NSString *)appendParamsToUrl:(NSString*)strParams
{
   return ([NSString stringWithFormat:@"%@?imageMogr2%@", self,strParams]);
}

-(NSURL *)urlWithStringParams:(NSString*)strParams
{
    //判断字符串中是否含有"?"
    if ([self rangeOfString:@"?"].location != NSNotFound) {
        NSRange range = [self rangeOfString:@"?"];
        NSString *str = [self substringToIndex:range.location];
        NSString *urlString = [NSString stringWithFormat:@"%@?imageMogr2%@", str,strParams];
        NSURL *url = [NSURL URLWithString:urlString];
        return url;
    }
    
    return [NSURL URLWithString:self];
}

-(NSString *)stringWithParams:(NSString *)strParams
{
    //判断字符串中是否含有"?"
    if ([self rangeOfString:@"?"].location != NSNotFound) {
        NSRange range = [self rangeOfString:@"?"];
        NSString *str = [self substringToIndex:range.location];
        NSString *urlString = [NSString stringWithFormat:@"%@?imageMogr2%@", str,strParams];
        return urlString;
    }
    
    return self;
}

-(NSURL*)getThumbnailImageUrl:(NSString*)strParams withSize:(CGSize)imgSize
{
    //判断字符串中是否含有"?"
    if ([self rangeOfString:@"?"].location != NSNotFound) {
        NSRange range = [self rangeOfString:@"?"];
        NSString *str = [self substringToIndex:range.location];
        
        NSMutableString *params=[NSMutableString stringWithString:@"?imageMogr2/thumbnail/240x"];
        //?imageMogr2/format/jpg/thumbnail/208x>/crop/!300x400a10a10/quality/90!
        
        if(imgSize.width>0 && imgSize.height>0)
        {
            CGFloat fScale=240.0/imgSize.width;
            imgSize.width=240.0;
            imgSize.height=imgSize.height*fScale;
            if(imgSize.width>imgSize.height)
            {
                NSUInteger cropX=(imgSize.width-imgSize.height)/2;
                NSString *cropParam = [NSString stringWithFormat:@"/crop/!%zdx%zda%zda0",
                                       (NSUInteger)imgSize.height,(NSUInteger)imgSize.height,cropX];
                [params appendString:cropParam];
            }
            else if(imgSize.width<imgSize.height)
            {
                NSUInteger cropY=(imgSize.height-imgSize.width)/2;
                NSString *cropParam = [NSString stringWithFormat:@"/crop/!%zdx%zda0a%zd",
                                       (NSUInteger)imgSize.width,(NSUInteger)imgSize.width,cropY];
                [params appendString:cropParam];
            }
        }

        [params appendString:@"/quality/90"];
        
        NSString *urlString = [NSString stringWithFormat:@"%@%@", str,params];
        NSURL *url = [NSURL URLWithString:urlString];
        return url;
    }
    return 0;
}

/**
 *  拼接大图URL
 */
- (NSURL *)getFullImageUrl:(NSString *)strParams withRect:(CGRect)imgRect {
    //判断字符串中是否含有"?"
    if ([self rangeOfString:@"?"].location != NSNotFound) {
        NSRange range = [self rangeOfString:@"?"];
        NSString *str = [self substringToIndex:range.location];
        
        NSMutableString *params=[NSMutableString stringWithString:@"?imageMogr2"];
        if(imgRect.size.width>0 && imgRect.size.height>0) {
            NSString *cropParam = [NSString stringWithFormat:@"/crop/!%zdx%zda%zda%zd", (NSUInteger)imgRect.size.width, (NSUInteger)imgRect.size.height, (NSUInteger)imgRect.origin.x, (NSUInteger)imgRect.origin.y];
            [params appendString:cropParam];
        }
        
        if([strParams hasPrefix:@"?"])
        {
            [params appendString:@"/thumbnail/600x/quality/90"];
        }
        else
        {
            [params appendString:strParams];
        }
        NSString *urlString = [NSString stringWithFormat:@"%@%@", str,params];
        NSURL *url = [NSURL URLWithString:urlString];
        return url;
    }
    return 0;
}

/**
 *  拼接预览大图URL
 */
- (NSURL *)getPreViewImageUrl:(NSString *)strParams withRect:(CGRect)imgRect {
    //判断字符串中是否含有"?"
    if ([self rangeOfString:@"?"].location != NSNotFound) {
        NSRange range = [self rangeOfString:@"?"];
        NSString *str = [self substringToIndex:range.location];
        
        NSMutableString *params=[NSMutableString stringWithString:@"?imageMogr2"];
        if(imgRect.size.width>0 && imgRect.size.height>0) {
            NSString *cropParam = [NSString stringWithFormat:@"/crop/!%zdx%zda%zda%zd", (NSUInteger)imgRect.size.width, (NSUInteger)imgRect.size.height, (NSUInteger)imgRect.origin.x, (NSUInteger)imgRect.origin.y];
            [params appendString:cropParam];
        }
        NSString *urlString = [NSString stringWithFormat:@"%@%@", str,params];
        NSURL *url = [NSURL URLWithString:urlString];
        return url;
    }
    return 0;
}

/**
 *  拼接缩略图URL
 */
- (NSURL *)getThumbnailImageUrl:(NSString *)strParams withRect:(CGRect)imgRect {
    //判断字符串中是否含有"?"
    if ([self rangeOfString:@"?"].location != NSNotFound) {
        NSRange range = [self rangeOfString:@"?"];
        NSString *str = [self substringToIndex:range.location];
        
        NSMutableString *params=[NSMutableString stringWithString:@"?imageMogr2"];
        if(imgRect.size.width>0 && imgRect.size.height>0) {
            NSString *cropParam = [NSString stringWithFormat:@"/crop/!%zdx%zda%zda%zd", (NSUInteger)imgRect.size.width, (NSUInteger)imgRect.size.height, (NSUInteger)imgRect.origin.x, (NSUInteger)imgRect.origin.y];
            [params appendString:cropParam];
        }
        [params appendString:@"/thumbnail/240x/quality/90"];
        NSString *urlString = [NSString stringWithFormat:@"%@%@", str,params];
        NSURL *url = [NSURL URLWithString:urlString];
        return url;
    }
    return 0;
}

/* 动态拼接小图URL */
- (NSURL *)getThumbnailImageUrl:(NSString *)strParams withRect:(CGRect)imgRect andSizeParams:(NSInteger)imageSize {
    if ([self rangeOfString:@"?"].location != NSNotFound) {
        NSRange range = [self rangeOfString:@"?"];
        NSString *str = [self substringToIndex:range.location];
        
        NSMutableString *params=[NSMutableString stringWithString:@"?imageMogr2"];
        if(imgRect.size.width>0 && imgRect.size.height>0) {
            NSString *cropParam = [NSString stringWithFormat:@"/crop/!%zdx%zda%zda%zd", (NSUInteger)imgRect.size.width, (NSUInteger)imgRect.size.height, (NSUInteger)imgRect.origin.x, (NSUInteger)imgRect.origin.y];
            [params appendString:cropParam];
        }
        NSString *tempString = [NSString stringWithFormat:@"/thumbnail/%zdx/quality/90", imageSize];
        [params appendString:tempString];
        NSString *urlString = [NSString stringWithFormat:@"%@%@", str,params];
        NSURL *url = [NSURL URLWithString:urlString];
        return url;
    }
    return 0;
}


/* 拼接下载图片URL */
- (NSURL *)getDownlodeImageUrl:(NSString *)strPara {
    if ([self rangeOfString:@"?"].location != NSNotFound) {
        NSRange range = [self rangeOfString:@"?"];
        NSString *str = [self substringToIndex:range.location];
        NSMutableString *params=[NSMutableString stringWithString:@"?"];
        NSString *urlString = [NSString stringWithFormat:@"%@%@", str,params];
        NSURL *url = [NSURL URLWithString:urlString];
        return url;
    }
    return 0;
}

/* 拼接下载 质量差的原图 URL */
- (NSURL *)getFuzzyDownlodeImageUrl:(NSString *)strPara {
    if ([self rangeOfString:@"?"].location != NSNotFound) {
        NSRange range = [self rangeOfString:@"?"];
        NSString *str = [self substringToIndex:range.location];
        NSMutableString *params=[NSMutableString stringWithString:@"?"];
        NSString *parameStr = @"imageMogr2/quality/80";
        NSString *urlString = [NSString stringWithFormat:@"%@%@%@", str, params, parameStr];
        NSURL *url = [NSURL URLWithString:urlString];
        return url;
    }
    return 0;
}




@end
