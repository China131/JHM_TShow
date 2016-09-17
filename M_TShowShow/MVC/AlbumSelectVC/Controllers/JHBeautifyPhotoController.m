//
//  JHBeautifyPhotoController.m
//  M_TShowShow
//
//  Created by cjatech-简豪 on 16/5/9.
//  Copyright © 2016年 JH. All rights reserved.
//

#import "JHBeautifyPhotoController.h"
#import "CJCustomeButtonForDark.h"
#import "JHBeautifyBaseVC.h"
#import "JHIntelligentBeautifyVC.h"
#import "JHSepecialEffectVC.h"

#import "JHEditViewController.h"
@interface JHBeautifyPhotoController ()


@property (nonatomic,strong)UIImageView *currentImgView;
@property (nonatomic,strong)CJCustomeButtonForDark * nowSelectBtn;


@end

@implementation JHBeautifyPhotoController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self hideTheBackBtnWithDescStr:@"返回"];
    [self configBaseImgView];
    
}

#pragma mark---------------------------------------->初始化基本视图
- (void)configBaseImgView{
    __weak typeof(self) weakSelf = self;
    /*        初始化美化的图片         */
    _currentImgView = [[UIImageView alloc] init];
    
    [[PHImageManager defaultManager] requestImageForAsset:_currentAsset targetSize:CGSizeMake(k_SCREEN_WIDTH,((CGFloat)_currentAsset.pixelHeight)/_currentAsset.pixelWidth*k_SCREEN_WIDTH) contentMode:PHImageContentModeDefault options:[PHImageRequestOptions new] resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        weakSelf.currentImgView.contentMode = UIViewContentModeScaleAspectFit;
        weakSelf.currentImgView.image = result;
        
    }];

    [self.view addSubview:_currentImgView];
    
    [_currentImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.view.mas_top).with.offset(0);
        make.left.equalTo(weakSelf.view.mas_left).with.offset(0);
        make.width.mas_equalTo(k_SCREEN_WIDTH);
        make.height.mas_equalTo(k_SCREEN_HEIGHT-64);
    }];
    
    
    
    /*        初始化底部视图 其中图片资源并未归档 因此代码量较大  其他页面有相应的归档图片文件 查询图片较为方便简洁         */
    NSArray *normalImageViewImageArr = [NSArray arrayWithObjects:@"icon_function_autoBeauty_a",
                                        @"icon_function_edit_a@2x.png", @"icon_function_color_a@2x.png", @"icon_function_stylize_a@2x.png",
                                        @"icon_function_border_a@2x.png", @"icon_function_mohuanbi_a@2x.png", @"icon_function_mosaic_a@2x.png",
                                        @"icon_function_text_a@2x.png", @"icon_function_bokeh_a@2x.png",
                                        nil];
    NSArray *hightlightedImageViewImageArr = [NSArray arrayWithObjects:@"icon_function_autoBeauty_b@2x.png",
                                              @"icon_function_edit_b@2x.png", @"icon_function_color_b@2x.png", @"icon_function_stylize_b@2x.png",
                                              @"icon_function_border_b@2x.png", @"icon_function_mohuanbi_b@2x.png", @"icon_function_mosaic_b@2x.png",
                                              @"icon_function_text_b@2x.png", @"icon_function_bokeh_b@2x.png",
                                              nil];
    NSArray *textArr = [NSArray arrayWithObjects:@"智能优化", @"编辑", @"增强", @"特效", @"边框", @"魔幻笔", @"马赛克", @"文字", @"背景虚化", nil];

    UIScrollView *scrollView = [[UIScrollView alloc] init];

     [self.view addSubview:scrollView];
    CGFloat itemsWid = 50;
    CGFloat spa = 10;
    
    scrollView.contentSize = CGSizeMake(spa+(spa+itemsWid)*(textArr.count-1), 0);
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.equalTo(weakSelf.view.mas_bottom).with.offset(0);
        make.left.equalTo(weakSelf.view.mas_left).with.offset(0);
        make.width.mas_equalTo(k_SCREEN_WIDTH-60);
        make.height.mas_equalTo(50);
        
    }];
    /*        底部按钮         */
    for (NSInteger i = 0; i<textArr.count; i++) {
        CJCustomeButtonForDark *btn = [CJCustomeButtonForDark buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:normalImageViewImageArr[i]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:hightlightedImageViewImageArr[i]] forState:UIControlStateSelected];
        [btn setTitle:textArr[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:8];
         [scrollView addSubview:btn];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.tag = i ;
        [btn addTarget:self action:@selector(beautyTypeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(scrollView.mas_top).with.offset(0);
            make.left.equalTo(scrollView.mas_left).with.offset((itemsWid+1)*i+spa);
            make.width.mas_equalTo(itemsWid);
            make.height.mas_equalTo(itemsWid);
        }];
    }

    CJCustomeButtonForDark *btns = [CJCustomeButtonForDark buttonWithType:UIButtonTypeCustom];
    [btns setTitle:@"去美容" forState:UIControlStateNormal];
    [btns setImage:[UIImage imageNamed:@"icon_share_cosmesis"] forState:UIControlStateNormal];
    btns.titleLabel.font = [UIFont systemFontOfSize:8];
    btns.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    btns.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:btns];
    
    
    [btns mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.equalTo(weakSelf.view.mas_bottom);
        make.right.equalTo(weakSelf.view.mas_right);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(50);
        
    }];
    
    
    UIView *lineV = [[UIView alloc] init];
    lineV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:lineV];
    
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.equalTo(weakSelf.view.mas_bottom).with.offset(3);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(57);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(50);
        
    }];
    
    
}

#pragma mark---------------------------------------->底部美图分类按钮点击事件
- (void)beautyTypeBtnClick:(CJCustomeButtonForDark *)sender{
    _nowSelectBtn.selected  = NO;
    sender.selected = YES;
    _nowSelectBtn = sender;
    NSArray *mvcList = @[@"JHIntelligentBeautifyVC",@"JHEditViewController",@"JHIntelligentBeautifyVC",@"JHSepecialEffectVC",@"JHIntelligentBeautifyVC",@"JHIntelligentBeautifyVC",@"",@"JHIntelligentBeautifyVC",@"JHIntelligentBeautifyVC",@"JHIntelligentBeautifyVC"];
    JHBeautifyBaseVC *base = [[NSClassFromString(mvcList[sender.tag]) alloc] init];
    
    base.imageAsset = _currentAsset;
    
    base.baseBlock = ^(id obj){
        
        
    };
    [self hideTheNavigationBarWithAnimation:YES];
    [self.navigationController pushViewController:base animated:NO];
    
    
}


-(void)dealloc{
    
    
}

@end
