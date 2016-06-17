//
//  CJCustomeButtonForDark.m
//  CRMCJ
//
//  Created by cjatech-简豪 on 16/3/29.
//  Copyright © 2016年 JZZ. All rights reserved.
//

#import "CJCustomeButtonForDark.h"

@implementation CJCustomeButtonForDark


- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    
    return CGRectMake(contentRect.origin.x, contentRect.size.height*2/3-3, contentRect.size.width, contentRect.size.height/3);
    
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake((contentRect.size.width-(contentRect.size.width-20))/2, 5, contentRect.size.width-20, contentRect.size.width-20);
}


@end
