//
//  ViewController.m
//  表情键盘
//
//  Created by MY❤️mqq on 16/4/6.
//  Copyright © 2016年 MY❤️mqq. All rights reserved.
//

#import "ViewController.h"
#import "MYEmoticonViewController.h"
#import "MYEmoticon.h"
#import "MYEmoticonPackage.h"
#import "MYEmoticonPackageManager.h"
#import "MYEmoticonAttachment.h"
#import "MYEmoticonTextView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet MYEmoticonTextView *textView;

@property (nonatomic, weak) MYEmoticonViewController *emoticonVc;
@end

@implementation ViewController


/** 点击发送 */
- (IBAction)sendClick:(UIBarButtonItem *)sender {
    
    NSLog(@"%@", [self.textView getEmoticonString]);
}

#pragma mark - 懒加载表情控制器
-(MYEmoticonViewController *)emoticonVc{
    if (!_emoticonVc) {
        // 创建控制器时, 传入点击表情的回调block
        __weak typeof(self) weakSelf = self;
        MYEmoticonViewController *emoticonVc = [[MYEmoticonViewController alloc] initWithEmoticonClickBlock:^(MYEmoticon *emotion) {
            /** 插入表情 */
            [weakSelf.textView insertEmoticon:emotion];
        }];
        _emoticonVc = emoticonVc;
        
        [self addChildViewController:emoticonVc];
    }
    return _emoticonVc;
}

#pragma mark - 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];

    self.textView.inputView = self.emoticonVc.view;
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.textView becomeFirstResponder];
}
@end











