//
//  JHPhotoModel.h
//  M_TShowShow
//
//  Created by cjatech-简豪 on 16/5/10.
//  Copyright © 2016年 JH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
@interface JHPhotoModel : NSObject

@property (copy, nonatomic) NSString * photoName;
@property (assign , nonatomic) CGSize  photoOriginSize;
@property (assign , nonatomic) CGSize  photoScaleSize ;
@property (nonatomic,strong) PHAsset * asset;


@end
