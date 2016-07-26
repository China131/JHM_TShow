//
//  JHAlbumSelectController.m
//  M_TShowShow
//
//  Created by cjatech-简豪 on 16/4/22.
//  Copyright © 2016年 JH. All rights reserved.
//

#import "JHAlbumSelectController.h"
#import <Photos/Photos.h>
#import "JHAlumShowCell.h"
#import "JHAlumPhotoShowController.h"
@interface JHAlbumSelectController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableView;

@property (nonatomic,strong) PHFetchResult * allAblubResult;

@property (nonatomic,strong) NSMutableArray * deviceAlumDataArr;
@end

@implementation JHAlbumSelectController


#pragma mark---------------------------------------->初始化基本视图
- (void)comfigBaseTableView{
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, k_SCREEN_WIDTH, k_SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorColor = [UIColor blackColor];

    _tableView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_tableView];
   
}


#pragma mark---------------------------------------->初始化相册集合
- (void)configBaseData{
    
    /*        相册配置  使用默认即可         */
    PHFetchOptions *fetchOptions = [PHFetchOptions new];
    
    /*        初始化相册数组         */
    _deviceAlumDataArr = [NSMutableArray array];
    
    /* 获取系统创建的相册 */
    PHFetchResult *smartAlbumFetchResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAny options:fetchOptions];
    _allAblubResult = smartAlbumFetchResult;
    
    /*        遍历系统创建相册结果集         */
    for (PHAssetCollection *sub in smartAlbumFetchResult) {
        PHFetchResult *result = [PHAsset fetchAssetsInAssetCollection:sub options:nil];
        
        if (result.count==0) {
            continue;
        }
        
        /*        添加具体相册到相册数组         */
        [_deviceAlumDataArr addObject:sub];
        
    }
    
    /*        获取所有的用户创建相册         */
    PHFetchResult *smartAlbumFetchResult2 = [PHAssetCollection fetchTopLevelUserCollectionsWithOptions:nil];
    
    /*        遍历用户自建相册结果集         */
    for (PHAssetCollection *sub in smartAlbumFetchResult2) {
        
        PHFetchResult *result = [PHAsset fetchAssetsInAssetCollection:sub options:nil];
        
        if (result.count==0) {
            continue;
        }
        /*        添加具体相册到相册数组         */
        [_deviceAlumDataArr addObject:sub];
        
    }
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];

     self.view.backgroundColor = [UIColor blackColor];
    [self showTheMainScreenBtnAndTitleString:@"选择照片"];
    
  
    [self configBaseData];
    
    [self comfigBaseTableView];
    

    
    
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _deviceAlumDataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    JHAlumShowCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShowCell"];
    
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"JHAlumShowCell" owner:self options:nil][0];
    }
    
    cell.collection = _deviceAlumDataArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
  
    return cell;
    
    

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 90;
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        cell.separatorInset = UIEdgeInsetsZero;
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        cell.layoutMargins = UIEdgeInsetsZero;
    }
    
    
    
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PHAssetCollection *collection = _deviceAlumDataArr[indexPath.row];
    
    JHAlumPhotoShowController *photoShow = [JHAlumPhotoShowController new];
    
    photoShow.collection = collection;
    
    [self.navigationController pushViewController:photoShow animated:YES];
    
}


@end
