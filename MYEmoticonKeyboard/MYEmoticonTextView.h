//
//  MYEmoticonTextView.h
//  表情键盘
//
//  Created by MY❤️mqq on 16/4/10.
//  Copyright © 2016年 MY❤️mqq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MYEmoticon;

@interface MYEmoticonTextView : UITextView

- (void)insertEmoticon:(MYEmoticon *)emoticon;

- (NSString *)getEmoticonString;

@end
