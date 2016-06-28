//
//  UIView+StringTag.m
//  AppAustriaX
//
//  Created by 梵天 on 14-7-4.
//  Copyright (c) 2014年 Austria. All rights reserved.
//

#import <objc/runtime.h>
#import "UIView+StringTag.h"

static char viewStringTag;

@implementation UIView (StringTag)

- (void)setStringTag:(NSString *)stringTag{

    objc_setAssociatedObject(self, &viewStringTag, stringTag, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)stringTag{
    
    return objc_getAssociatedObject(self, &viewStringTag);
}

- (UIView *)viewWithStringTag:(NSString *)tag{
    
    UIView *targetView = nil;
    for (UIView *view in self.subviews) {
        
        if ([view.stringTag isEqualToString:tag]) {
            targetView = view;
            break;
        }else{
            targetView = [view viewWithStringTag:tag];
            if (targetView) {
                break;
            }
        }
    }
    
    return targetView;
}

- (UIView *)viewWithTag:(NSInteger)tag{
    
    UIView *targetView = nil;
    for (UIView *view in self.subviews) {
        
        if (view.tag==tag) {
            targetView = view;
            break;
        }else{
            targetView = [view viewWithTag:tag];
            if (targetView) {
                break;
            }
        }
    }
    
    return targetView;
}

- (UIView *)findFirstResponder{
    
    UIView *firstResponder = nil;
    if (self.isFirstResponder) {
        firstResponder = self;
    }else{
        
        for (UIView *view in self.subviews) {
            
            if (view.isFirstResponder) {
                firstResponder = view;
                break;
            }else{
                
                firstResponder = [view findFirstResponder];
                if (firstResponder) {
                    break;
                }
            }
        }
    }
    return firstResponder;
}

-(UIViewController *)getViewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (NSInteger)getHeight {
    return self.frame.size.height;
}

- (NSInteger)getWidth {
    return self.frame.size.width;
}

- (NSInteger)getX {
    return self.frame.origin.x;
}

- (NSInteger)getY {
    return self.frame.origin.y;
}

- (NSInteger)viewBottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (NSInteger)viewRight {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)removeAllSubviews
{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
}

-(UIView*)findSubViewWithClass:(NSString*)clName
{
    UIView* view=nil;
    for (UIView *subview in self.subviews)
    {
        if ([subview isKindOfClass:NSClassFromString(clName)])
        {
            view=subview;
            break;
        } else
        {
            view=[subview findSubViewWithClass:clName];
        }
    }
    return view;
}

-(UIView*)findAncestorWithClass:(Class)aClass
{
    UIView* view=nil;
    
    UIView* currentView=self;
    while (true) {
        
        if(currentView!=nil)
        {
            if ([currentView isKindOfClass:aClass])
            {
                view=currentView;
                break;
            } else
            {
                currentView=currentView.superview;
            }
        } else
        {
            break;
        }
    }
    
    return view;
}

@end
