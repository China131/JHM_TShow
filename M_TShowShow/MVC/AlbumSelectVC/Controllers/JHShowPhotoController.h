//
//  JHShowPhotoController.h
//  M_TShowShow
//
//  Created by cjatech-简豪 on 16/5/9.
//  Copyright © 2016年 JH. All rights reserved.
//
/************************************************************
 *                                                           *
 *                                                           *
                        照片详情浏览界面
 *                                                           *
 *                                                           *
 ************************************************************/
#import "JHBaseViewController.h"
#import <Photos/Photos.h>
@interface JHShowPhotoController : JHBaseViewController


@property (nonatomic,strong) NSArray  * assetDataArr;
@property (assign , nonatomic) NSInteger  currentIndex ;
@end
