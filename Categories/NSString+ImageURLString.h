//
//  NSString+ImageURLString.h
//  XiaoLuobo
//
//  Created by 梵天 on 14/11/27.
//  Copyright (c) 2014年 OuerTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ImageURLString)

- (NSString *)URLStringWithImageSize:(CGSize)imgSize;

+ (NSString *)operationImgURL:(NSString *)imageURL withImgSize:(CGSize)imageSize;

- (NSString *)appendParamsToUrl:(NSString*)strParams;

-(NSURL*)urlWithStringParams:(NSString*)strParams;

-(NSString *)stringWithParams:(NSString *)strParams;

-(NSURL*)getThumbnailImageUrl:(NSString*)strParams withSize:(CGSize)imgSize;

- (NSURL *)getFullImageUrl:(NSString *)strParams withRect:(CGRect)imgRect;

- (NSURL *)getThumbnailImageUrl:(NSString *)strParams withRect:(CGRect)imgRect;

- (NSURL *)getThumbnailImageUrl:(NSString *)strParams withRect:(CGRect)imgRect andSizeParams:(NSInteger)imageSize;

- (NSURL *)getDownlodeImageUrl:(NSString *)strPara;

- (NSURL *)getFuzzyDownlodeImageUrl:(NSString *)strPara;

/**
 *  拼接预览大图URL
 */
- (NSURL *)getPreViewImageUrl:(NSString *)strParams withRect:(CGRect)imgRect;

@end
