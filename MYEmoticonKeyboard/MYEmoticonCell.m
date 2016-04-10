//
//  MYEmoticonCell.m
//  表情键盘
//
//  Created by MY❤️mqq on 16/4/7.
//  Copyright © 2016年 MY❤️mqq. All rights reserved.
//

#import "MYEmoticonCell.h"
#import "MYEmoticon.h"

@interface MYEmoticonCell ()

@property (nonatomic, weak) UIButton *emoticonBtn;

@end
@implementation MYEmoticonCell

- (UIButton *)emoticonBtn{
    if (!_emoticonBtn) {
        UIButton *emoticonBtn = [[UIButton alloc] init];
        _emoticonBtn = emoticonBtn;
        [self addSubview:emoticonBtn];
        
        emoticonBtn.backgroundColor = [UIColor clearColor];
    }
    return _emoticonBtn;
}

- (void)setEmoticon:(MYEmoticon *)emoticon
{
    _emoticon = emoticon;
    if (emoticon.pngPath != nil) {
        [self.emoticonBtn setImage:[UIImage imageWithContentsOfFile:emoticon.pngPath] forState:UIControlStateNormal];
        [self.emoticonBtn setTitle:nil forState:UIControlStateNormal];
    }else if (emoticon.codeString != nil){
        [self.emoticonBtn setTitle:emoticon.codeString forState:UIControlStateNormal];
        [self.emoticonBtn setImage:nil forState:UIControlStateNormal];
    }
    
    if (emoticon.isRemove) {
        [self.emoticonBtn setImage:[UIImage imageNamed:@"Emoticons.bundle/compose_emotion_delete"] forState:UIControlStateNormal];
        [self.emoticonBtn setTitle:nil forState:UIControlStateNormal];
    }
    
    // 4.设置空白按钮
    if (emoticon.isEmpty) {
        [self.emoticonBtn setTitle:nil forState:UIControlStateNormal];
        [self.emoticonBtn setImage:nil forState:UIControlStateNormal];
    }
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.emoticonBtn.frame = CGRectInset(self.contentView.bounds, 4, 4);
        self.emoticonBtn.userInteractionEnabled = NO;
        self.emoticonBtn.titleLabel.font = [UIFont systemFontOfSize:32];
    }
    return self;
}

@end
