//
//  MYEmotionViewController.h
//  表情键盘
//
//  Created by MY❤️mqq on 16/4/6.
//  Copyright © 2016年 MY❤️mqq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MYEmoticon;

typedef void (^emoticonClickBlock)(MYEmoticon *emotion);

@interface MYEmoticonViewController : UIViewController

- (__kindof MYEmoticonViewController *)initWithEmoticonClickBlock:(emoticonClickBlock)emoticonClickBlock;
@end
