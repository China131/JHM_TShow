//
//  JHFeilterManager.m
//  iOS滤镜测试
//
//  Created by 简豪 on 16/6/19.
//  Copyright © 2016年 codingMan. All rights reserved.
//

#import "JHFeilterManager.h"


void * bitmap;
@implementation JHFeilterManager

#pragma mark---------------------------------------->创建一个使用RGBA通道的位图上下文
static CGContextRef CreateRGBABitmapContex(CGImageRef inImage){
    
    CGContextRef context = NULL;
    CGColorSpaceRef colorSpace;
    void *bitmapData;//内存空间的指针，该内存空间的大小等于图像使用RGB通道所占用的字节数。
    long bitmapByteCount;
    long bitmapBytePerRow;
    
    /*        获取像素的横向和纵向个数         */
    size_t pixelsWith = CGImageGetWidth(inImage);
    size_t pixelsHigh = CGImageGetHeight(inImage);

    /*        每一行的像素点占用的字节数，每个像素点的RGBA四个通道各占8bit空间         */
    bitmapBytePerRow = (pixelsWith * 4);
    
    /*       整张图片占用的字节数          */
    bitmapByteCount = (bitmapBytePerRow * pixelsHigh);
    
    /*        创建依赖设备的RGB通道         */
    colorSpace = CGColorSpaceCreateDeviceRGB();
    
    /*        分配足够容纳图片字节数的内存空间         */
    bitmapData = malloc(bitmapByteCount);
    
    /*        引用内存地址 以便在合适的地方释放内存空间        */
    bitmap = bitmapData;
    
    /*        创建CoreGraphic的图形上下文 该上下文描述了bitmaData指向的内存空间需要绘制的图像的一些绘制参数         */
    
    context = CGBitmapContextCreate(bitmapData, pixelsWith, pixelsHigh, 8, bitmapBytePerRow, colorSpace, kCGImageAlphaPremultipliedLast);
    
    /*        Core Foundation中含有Create、Alloc的方法名字创建的指针，需要使用CFRelease（）函数释放         */
    CGColorSpaceRelease(colorSpace);
    
    /*        此处必须手动释放内存 不然会有内存暴增的现象 但如果在这里释放 真机运行时情况可能就不太好了 （注意：在模拟器上 在此释放不会有任何问题 模拟器的图形上下文和画板机制与真机不同）        */
//    free(bitmapData);
    return context;
    
}


//返回一个指针，该指针指向一个数组，数组中的每四个元素都是图像上的一个像素点的RGBA的数值（0-255），用无符号的char是因为它正好的取值范围就是0-255
static unsigned char *RequestImagePixelData(UIImage * inImage){
    CGImageRef img = [inImage CGImage];
    CGSize size = [inImage size];
    //使用上面的函数创建上下文
    CGContextRef cgctx = CreateRGBABitmapContex(img);
    CGRect rect = {{0,0},{size.width,size.height}};
    
    //将目标图像绘制到指定的上下文，实际为上下文内的bitmapData。
    CGContextDrawImage(cgctx, rect, img);
    unsigned char *data = CGBitmapContextGetData(cgctx);
    

    //释放上面的函数创建的上下文
    CGContextRelease(cgctx);

    return data;
}


//获得以像素为单位的长和宽，开始处理位图中每个像素的值，生成指定效果
- (UIImage *)createImageWithImage:(UIImage *)inImage andColorMatrix:(const float *)f{
    
    
    /*        图片位图像素值数组         */
    unsigned char *imgPixel = RequestImagePixelData(inImage);
    
    CGImageRef inImageRef = [inImage CGImage];
    long w = CGImageGetWidth(inImageRef);
    long h = CGImageGetHeight(inImageRef);
    
    int wOff = 0;
    int pixOff = 0;
    
    /*        遍历修改位图像素值         */
    for (long y = 0; y<h; y++) {
        pixOff = wOff;
        for (long x = 0; x<w; x++) {
            int red = (unsigned char)imgPixel[pixOff];
            int green = (unsigned char)imgPixel[pixOff+1];
            int blue = (unsigned char)imgPixel[pixOff +2];
            int alpha = (unsigned char)imgPixel[pixOff +3];
            changeRGB(&red, &green, &blue, &alpha,f);
            imgPixel[pixOff] = red;
            imgPixel[pixOff + 1] = green;
            imgPixel[pixOff + 2] = blue;
            imgPixel[pixOff + 3] = alpha;
            pixOff += 4;
        }
        wOff += w * 4 ;
    }
    
    NSInteger dataLength = w * h * 4;
    //创建要输出的图像的相关参数
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, imgPixel, dataLength, NULL);
    
    if (!provider) {
        NSLog(@"创建输出图像相关参数失败！");
    }else{
        int bitsPerComponent = 8;
        int bitsPerPixel = 32;
        ItemCount bytesPerRow = 4 * w;
        CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
        CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
        CGColorRenderingIntent rederingIntent = kCGRenderingIntentDefault;
        //创建要输出的图像
        CGImageRef imageRef = CGImageCreate(w, h,bitsPerComponent, bitsPerPixel, bytesPerRow, colorSpaceRef, bitmapInfo, provider,NULL, NO, rederingIntent);
        if (!imageRef) {
            NSLog(@"创建输出图像失败");
           
        }else{
            UIImage *my_image = [UIImage imageWithCGImage:imageRef];
            CFRelease(imageRef);
            CGColorSpaceRelease(colorSpaceRef);
            CGDataProviderRelease(provider);
            
            NSData *data = UIImageJPEGRepresentation(my_image, 1.0);
            
            /*        在这里就可以释放内存了 并且在此之后my_image由于运行时和图形上下文机制已经没有图像内容了 只能使用刚刚生成的图片二进制数据进行图片回传        */
            free(bitmap);
            
            if (_imageBLOCK) {
                _imageBLOCK([UIImage imageWithData:data]);
            }
            
            return [UIImage imageWithData:data];
        }
        
    }
    
    return nil;
}



static void changeRGB(int *red,int* green,int*blue,int*alpha ,const float *f){
    
    int redV = *red;
    int greenV = *green;
    int blueV = *blue;
    int alphaV = *alpha;

    
    *red = f[0] * redV + f[1]*greenV + f[2]*blueV + f[3] * alphaV + f[4];
    *green = f[5] * redV + f[6]*greenV + f[7]*blueV + f[8] * alphaV+ f[9];
    *blue = f[10] * redV + f[11]*greenV + f[12]*blueV + f[11] * alphaV+ f[14];
    *alpha = f[15] * redV + f[16]*greenV + f[17]*blueV + f[18] * alphaV+ f[19];
    
    if (*red<0) {
        *red=0;
    }
    
    if (*red>255) {
        *red = 255;
    }
    
    if (*green<0) {
        *green = 0;
    }
    
    if (*green>255) {
        *green = 255;
    }
    if (*blue<0) {
        *blue = 0;
    }
    
    if (*blue>255) {
        *blue = 255;
    }
    
    
    if (*alpha>255) {
        *alpha=255;
    }
    if (*alpha<0) {
        *alpha = 0;
    }
    
}



-(void)dealloc{
    
    
    
    
}




























@end
