# MYEmoticonKeyboard
### 使用方法
##### 1. 包含头文件
```objc
#import "MYEmoticonKeyboard.h"
```

##### 2. 创建MYEmoticonTextView
```objc
@property (weak, nonatomic) IBOutlet MYEmoticonTextView *textView;
```

##### 3. 创建表情控制器
```objc
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
```
##### 4. 获取表情文本字符串
```objc
[self.textView getEmoticonString];
```
