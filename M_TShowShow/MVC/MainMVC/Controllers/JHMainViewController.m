//
//  JHMainViewController.m
//  M_TShowShow
//
//  Created by cjatech-简豪 on 16/4/21.
//  Copyright © 2016年 JH. All rights reserved.
//

#import "JHMainViewController.h"
#import "JHCustomerMainButton.h"
#import "JHAlbumSelectController.h"
@interface JHMainViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIButton * leftBtn;

@property (nonatomic,strong) UIButton * rightBtn;

@property (nonatomic,strong) UIScrollView * meumScrollView;
@end

@implementation JHMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configBackgroundView];
    

    
    
}




- (void)configBackgroundView
{
    /* 背景图 */
    UIImageView *img = [[UIImageView alloc] init];
    img.image = [UIImage imageNamed:@"bg_home_defaultRandom@3x.jpg"];
    [self.view addSubview:img];
    
    
    /* logo图标 */
    UIImageView *logoImg = [[UIImageView alloc] init];
    logoImg.image = [UIImage imageNamed:@"mtxx_logo"];

    
    
    /* 滚动视图 */
    UIScrollView *bgScrollView = [[UIScrollView alloc] init];
    bgScrollView.backgroundColor = [UIColor clearColor];
    bgScrollView.contentSize = CGSizeMake(k_SCREEN_WIDTH*2, 0);
    bgScrollView.showsHorizontalScrollIndicator = NO;
    bgScrollView.pagingEnabled = YES;
    bgScrollView.delegate = self;
    _meumScrollView = bgScrollView;
    
    
    [self.view addSubview:logoImg];
    [self.view addSubview:bgScrollView];
    
    
    
    /* 关键图标数组 */
    NSArray *imgListArr = @[@"icon_home_beauty",
                            @"icon_home_cosmesis",
                            @"icon_home_puzzle",
                            @"icon_home_camera",
                            @"icon_home_material",
                            @"icon_app_bqgc",
                            @"icon_home_meiyan",
                            @"icon_home_meipai",
                             @"icon_home_moreapp",
                            @"icon_app_pomelo"
                            ];
    
    
    /* 背景图标数组 */
    NSArray *backList = @[@"home_block_red_a",
                          @"home_block_pink_b",
                          @"home_block_green_a",
                          @"home_block_blue_a",
                          @"home_block_orange_a",
                          @"home_block_pink_b",
                          @"home_block_pink_b",
                          @"home_block_red_a",
                          @"home_block_blue_a",
                          @"home_block_green_a"
                          ];
    
    
    /* 按钮内容 */
    NSArray *titleList = @[@"美化图片",
                           @"人像美容",
                           @"拼图",
                           @"相机",
                           @"素材中心",
                           @"",
                           @"美颜相机",
                           @"美拍",
                           @"更多功能",
                           @""];
    
    
    /* 按钮的宽度  间距 */
    CGFloat wid = 90;
    CGFloat spa = 20;
    CGFloat preAndEnd = (k_SCREEN_WIDTH - wid*2 - spa)/2;
    
    
    
    /* 循环添加按钮到滚动视图上 */
    for (NSInteger i = 0; i<imgListArr.count; i++) {
        JHCustomerMainButton *btn = [JHCustomerMainButton buttonWithType:UIButtonTypeCustom];
        if (i==5||i==9) {
            btn = [UIButton buttonWithType:UIButtonTypeCustom];
        }
        [btn setImage:[UIImage imageNamed:imgListArr[i]] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:backList[i]] forState:UIControlStateNormal];
        [bgScrollView addSubview:btn];
        [btn setTitle:titleList[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(menuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        /* 调整 */
        btn.titleLabel.font = [UIFont systemFontOfSize:10];
        btn.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.tag = i;
        
        /* 行列 */
        NSInteger row = i/2;
        NSInteger col = i%2;
        if (i<6) {
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(bgScrollView.mas_top).with.offset(spa+row*wid);
                make.left.equalTo(bgScrollView.mas_left).with.offset(preAndEnd+(wid + spa)*col);
                make.width.mas_equalTo(wid);
                make.height.mas_equalTo(wid);
            }];
            
        }else{
            row -= 3;
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.top.equalTo(bgScrollView.mas_top).with.offset(spa+row*wid);
                make.left.equalTo(bgScrollView.mas_left).with.offset(preAndEnd+(wid + spa)*col+k_SCREEN_WIDTH);
                make.width.mas_equalTo(wid);
                make.height.mas_equalTo(wid);
            }];
        }
        
    }
    
    
    /* 左右按钮 */
    NSArray *leftAndRightList = @[@"left_arrow",@"right_arrow"];
    for (NSInteger i = 0; i<2; i++) {
        
        UIButton *leftOrRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [leftOrRightBtn setImage:[UIImage imageNamed:leftAndRightList[i]] forState:UIControlStateNormal];
        leftOrRightBtn.tag = i;
        [leftOrRightBtn addTarget:self action:@selector(leftOrRightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i==0) {
            _leftBtn = leftOrRightBtn;
            _leftBtn.alpha = 0;
        }else{
            _rightBtn = leftOrRightBtn;
        }
        [self.view addSubview:leftOrRightBtn];
        [leftOrRightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self.view.mas_left).with.offset(10+i*(k_SCREEN_WIDTH-40));
            make.top.equalTo(self.view.mas_top).with.offset(k_SCREEN_HEIGHT/2-20);
            make.width.mas_equalTo(20);
            make.height.mas_equalTo(40);
            
        }];
    }
    
    
    
    
    
    
    /* 添加约束 */
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.view);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.width.mas_equalTo(k_SCREEN_WIDTH);
        make.height.mas_equalTo(k_SCREEN_HEIGHT);
    }];
    
    
    [logoImg mas_makeConstraints:^(MASConstraintMaker *make) {
      
        make.top.equalTo(self.view.mas_top).with.offset(50);
        make.left.equalTo(self.view.mas_left).with.offset(15);

        make.width.mas_equalTo(200);
        make.height.mas_equalTo( 158.0/500*200);
    }];
    
    
    [bgScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(logoImg.mas_bottom).with.offset(10);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-100);
        make.width.mas_equalTo(k_SCREEN_WIDTH);
        make.height.mas_equalTo( 158.0/500*200);
    }];
    
   
}



#pragma mark -------------> 菜单按钮点击事件
- (void)menuBtnClick:(UIButton *)sender{
    
    
    
    [self.navigationController pushViewController:[JHAlbumSelectController new] animated:YES];
    
    
    
    
    
}





#pragma mark -------------> 左右按钮点击事件
- (void)leftOrRightBtnClick:(UIButton *)sender{
    
    if (sender.tag==0) {
        
        [_meumScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        
    }else{
        
        [_meumScrollView setContentOffset:CGPointMake(k_SCREEN_WIDTH, 0) animated:YES];
        
    }
    
}







#pragma mark -------------> bgScrollView 代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.x<=k_SCREEN_WIDTH) {
        _leftBtn.alpha =  1-(k_SCREEN_WIDTH - scrollView.contentOffset.x)/20.0;
        _rightBtn.alpha = 1- _leftBtn.alpha;
    }else{
     
    }
    
}
































@end
