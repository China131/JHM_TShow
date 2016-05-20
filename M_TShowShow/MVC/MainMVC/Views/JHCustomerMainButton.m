
//
//  JHCustomerMainButton.m
//  M_TShowShow
//
//  Created by cjatech-简豪 on 16/4/22.
//  Copyright © 2016年 JH. All rights reserved.
//

#import "JHCustomerMainButton.h"

@implementation JHCustomerMainButton




-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    
    return CGRectMake(0, contentRect.size.height-30, contentRect.size.width, 20);
    
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    
    return CGRectMake((contentRect.size.width - self.currentImage.size.width)/2, 7, self.currentImage.size.width, self.currentImage.size.height);
    
}

@end
