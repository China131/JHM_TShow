//
//  JHPhotoShowCell.m
//  M_TShowShow
//
//  Created by cjatech-简豪 on 16/5/10.
//  Copyright © 2016年 JH. All rights reserved.
//

#import "JHPhotoShowCell.h"

@interface JHPhotoShowCell ()<UIScrollViewDelegate>


@property (weak, nonatomic) IBOutlet UIScrollView *currentScrollView;

@property (nonatomic,strong) UIImageView * showImgView;



@end


@implementation JHPhotoShowCell

- (void)awakeFromNib {

    _showImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
 
    _showImgView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
  
    _currentScrollView.maximumZoomScale = 3.0;
    _currentScrollView.minimumZoomScale = 1.0;
    _currentScrollView.delegate = self;
    [_currentScrollView addSubview:_showImgView];
    
    
}


-(void)setAsset:(PHAsset *)asset{
    
    _asset = asset;
    
    CGSize size = [self configPerproSizeWithAsset:asset];
    
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeAspectFit options:[PHImageRequestOptions new] resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
       
        _showImgView.contentMode = UIViewContentModeScaleToFill;
        _showImgView.image = result;
        
    }];
    [_currentScrollView setZoomScale:1.0];
    _currentScrollView.contentSize = CGSizeZero;
    CGSize size2 = [self configPerproSize2WithAsset:asset];
    
    _showImgView.frame = CGRectMake(0, 0, size2.width, size2.height);
    _showImgView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    tap.numberOfTapsRequired = 2;
    _showImgView.userInteractionEnabled = YES;
    [_showImgView addGestureRecognizer:tap];
  
}

- (void)tap{
    
    NSLog(@"tap");
    
    NSLog(@"%f",_currentScrollView.zoomScale);
    if (_currentScrollView.zoomScale!=1.0) {
        [_currentScrollView setZoomScale:1.0 animated:YES];
    }else{
        [_currentScrollView setZoomScale:3.0 animated:YES];
    }
    
}



- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    
    return _showImgView;
}

- (CGSize)configPerproSizeWithAsset:(PHAsset *)asset{
    
    CGFloat H_Scale = asset.pixelHeight/(k_SCREEN_HEIGHT-64 - 50);
    CGFloat W_Scale = asset.pixelWidth/k_SCREEN_WIDTH;
    
    if (H_Scale>W_Scale&&H_Scale>=1) {
        
        return CGSizeMake(2.0*asset.pixelWidth/asset.pixelHeight*(k_SCREEN_HEIGHT - 64 -50), (k_SCREEN_HEIGHT-64 - 50)*2);
        
    }else if (W_Scale>H_Scale&&W_Scale>=1){
        return CGSizeMake((k_SCREEN_WIDTH-30)*2, 2.0*asset.pixelHeight/asset.pixelWidth * (k_SCREEN_WIDTH - 30));
    }
    
    
    return CGSizeMake(asset.pixelWidth, asset.pixelHeight);
    
}


- (CGSize)configPerproSize2WithAsset:(PHAsset *)asset{
    
    CGFloat H_Scale = asset.pixelHeight/(k_SCREEN_HEIGHT-64 - 50);
    CGFloat W_Scale = asset.pixelWidth/k_SCREEN_WIDTH;
    
    if (H_Scale>W_Scale&&H_Scale>=1) {
        
        return CGSizeMake(1.0*asset.pixelWidth/asset.pixelHeight*(k_SCREEN_HEIGHT - 64 -50), (k_SCREEN_HEIGHT-64 - 50)*1);
        
    }else if (W_Scale>H_Scale&&W_Scale>=1){
        return CGSizeMake((k_SCREEN_WIDTH-30)*1, 1.0*asset.pixelHeight/asset.pixelWidth * (k_SCREEN_WIDTH - 30));
    }
    
    
    return CGSizeMake(asset.pixelWidth, asset.pixelHeight);
    
}

-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    
    
    if (scale>1.0) {
        
        _currentScrollView.contentSize = CGSizeMake(_currentScrollView.frame.size.width * scale, _currentScrollView.frame.size.height * scale);
        
    }else{
        _currentScrollView.contentSize = CGSizeZero;
    }
    
}

@end
