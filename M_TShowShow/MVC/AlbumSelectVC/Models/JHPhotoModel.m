//
//  JHPhotoModel.m
//  M_TShowShow
//
//  Created by cjatech-简豪 on 16/5/10.
//  Copyright © 2016年 JH. All rights reserved.
//

#import "JHPhotoModel.h"

@implementation JHPhotoModel




-(void)setAsset:(PHAsset *)asset{
    
    
    _asset = asset;

    
//    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(1, 1) contentMode:PHImageContentModeAspectFit options:[PHImageRequestOptions new] resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
//        
//        NSLog(@"%@",info);
//        
//        
//    }];
    
//    
//    PHFetchResult *result = 
//    [[PHImageManager defaultManager] requestImageDataForAsset:asset options:[PHImageRequestOptions new] resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
//       
//        NSLog(@"%@",info);
//        
//    }];
}


@end
