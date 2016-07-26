//
//  JHSepecialEffectVC.m
//  M_TShowShow
//
//  Created by 简豪 on 16/7/25.
//  Copyright © 2016年 JH. All rights reserved.
//

#import "JHSepecialEffectVC.h"
#import "JHFilterMatrix.h"
#import "JHFeilterManager.h"
@interface JHSepecialEffectVC ()
@property(nonatomic,strong)UIImageView *currentImgView;
@property (nonatomic,strong)CJCustomeButtonForDark * nowSelectBtn;
@property (nonatomic,strong)__block UIImage * selfImage;
@property (nonatomic,strong)NSArray * drawImagArr;

@end

@implementation JHSepecialEffectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self hideTheBackBtnWithDescStr:@"返回"];
    [self configBaseImgView];
    
    
    // Do any additional setup after loading the view.
}
#pragma mark---------------------------------------->初始化基本视图
- (void)configBaseImgView{
    
    /*        初始化美化的图片         */
    _currentImgView = [[UIImageView alloc] init];

    [[PHImageManager defaultManager] requestImageForAsset:self.imageAsset targetSize:CGSizeMake(k_SCREEN_WIDTH,((CGFloat)self.imageAsset.pixelHeight)/self.imageAsset.pixelWidth*k_SCREEN_WIDTH) contentMode:PHImageContentModeAspectFill options:[PHImageRequestOptions new] resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        _currentImgView.contentMode = UIViewContentModeScaleAspectFit;
        _currentImgView.image = result;
        _selfImage = result;
    }];
    
    [self.view addSubview:_currentImgView];
    
    [_currentImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view.mas_top).with.offset(30);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.width.mas_equalTo(k_SCREEN_WIDTH);
        make.height.mas_equalTo(k_SCREEN_HEIGHT-30 - 100);
    }];
    NSArray *imageList = [JHImageManager findImageNameWithFirstFolderName:@"intelligentResurance" andSecondFolderName:@"normalIconList"];
    
    NSArray *heightedImageList = [JHImageManager findImageNameWithFirstFolderName:@"intelligentResurance" andSecondFolderName:@"HighlightedIconList"];
    NSArray *nameList = [JHImageManager findImageNameWithFirstFolderName:@"intelligentResurance" andSecondFolderName:@"titleList"];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    
    [self.view addSubview:scrollView];
    CGFloat itemsWid = 60;
    CGFloat spa = 10;
    
    scrollView.contentSize = CGSizeMake(spa+(spa+itemsWid)*(nameList.count-1)-5, 0);
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-40);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.width.mas_equalTo(k_SCREEN_WIDTH);
        make.height.mas_equalTo(50);
        
    }];
    /*        底部按钮         */
    for (NSInteger i = 0; i<nameList.count; i++) {
        CJCustomeButtonForDark *btn = [CJCustomeButtonForDark buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:imageList[i]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:heightedImageList[i]] forState:UIControlStateSelected];
        [btn setTitle:nameList[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:8];
        [scrollView addSubview:btn];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.tag = i ;
        [btn addTarget:self action:@selector(beautyTypeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i==0) {
            _nowSelectBtn = btn;
            _nowSelectBtn.selected = YES;
        }
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(scrollView.mas_top).with.offset(0);
            make.left.equalTo(scrollView.mas_left).with.offset((itemsWid+1)*i+spa);
            make.width.mas_equalTo(itemsWid-15);
            make.height.mas_equalTo(itemsWid-10);
        }];
        
        
    }
    
    
    NSArray *imgArr = @[@"btn_cancel_a",@"btn_ok_a"];
    

    
    /*        底部按钮         */
    for (NSInteger i = 0; i<imgArr.count; i++) {
        CJCustomeButtonForDark *btn = [CJCustomeButtonForDark buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:imgArr[i]] forState:UIControlStateNormal];

        btn.titleLabel.font = [UIFont systemFontOfSize:8];
        [self.view addSubview:btn];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.tag = i ;
        [btn addTarget:self action:@selector(cancelOrSaveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i==0) {
            _nowSelectBtn = btn;
            _nowSelectBtn.selected = YES;
        }
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.equalTo(self.view.mas_bottom).with.offset(10);
            if (i==0) {
               make.left.equalTo(self.view.mas_left).with.offset(10);
            }else{
               make.right.equalTo(self.view.mas_right).with.offset(-10);
            }
            
            make.width.mas_equalTo(itemsWid-10);
            make.height.mas_equalTo(itemsWid-10);
        }];
        
        
    }
    
}

#pragma mark---------------------->保存与取消按钮点击事件
- (void)cancelOrSaveBtnClick:(CJCustomeButtonForDark *)sender{
    
    if (sender.tag == 0) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        [self.navigationController popViewControllerAnimated:NO];
        
    }
    
    
    
}

#pragma mark---------------------------------------->底部美图分类按钮点击事件
- (void)beautyTypeBtnClick:(CJCustomeButtonForDark *)sender{
    _nowSelectBtn.selected  = NO;
    sender.selected = YES;
    _nowSelectBtn = sender;

    JHFeilterManager *manager = [JHFeilterManager new];
    float (*p)[20] = {colormatrix_huaijiu,colormatrix_heibai,colormatrix_lomo,colormatrix_danya,colormatrix_ruise,colormatrix_gete};

    if (sender.tag == 0) {
        self.currentImgView.image = _selfImage;
    }else
        self.currentImgView.image = [manager createImageWithImage:_selfImage andColorMatrix:p[sender.tag-1]];
    _currentImgView.contentMode = UIViewContentModeScaleAspectFit;
    NSLog(@"%@",_selfImage);
}


-(void)dealloc{
    
}

@end
