//
//  MYEmotionViewController.m
//  表情键盘
//
//  Created by MY❤️mqq on 16/4/6.
//  Copyright © 2016年 MY❤️mqq. All rights reserved.
//

#import "MYEmoticonViewController.h"
#import "MYEmoticonCell.h"
#import "MYEmoticon.h"
#import "MYEmoticonPackage.h"
#import "MYEmoticonPackageManager.h"

#pragma mark - 自定义流水布局
@interface MYEmoticonCollectionViewLayout : UICollectionViewFlowLayout

@end

@implementation MYEmoticonCollectionViewLayout

-(void)prepareLayout{
    [super prepareLayout];
    
    CGFloat itemWH = [UIScreen mainScreen].bounds.size.width / 7;
    self.itemSize = CGSizeMake(itemWH, itemWH);
    
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    CGFloat topInset = (self.collectionView.bounds.size.height - 3 * itemWH) / 2;
    self.collectionView.contentInset = UIEdgeInsetsMake(topInset, 0, topInset, 0);
}

@end

/*********************** 表情控制器 ***********************/


@interface MYEmoticonViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, weak) UIToolbar *toolbar;
@property (nonatomic, strong) MYEmoticonPackageManager *packageManage;

@property (nonatomic, strong)emoticonClickBlock emoticonClick;

@end

@implementation MYEmoticonViewController

static NSString * const emotionID = @"emotionID";

#pragma mark - 懒加载
- (MYEmoticonPackageManager *)packageManage{
    if (!_packageManage) {
        _packageManage = [[MYEmoticonPackageManager alloc] init];
    }
    return _packageManage;
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[MYEmoticonCollectionViewLayout alloc] init]];
        
        collectionView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        _collectionView = collectionView;
        
        [self.view addSubview:self.collectionView];
    }
    return _collectionView;
}
-(UIToolbar *)toolbar{
    if (!_toolbar) {
        UIToolbar *toolbar = [[UIToolbar alloc] init];
        
        _toolbar = toolbar;
        
        [self.view addSubview:self.toolbar];
    }
    return _toolbar;
}

#pragma mark - 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

#pragma mark - 初始化方法
- (MYEmoticonViewController *)initWithEmoticonClickBlock:(emoticonClickBlock)emoticonClickBlock{
    if (self = [super init]) {
        self.emoticonClick = emoticonClickBlock;
    }
    return self;
}

-(void)setupUI{

    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.toolbar.translatesAutoresizingMaskIntoConstraints = NO;
    
    // 调整位置
    NSDictionary *Views = @{
                            @"collectionView" : self.collectionView,
                            @"toolbar" : self.toolbar
                            };
    NSString *hvfl = @"H:|-0-[toolbar]-0-|";
    NSArray *hconstraint = [NSLayoutConstraint constraintsWithVisualFormat:hvfl options:kNilOptions metrics:nil views:Views];
    [self.view addConstraints:hconstraint];
    
    NSString *vvfl = @"V:|-0-[collectionView]-0-[toolbar(44)]-0-|";
    NSArray *vconstraint = [NSLayoutConstraint constraintsWithVisualFormat:vvfl options:NSLayoutFormatAlignAllLeft | NSLayoutFormatAlignAllRight metrics:nil views:Views];
    [self.view addConstraints:vconstraint];
    
    [self prepareForToolbar];
    
    [self prepareForCollectionView];
}

- (void)prepareForToolbar{
    NSArray *titles = @[@"最近", @"默认", @"emoji", @"浪小花"];
    
    NSMutableArray *items = [NSMutableArray array];
    for (int i=0; i< titles.count; i++) {
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:titles[i] style:UIBarButtonItemStylePlain target:self action:@selector(itemClick:)];
        item.tag = i;
        [items addObject:item];
        [items addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil]];
    }
    
    [items removeLastObject];
    self.toolbar.items = items;
    self.toolbar.tintColor = [UIColor orangeColor];
}

- (void)prepareForCollectionView{
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
    
    [self.collectionView registerClass:[MYEmoticonCell class] forCellWithReuseIdentifier:emotionID];
}

/** 点击Tabbar按钮, 滚动到对应表情页面 */
- (void)itemClick:(UIBarButtonItem *)item{
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:item.tag];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.packageManage.packages.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    MYEmoticonPackage *package = self.packageManage.packages[section];
    return package.emoticons.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MYEmoticonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:emotionID forIndexPath:indexPath];
//    cell.backgroundColor = indexPath.item % 2 == 0 ? [UIColor redColor] : [UIColor greenColor];
    
    MYEmoticonPackage *package = self.packageManage.packages[indexPath.section];
    MYEmoticon *emoticon = package.emoticons[indexPath.item];
    cell.emoticon = emoticon;
    return cell;
}

#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    MYEmoticonPackage *package = self.packageManage.packages[indexPath.section];
    MYEmoticon *selectedEmoticon = package.emoticons[indexPath.item];
    
//    NSLog(@"%d", selectedEmoticon.isRemove);
    // 回调
    self.emoticonClick(selectedEmoticon);
    
    // 添加到最近使用分组
    if (selectedEmoticon.isEmpty || selectedEmoticon.isRemove) {
        return;
    }
    
    NSMutableArray *emoticons = self.packageManage.packages[0].emoticons;
    if ([emoticons containsObject:selectedEmoticon]) {
        NSInteger emoticonIndex = [emoticons indexOfObject:selectedEmoticon];
        [emoticons removeObjectAtIndex:emoticonIndex]; // 移除原先的
    }else {
        [emoticons removeObjectAtIndex:(emoticons.count -2)]; // 移除差号前的
    }
    
    [emoticons insertObject:selectedEmoticon atIndex:0];
}


@end






