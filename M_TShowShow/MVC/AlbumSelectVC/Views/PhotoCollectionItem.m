//
//  PhotoCollectionItem.m
//  M_TShowShow
//
//  Created by cjatech-简豪 on 16/5/9.
//  Copyright © 2016年 JH. All rights reserved.
//

#import "PhotoCollectionItem.h"

#import <Photos/Photos.h>
@interface PhotoCollectionItem ()


@property (weak, nonatomic) IBOutlet UIImageView *smallImgView;




@end


@implementation PhotoCollectionItem

- (void)awakeFromNib {
    // Initialization code
}


- (IBAction)scaleBtnClick:(id)sender {
    
    if (_scalue) {
        _scalue(self.tag);
    }
    
}


-(void)setCollection:(PHAsset *)collection{
    
    
    _collection = collection;
    


    [[PHImageManager defaultManager] requestImageForAsset:collection targetSize:CGSizeMake(k_SCREEN_WIDTH/3, k_SCREEN_HEIGHT/3) contentMode:PHImageContentModeAspectFit options:[PHImageRequestOptions new] resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
       
        _smallImgView.image = result;
        
    }];

    
}

@end
