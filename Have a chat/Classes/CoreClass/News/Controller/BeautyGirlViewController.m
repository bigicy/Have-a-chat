//
//  BeautyGirlViewController.m
//  Have a chat
//
//  Created by 黄兵 on 16/8/8.
//  Copyright © 2016年 yun. All rights reserved.
//

#import "BeautyGirlViewController.h"
#import "BeautyModel.h"
#import "BeautyCollectionViewCell.h"
@interface BeautyGirlViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
//
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation BeautyGirlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self analyseData];
    [self creatCollectionView];
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)creatCollectionView
{
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight -100) collectionViewLayout:flow];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerNib:[UINib nibWithNibName:@"BeautyCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"BeautyCollectionViewCell"];
    [self.view addSubview:_collectionView];
}

- (void)analyseData
{
    [NetWorkRequestManager requestWithType:GET urlString:kNewsBeautyGirls parDic:nil finish:^(NSData *data) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary *dic in dictionary[@"value"]) {
            BeautyModel *model = [[BeautyModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
        
    } finishError:^(NSError *error) {
        NSLog(@"数据解析错误");
    }];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    return CGSizeMake(kScreenWidth/2 - 30, 150);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 16, 10, 16);
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BeautyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BeautyCollectionViewCell" forIndexPath:indexPath];
    BeautyModel *model = self.dataArray[indexPath.row];
    [cell setValueWithModel:model];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CommonWebViewController *webVC = [[CommonWebViewController alloc] init];
    BeautyModel *model = self.dataArray[indexPath.row];
    webVC.permalink = model.permalink;
    [self presentViewController:webVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
