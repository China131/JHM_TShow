//
//  JHBaseViewController.m
//  M_TShowShow
//
//  Created by cjatech-简豪 on 16/4/21.
//  Copyright © 2016年 JH. All rights reserved.
//

#import "JHBaseViewController.h"

@interface JHBaseViewController ()

@end

@implementation JHBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.view.backgroundColor = [UIColor blackColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)backToMainScreen{
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)showTheMainScreenBtnAndTitleString:(NSString *)titles{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = CGRectMake(0, 0, 50, 25);
    
    [btn setImage:[UIImage imageNamed:@"icon_btn_home_a"] forState:UIControlStateNormal];
    
    [btn setTitle:@"首页" forState:UIControlStateNormal];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
    btn.titleLabel.textAlignment = NSTextAlignmentLeft;
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn addTarget:self action:@selector(backToMainScreen) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    if (titles.length==0) {
        return;
    }
    
    [self setTheTitleWithString:titles];
    
    [self showTheTakePhotosBtn];
  
    
}


- (void)setTheTitleWithString:(NSString *)titles{
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    lab.text = titles;
    lab.font = [UIFont systemFontOfSize:14];
    lab.textColor = [UIColor whiteColor];
    lab.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = lab;
    
    
}



- (void)showTheTakePhotosBtn{
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn1.frame = CGRectMake(0, 0, 50, 25);
    
    [btn1 setImage:[UIImage imageNamed:@"icon_btn_camera_b"] forState:UIControlStateNormal];
    
    [btn1 setTitle:@"拍照" forState:UIControlStateNormal];
    [btn1 setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [btn1 setTitleEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
    [btn1 setTitleColor:[UIColor colorWithRed:21/256.0 green:147/256.0 blue:262/256.0 alpha:1] forState:UIControlStateNormal];
    btn1.titleLabel.textAlignment = NSTextAlignmentLeft;
    btn1.titleLabel.font = [UIFont systemFontOfSize:12];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn1];
}


- (void)hideTheBackBtnWithDescStr:(NSString *)str{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = CGRectMake(0, 0, 50, 25);
    
    [btn setImage:[UIImage imageNamed:@"icon_back_a"] forState:UIControlStateNormal];
    
    [btn setTitle:str forState:UIControlStateNormal];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
    btn.titleLabel.textAlignment = NSTextAlignmentLeft;
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
     [btn addTarget:self action:@selector(backToMainScreen) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    
}

@end
