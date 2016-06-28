//
//  NSString+LBFilterName.m
//  XiaoLuobo
//
//  Created by 梵天 on 15/1/7.
//  Copyright (c) 2015年 OuerTech. All rights reserved.
//

#import <objc/runtime.h>
#import "NSString+LBFilterName.h"

static const char *LBFilterNameKey;

@implementation NSString (LBFilterName)

- (NSString *)filterName {
    
    return objc_getAssociatedObject(self, &LBFilterNameKey);
}

- (void)setFilterName:(NSString *)filterName {
    
    objc_setAssociatedObject(self, &LBFilterNameKey, filterName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end