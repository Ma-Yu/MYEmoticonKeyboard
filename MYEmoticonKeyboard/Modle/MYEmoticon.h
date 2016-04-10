//
//  MYEmoticon.h
//  表情键盘
//
//  Created by MY❤️mqq on 16/4/7.
//  Copyright © 2016年 MY❤️mqq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYEmoticon : NSObject
/** 普通表情对应的图片名称 **/
@property (nonatomic, strong) NSString *png;
/** 普通表情对应的文字 **/
@property (nonatomic, strong) NSString *chs;
// png的全路径
@property (nonatomic, strong) NSString *pngPath;
// emoji对应可以展示的字符串
@property (nonatomic, strong) NSString *codeString;

@property (nonatomic, assign, getter=isEmpty) BOOL empty;
@property (nonatomic, assign, getter=isRemove) BOOL remove;

- (__kindof MYEmoticon *)initWithDict:(NSDictionary *)dict;

+ (__kindof MYEmoticon *)emotionWithDict:(NSDictionary *)dict;

- (__kindof MYEmoticon *)initWithIsEmpty:(BOOL)isEmpty;
- (__kindof MYEmoticon *)initWithIsRemove:(BOOL)isRemove;

@end
