//
//  JHBaseViewController.h
//  M_TShowShow
//
//  Created by cjatech-简豪 on 16/4/21.
//  Copyright © 2016年 JH. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^JH_BASE_BLOCK) (id obj);
@interface JHBaseViewController : UIViewController

/*        公共回调block         */
@property (nonatomic,copy)JH_BASE_BLOCK  baseBlock;


/*        <##>         */
- (void)showTheMainScreenBtnAndTitleString:(NSString *)titles;

- (void)hideTheBackBtnWithDescStr:(NSString *)str;

- (void)showTheTakePhotosBtn;

- (void)setTheTitleWithString:(NSString *)titles;

- (void)hideTheNavigationBarWithAnimation:(BOOL)animation;
@end
