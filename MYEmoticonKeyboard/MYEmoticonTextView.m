//
//  MYEmoticonTextView.m
//  表情键盘
//
//  Created by MY❤️mqq on 16/4/10.
//  Copyright © 2016年 MY❤️mqq. All rights reserved.
//

#import "MYEmoticonTextView.h"
#import "MYEmoticonAttachment.h"
#import "MYEmoticon.h"

@implementation MYEmoticonTextView

- (void)insertEmoticon:(MYEmoticon *)emoticon{
    // 1.判断是否点击了空白表情
    if (emoticon.isEmpty) {
        return;
    }
    
    // 2.判断是否是删除按钮
    if (emoticon.isRemove) {
        [self deleteBackward];
        return;
    }
    
    // 3.判断是否是emoji表情
    if (emoticon.codeString != nil) {
        // 3.1.获取光标所在的UITextRange的位置
        UITextRange *textRange = self.selectedTextRange;
        
        // 3.2.替换成emoji表情
        [self replaceRange:textRange withText:emoticon.codeString];
        
        return;
    }
    
    // 4.图文混排
    if (emoticon.pngPath != nil) {
        // 4.1.创建NSMutableAttributeString
        NSMutableAttributedString *attrMStr = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
        
        // 4.2.创建表情属性字符串
        MYEmoticonAttachment *attachment = [[MYEmoticonAttachment alloc] init];
        attachment.chs = emoticon.chs;
        attachment.image = [UIImage imageWithContentsOfFile:emoticon.pngPath];
        UIFont *font = self.font;
        attachment.bounds = CGRectMake(0, -4, font.lineHeight, font.lineHeight);
        NSAttributedString *emoticonAttrStr = [NSAttributedString attributedStringWithAttachment:attachment];
        
        // 4.3.获取光标的位置
        NSRange range = self.selectedRange;
        
        // 4.4.将表情属性字符串,替换到可变的属性字符串中
        [attrMStr replaceCharactersInRange:range withAttributedString:emoticonAttrStr];
        
        // 4.5.将最新的属性字符串设置到textView中
        self.attributedText = attrMStr;
        
        // 4.6.重新设置光标的位置
        self.selectedRange = NSMakeRange(range.location +1, range.length);
        
        // 4.7.将字体设置回原来的大小
        self.font = font;
    } 
}

#pragma mark - 获取表情字符串
-(NSString *)getEmoticonString{
    NSMutableAttributedString *textAttrStr = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    
    NSRange range = NSMakeRange(0, textAttrStr.length);
    [textAttrStr enumerateAttributesInRange:range options:kNilOptions usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        
        MYEmoticonAttachment *attachment = attrs[@"NSAttachment"];
        if ([attachment isKindOfClass:[MYEmoticonAttachment class]]) {
            [textAttrStr replaceCharactersInRange:range withString:attachment.chs];
        }
    }];
    return textAttrStr.string;
}


@end
