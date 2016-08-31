//
//  HeaderlineViewController.m
//  Have a chat
//
//  Created by 黄兵 on 16/8/9.
//  Copyright © 2016年 yun. All rights reserved.
//

#import "HeaderlineViewController.h"
#import "HeaderlineModel.h"
#import "HeaderViewCell.h"
#import "HeaderModel.h"

@interface HeaderlineViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

//
@property (nonatomic, strong) UITableView *tableView;
// 数组
@property (nonatomic, strong) NSMutableArray *dataArray;
//
@property (nonatomic, strong) NSMutableArray *imageArray;
//
// 滚动图片数组
@property (nonatomic, strong) NSMutableArray *scrollImageArray;
@property (nonatomic, strong) UIScrollView *scrollView;
//
@property (nonatomic, strong) UIPageControl *pageCtrl;
//
@property (nonatomic, strong) UIImageView *imageV;
// 定时器
@property (nonatomic, strong) NSTimer *timer;
//
@property (nonatomic, assign) NSInteger index;

//
@property (nonatomic, strong) NSString *videoStr;
@property (nonatomic, strong) AVPlayer *player;

@end

@implementation HeaderlineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self analyseData];
    [self creatTableView];
    [self analyseHeaderViewData];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    [_timer fire];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (NSMutableArray *)imageArray
{
    if (!_imageArray) {
        _imageArray = [[NSMutableArray alloc] init];
    }
    return _imageArray;
}

- (NSMutableArray *)scrollImageArray
{
    if (!_scrollImageArray) {
        _scrollImageArray = [[NSMutableArray alloc] init];
    }
    return _scrollImageArray;
}

- (void)creatTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-110)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"HeaderViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
}

- (void)analyseHeaderViewData
{
    [NetWorkRequestManager requestWithType:GET urlString:kNewsWheelPage parDic:nil finish:^(NSData *data) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary *dic in dictionary[@"value"][0][@"data"]) {
            HeaderModel *model = [[HeaderModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.imageArray addObject:model];
        }
        NSLog(@"%@",dictionary);

        [self.scrollImageArray addObject:_imageArray.lastObject];
        for (NSInteger i = 0; i<_imageArray.count; i++) {
            [self.scrollImageArray addObject:_imageArray[i]];
        }
        [self.scrollImageArray addObject:_imageArray.firstObject];
        [self creatTableHeaderView];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.tableView.tableHeaderView = _scrollView;
            [self.tableView reloadData];
        });
        
    } finishError:^(NSError *error) {
        NSLog(@"数据解析错误");
    }];
}

- (void)creatTableHeaderView
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth,150)];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(_scrollImageArray.count *kScreenWidth, 0);
    _scrollView.contentOffset = CGPointMake(kScreenWidth, 0);
    for (NSInteger i = 0; i<_scrollImageArray.count; i++) {
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(i*kScreenWidth, 0, kScreenWidth, 150)];
        HeaderModel *model = _scrollImageArray[i];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [tap addTarget:self action:@selector(tapAction:)];
        imageV.userInteractionEnabled = YES;
        [imageV addGestureRecognizer:tap];
        imageV.tag = 100 + i;
        [_scrollView addSubview:imageV];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i*kScreenWidth +30, imageV.endY - 40, kScreenWidth, 30)];
        label.text = model.title;
        label.center = imageV.center;
        label.ownY = imageV.endY - 40;
        label.textColor = [UIColor whiteColor];
        if (model.vScreenImg != nil) {
            [imageV sd_setImageWithURL:[NSURL URLWithString:model.vScreenImg]];
            label.text = model.vTitle;
        }else{
            [imageV sd_setImageWithURL:[NSURL URLWithString:model.imgUrlList[0]]];
            label.text = model.title;
        }
        [_scrollView addSubview:label];
    }
}

- (void)tapAction:(UITapGestureRecognizer *)tap
{
    NSInteger index = tap.view.tag;
    CommonWebViewController *webVC = [[CommonWebViewController alloc] init];
    HeaderModel *model = self.imageArray[index - 101];
    webVC.articleUrl = model.articleUrl;
    webVC.vId = model.vId;
//    if (index == 102) {
//        [self playVideo];
//    }else{
    [self presentViewController:webVC animated:YES completion:nil];
//    }
}

- (void)playVideo
{
    HeaderModel *model = self.imageArray[1];
    NSString *string = [NSString stringWithFormat:@"http://api.v.meizu.com/api/video/detail/new/%@/0?deviceType=MX5&supportSDK=16&vip=1", model.vId];
    [NetWorkRequestManager requestWithType:GET urlString:string parDic:nil finish:^(NSData *data) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSString *urlStr = dictionary[@"value"][@"addresses"][0][@"url"];
        // 请求数据
        AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:urlStr]];
        self.player = [[AVPlayer alloc] init];
        [self.player replaceCurrentItemWithPlayerItem:item];
        [self.player play];
        // 显示
        AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        layer.frame = self.view.frame;
        // 屏幕旋转
        layer.videoGravity = AVLayerVideoGravityResizeAspect;
        layer.backgroundColor = (__bridge CGColorRef _Nullable)([UIColor cyanColor]);
        [self.view.layer addSublayer:layer];
    } finishError:^(NSError *error) {
        NSLog(@"数据解析错误");
    }];
}

- (void)timerAction:(NSTimer *)timer
{
    _index ++;
    [_scrollView setContentOffset:CGPointMake((_index + 1)*kScreenWidth, 0) animated:YES];
    if (_index == _imageArray.count) {
        _index = 0;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offset = _scrollView.contentOffset.x;
    _pageCtrl.currentPage = offset/kScreenWidth -1;
    _index = offset/kScreenWidth - 1;
    if (offset>(_imageArray.count + 0.5)*kScreenWidth) {
        _scrollView.contentOffset = CGPointMake(offset-(_imageArray.count)*kScreenWidth, 0);
    }
    if (offset<0.5*kScreenWidth) {
        _scrollView.contentOffset = CGPointMake(offset+(_imageArray.count)*kScreenWidth, 0);
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_timer invalidate];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    [_timer fire];
}

- (void)analyseData
{
    [NetWorkRequestManager requestWithType:GET urlString:kNewsHeadline parDic:nil finish:^(NSData *data) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary *dic in dictionary[@"value"][@"articles"]) {
            HeaderlineModel *model = [[HeaderlineModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.tableView.tableHeaderView = _scrollView;
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
    HeaderViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    HeaderlineModel *model = self.dataArray[indexPath.row];
    [cell setvalueWithModel:model];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommonWebViewController *webVC = [[CommonWebViewController alloc] init];
    HeaderlineModel *model = self.dataArray[indexPath.row];
    webVC.articleUrl = model.articleUrl;
    [self presentViewController:webVC animated:YES completion:nil];
}


@end
