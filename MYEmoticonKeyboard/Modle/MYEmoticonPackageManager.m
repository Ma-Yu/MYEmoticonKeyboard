//
//  MYEmoticonPackageManager.m
//  表情键盘
//
//  Created by MY❤️mqq on 16/4/7.
//  Copyright © 2016年 MY❤️mqq. All rights reserved.
//


#import "MYEmoticonPackageManager.h"
#import "MYEmoticonPackage.h"

@implementation MYEmoticonPackageManager
#pragma mark - 懒加载
- (NSMutableArray<MYEmoticonPackage *> *)packages{
    if (!_packages) {
        _packages = [NSMutableArray array];
    }
    return _packages;
}

#pragma mark - 系统方法重写
-(instancetype)init{
    if (self = [super init]) {
        // 最近使用表情分组
        [self.packages addObject:[[MYEmoticonPackage alloc] initWithID:@""]];
        
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"emoticons.plist" ofType:nil inDirectory:@"Emoticons.bundle"];
        NSDictionary *emoticonsDict = [NSDictionary dictionaryWithContentsOfFile:plistPath];
        
        NSDictionary *packageDicts = emoticonsDict[@"packages"];
        
        for (NSDictionary *packgeDict in packageDicts) {
            NSString *ID = packgeDict[@"id"];
            MYEmoticonPackage *package = [[MYEmoticonPackage alloc] initWithID:ID];
            
            [self.packages addObject:package];
        }
    }
    return self;
}


@end
