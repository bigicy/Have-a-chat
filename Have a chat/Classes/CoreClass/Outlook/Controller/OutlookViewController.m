//
//  OutlookViewController.m
//  Have a chat
//
//  Created by 马凌云 on 16/8/6.
//  Copyright © 2016年 yun. All rights reserved.
//

#import "OutlookViewController.h"
#import "OutLookTableViewCell.h"
#import "NewsHeaderViewController.h"

@interface OutlookViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

// 数据数组
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation OutlookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = @[@"新闻", @"阅读"];
    [self.tableView registerNib:[UINib nibWithNibName:@"OutLookTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"OutLookTableViewCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OutLookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OutLookTableViewCell" forIndexPath:indexPath];
    NSString *string = self.dataArray[indexPath.row];
    cell.nameLabel.text = string;
    cell.imageV.image = [UIImage imageNamed:string];
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        NewsHeaderViewController *newsHeaderVC = [[NewsHeaderViewController alloc] initWithNibName:@"NewsHeader" bundle:[NSBundle mainBundle]];
        [self presentViewController:newsHeaderVC animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
