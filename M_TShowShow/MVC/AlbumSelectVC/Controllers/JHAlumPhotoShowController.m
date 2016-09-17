//
//  JHAlumPhotoShowController.m
//  M_TShowShow
//
//  Created by cjatech-简豪 on 16/5/6.
//  Copyright © 2016年 JH. All rights reserved.
//

#import "JHAlumPhotoShowController.h"
#import "PhotoCollectionItem.h"
#import "JHBeautifyPhotoController.h"
#import "JHShowPhotoController.h"
@interface JHAlumPhotoShowController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView * collectionView;

@property (nonatomic,strong) NSMutableArray * photoAssetArr;
@end

@implementation JHAlumPhotoShowController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showTheMainScreenBtnAndTitleString:_collection.localizedTitle];
    [self hideTheBackBtnWithDescStr:@"相册"];
    [self configBaseData];
    [self configBaseCollectionView];
}



- (void)configBaseCollectionView{
    
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.minimumLineSpacing = 3;
    flow.minimumInteritemSpacing = 3;
    
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, k_SCREEN_WIDTH, k_SCREEN_HEIGHT-64) collectionViewLayout:flow];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView registerNib:[UINib nibWithNibName:@"PhotoCollectionItem" bundle:nil] forCellWithReuseIdentifier:@"photositems"];
    [self.view addSubview:_collectionView];
    
}


- (void)configBaseData{
    
    _photoAssetArr = [NSMutableArray array];
    
    PHFetchResult *result = [PHAsset fetchAssetsInAssetCollection:_collection options:nil];
    
    for (PHAsset *collection in result) {
        
        [_photoAssetArr addObject:collection];
        
    }
    
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _photoAssetArr.count;
}

//设置每个item的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    //
    return CGSizeMake((k_SCREEN_WIDTH - 3*4)/3, (k_SCREEN_WIDTH - 3*4)/3);
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(2, 2, 2, 2);
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    __weak typeof(self) weakSelf = self;
    PhotoCollectionItem *items = [collectionView dequeueReusableCellWithReuseIdentifier:@"photositems" forIndexPath:indexPath];
    items.collection = _photoAssetArr[indexPath.row];
    items.tag = indexPath.row;
    items.scalue = ^(NSInteger selectAsset){
      
        JHShowPhotoController *show = [JHShowPhotoController new];
        show.assetDataArr = weakSelf.photoAssetArr;
        show.currentIndex = selectAsset;
        [weakSelf.navigationController pushViewController:show animated:YES];
        
    };
    return items;
    
    
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
//    PHAsset *asset = _photoAssetArr[indexPath.row];
//    
//    [[PHImageManager defaultManager] requestImageDataForAsset:asset options:[PHImageRequestOptions new] resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
//        CFDataRef ref = (__bridge CFDataRef)imageData;
//        CGImageSourceRef imagRef = CGImageSourceCreateWithData(ref, NULL);
//        NSDictionary *dic = (__bridge NSDictionary *)CGImageSourceCopyPropertiesAtIndex(imagRef, 0, NULL);
//        NSLog(@"%@",dic);
//        
//    }];
//    
//    
//    return;
    
    JHBeautifyPhotoController *beautify = [JHBeautifyPhotoController new];
    beautify.currentAsset = _photoAssetArr[indexPath.row];
    [self.navigationController pushViewController:beautify animated:YES];
    
    
}


-(void)dealloc{
    
    
    
}

@end
