//
//  MYEmoticonPackage.h
//  表情键盘
//
//  Created by MY❤️mqq on 16/4/7.
//  Copyright © 2016年 MY❤️mqq. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MYEmoticon;

@interface MYEmoticonPackage : NSObject

@property (nonatomic, strong) NSMutableArray<__kindof MYEmoticon *> *emoticons;

- (__kindof MYEmoticonPackage *)initWithID:(NSString *)ID;

@end
