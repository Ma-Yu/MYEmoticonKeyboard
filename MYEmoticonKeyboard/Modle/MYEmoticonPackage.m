//
//  MYEmoticonPackage.m
//  表情键盘
//
//  Created by MY❤️mqq on 16/4/7.
//  Copyright © 2016年 MY❤️mqq. All rights reserved.
//

#import "MYEmoticonPackage.h"
#import "MYEmoticon.h"

@implementation MYEmoticonPackage

- (NSMutableArray<MYEmoticon *> *)emoticons{
    if (!_emoticons) {
        _emoticons = [NSMutableArray array];
    }
    return _emoticons;
}

- (MYEmoticonPackage *)initWithID:(NSString *)ID{
    if (self = [super init]) {
        
        if ([ID isEqual: @""]) {
            
            [self addEmptyEmoticon];
            return self;
        }
        
        NSString *infoPlistPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@/info.plist", ID] ofType:nil inDirectory:@"Emoticons.bundle"];
        NSDictionary *packageDict = [NSDictionary dictionaryWithContentsOfFile:infoPlistPath];
        
        NSDictionary *emoticonDicts = packageDict[@"emoticons"];
        
        int index = 0;
        for (NSDictionary *emoticonDict in emoticonDicts) {
            index ++;
            
            MYEmoticon *emoticon = [MYEmoticon emotionWithDict:emoticonDict];
            [self.emoticons addObject:emoticon];
            
            if (emoticon.png != nil) {
                emoticon.png = [NSString stringWithFormat:@"%@/%@", ID, emoticon.png];
            }
            
            if (index % 20 == 0) {
                // 添加一个删除按钮
                [self.emoticons addObject:[[MYEmoticon alloc] initWithIsRemove:YES]];
            }

        }
        
        [self addEmptyEmoticon];
    }
    return self;
}

- (void)addEmptyEmoticon{

    int count = self.emoticons.count % 21;
    
    if (count == 0 && self.emoticons.count > 0) {
        return;
    }
    
    for (int i=count; i< 20; i++) {
        [self.emoticons addObject:[[MYEmoticon alloc] initWithIsEmpty:YES]];
    }
    
    
    [self.emoticons addObject:[[MYEmoticon alloc] initWithIsRemove:YES]];
}
    
@end
