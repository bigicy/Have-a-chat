//
//  SubscriptionViewController.m
//  Have a chat
//
//  Created by 黄兵 on 16/8/8.
//  Copyright © 2016年 yun. All rights reserved.
//

#import "SubscriptionViewController.h"
#import "SubscriptionModel.h"
#import "SubscriptionViewCell.h"
@interface SubscriptionViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;
//
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SubscriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatTableView];
    [self analyseData];
}
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)creatTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 110)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"SubscriptionViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
}

- (void)analyseData
{
    [NetWorkRequestManager requestWithType:GET urlString:kNewsSubscription parDic:nil finish:^(NSData *data) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary *dic in dictionary[@"value"][@"articles"]) {
            SubscriptionModel *model = [[SubscriptionModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    } finishError:^(NSError *error) {
        NSLog(@"数据解析错误");
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SubscriptionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    SubscriptionModel *model = self.dataArray[indexPath.row];
    [cell setValueWithModel:model];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommonWebViewController *webVC = [[CommonWebViewController alloc] init];
    SubscriptionModel *model = self.dataArray[indexPath.row];
    webVC.articleUrl = model.articleUrl;
    [self presentViewController:webVC animated:YES completion:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
