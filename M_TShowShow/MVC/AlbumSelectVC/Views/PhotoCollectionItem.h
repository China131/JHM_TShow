//
//  PhotoCollectionItem.h
//  M_TShowShow
//
//  Created by cjatech-简豪 on 16/5/9.
//  Copyright © 2016年 JH. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PHAsset;
typedef void(^scaleBlock)(NSInteger selectAsset);


@interface PhotoCollectionItem : UICollectionViewCell


@property (nonatomic,strong) PHAsset * collection;

@property (copy, nonatomic) scaleBlock scalue;
@end
