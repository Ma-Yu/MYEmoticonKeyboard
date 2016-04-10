//
//  MYEmoticon.m
//  表情键盘
//
//  Created by MY❤️mqq on 16/4/7.
//  Copyright © 2016年 MY❤️mqq. All rights reserved.
//

#import "MYEmoticon.h"

@interface MYEmoticon ()
/** emoji对应的code **/
@property (nonatomic, strong) NSString *code;


@end

@implementation MYEmoticon

#pragma mark - set方法
- (void)setCode:(NSString *)code{
    _code = code;
    
    NSScanner *scanner = [NSScanner scannerWithString:code];
    unsigned int value = 0;
    [scanner scanHexInt:&value];
    
    UTF32Char inputChar = value;
//    inputChar = NSSwapHostIntToLittle(inputChar);
    
    self.codeString = [[NSString alloc] initWithBytes:&inputChar length:4 encoding:NSUTF32LittleEndianStringEncoding];
}

- (void)setPng:(NSString *)png{
    _png = png;
    
    NSString *bundlePath = [NSBundle mainBundle].bundlePath;
    self.pngPath = [NSString stringWithFormat:@"%@/Emoticons.bundle/%@", bundlePath, png];
}

#pragma mark - 自定义快速创建方法
- (MYEmoticon *)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (MYEmoticon *)emotionWithDict:(NSDictionary *)dict{
    
    return [[self alloc] initWithDict:dict];
}

-(MYEmoticon *)initWithIsEmpty:(BOOL)isEmpty{
    if (self = [super init]) {
        self.empty = isEmpty;
    }
    return self;
}

-(MYEmoticon *)initWithIsRemove:(BOOL)isRemove{
    if (self = [super init]) {
        self.remove = isRemove;
    }
    return self;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}

-(NSString *)description{
    return [self dictionaryWithValuesForKeys:@[@"code", @"chs", @"png", @"codeString", @"pngPath"]].description;
}




@end
