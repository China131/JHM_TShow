//
//  JHFeilterManager.h
//  iOS滤镜测试
//
//  Created by 简豪 on 16/6/19.
//  Copyright © 2016年 codingMan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef void(^imageBlock)(UIImage *image);
@interface JHFeilterManager : UIView
@property (nonatomic,copy)imageBlock imageBLOCK;
- (UIImage *)createImageWithImage:(UIImage *)inImage andColorMatrix:(const float *)f;
@end
