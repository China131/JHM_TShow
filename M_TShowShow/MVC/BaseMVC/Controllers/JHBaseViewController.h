//
//  JHBaseViewController.h
//  M_TShowShow
//
//  Created by cjatech-简豪 on 16/4/21.
//  Copyright © 2016年 JH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHBaseViewController : UIViewController
- (void)showTheMainScreenBtnAndTitleString:(NSString *)titles;

- (void)hideTheBackBtnWithDescStr:(NSString *)str;

- (void)showTheTakePhotosBtn;

- (void)setTheTitleWithString:(NSString *)titles;
@end
