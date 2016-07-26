//
//  JHImageManager.m
//  M_TShowShow
//
//  Created by 简豪 on 16/6/14.
//  Copyright © 2016年 JH. All rights reserved.
//

#import "JHImageManager.h"

@implementation JHImageManager

+(id)manager{
    static JHImageManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[JHImageManager alloc] init];
        
    });
    return manager;
    
}


+(NSArray *)findImageNameWithFirstFolderName:(NSString *)FirstFolderName andSecondFolderName:(NSString *)folderName{
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ImageNamePlistFile" ofType:@"plist"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
    
    return [[dic valueForKey:FirstFolderName] valueForKey:folderName];
}

@end
