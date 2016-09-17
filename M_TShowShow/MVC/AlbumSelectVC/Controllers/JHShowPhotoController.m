//
//  JHShowPhotoController.m
//  M_TShowShow
//
//  Created by cjatech-简豪 on 16/5/9.
//  Copyright © 2016年 JH. All rights reserved.
//

#import "JHShowPhotoController.h"
#import "JHPhotoModel.h"
#import "JHPhotoShowCell.h"
@interface JHShowPhotoController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView * collectionView;
@property (nonatomic,strong) NSMutableArray * imageInfoDataArr;


@end

@implementation JHShowPhotoController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self hideTheBackBtnWithDescStr:@"返回"];
    [self showTheTakePhotosBtn];
    [self configBaseCollectionView];
    [self configBaseButtomView];
    [self setTheTitleWithString:[NSString stringWithFormat:@"%ld/%ld",_currentIndex+1,_assetDataArr.count]];

}


#pragma mark---------------------------------------->初始化按钮
- (void)configBaseButtomView{
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = CGRectMake(0, k_SCREEN_HEIGHT-39, k_SCREEN_WIDTH, 39);
    
    [btn setTitle:@"进入美化图片" forState:UIControlStateNormal];
    
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    btn.backgroundColor = [UIColor colorWithRed:31.0/256 green:137.0/256.0 blue:251.0/256 alpha:1];
    
    [btn addTarget:self action:@selector(forPerfectBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
}


#pragma mark---------------------------------------->进入图片美化按钮点击事件
- (void)forPerfectBtnClick{
    
    
}


#pragma mark---------------------------------------->基本流视图构建
- (void)configBaseCollectionView{
    
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.minimumLineSpacing = 0;
    flow.minimumInteritemSpacing = 0;
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, k_SCREEN_WIDTH, k_SCREEN_HEIGHT-64-49) collectionViewLayout:flow];
    
    _collectionView.delegate = self;
    
    _collectionView.dataSource = self;
    
    _collectionView.pagingEnabled = YES;
    
    _collectionView.backgroundColor = [UIColor blackColor];
   
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    
    [self updateTheCurrentIndex];
    
    [_collectionView registerNib:[UINib nibWithNibName:@"JHPhotoShowCell" bundle:nil] forCellWithReuseIdentifier:@"photoShow"];
    
    [self.view addSubview:_collectionView];
}

#pragma mark---------------------------------------->更新图片索引
- (void)updateTheCurrentIndex{
    
    NSIndexPath *path = [[_collectionView indexPathsForVisibleItems] firstObject];
    
    [self setTheTitleWithString:[NSString stringWithFormat:@"%ld/%ld",path.row+1,_assetDataArr.count]];
}

#pragma mark----------------------------------------> UICollectionView相关代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    return _assetDataArr.count;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(k_SCREEN_WIDTH, k_SCREEN_HEIGHT-64-49);
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    JHPhotoShowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photoShow" forIndexPath:indexPath];
   
    cell.asset = _assetDataArr[indexPath.row];
    return cell;
    
}


#pragma mark---------------------------------------->更新索引触发事件
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    
    [self updateTheCurrentIndex];
    
}



-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self updateTheCurrentIndex];
}

-(void)dealloc{
    
    
}

@end
