//
//  JHAlumShowCell.m
//  M_TShowShow
//
//  Created by cjatech-简豪 on 16/5/6.
//  Copyright © 2016年 JH. All rights reserved.
//

#import "JHAlumShowCell.h"
#import <Photos/Photos.h>
@interface JHAlumShowCell ()

@property (weak, nonatomic) IBOutlet UIImageView *coverImgView;

@property (weak, nonatomic) IBOutlet UILabel *alumNameLab;

@property (weak, nonatomic) IBOutlet UILabel *alumSubImgCountLab;


@end


@implementation JHAlumShowCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setCollection:(PHAssetCollection *)collection{
    
    _collection = collection;
    PHFetchResult *assetResult = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
    [[PHImageManager defaultManager] requestImageForAsset:assetResult.firstObject targetSize:_coverImgView.frame.size contentMode:PHImageContentModeDefault options:[PHImageRequestOptions new] resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
       
        _coverImgView.image = result;
        
    }];
    _alumNameLab.text = collection.localizedTitle;
    _alumSubImgCountLab.text = [NSString stringWithFormat:@"%ld张",assetResult.count];
    
    if (assetResult.count==0) {
        
        
        
        
    }
    
    _coverImgView.layer.borderColor = [UIColor whiteColor].CGColor;
    _coverImgView.layer.borderWidth = 1.0;
}


@end
