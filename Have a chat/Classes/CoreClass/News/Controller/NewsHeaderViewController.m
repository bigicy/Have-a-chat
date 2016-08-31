//
//  NewsHeaderViewController.m
//  Have a chat
//
//  Created by 黄兵 on 16/8/8.
//  Copyright © 2016年 yun. All rights reserved.
//

#import "NewsHeaderViewController.h"
#import "CustomLabel.h"
#import "OlympicViewController.h"
#import "BeautyGirlViewController.h"
#import "SubscriptionViewController.h"
#import "SocietyViewController.h"
#import "MakeFunnyViewController.h"
#import "HeaderlineViewController.h"
@interface NewsHeaderViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) NSArray *array;
//
@property (nonatomic, assign) BOOL isClick;

// 
@property (nonatomic) NSInteger index;
@end

@implementation NewsHeaderViewController

- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 创建标题
- (void)creatTitleScrollViewWithLabel
{
    // for 循环创建label比较方便
    for (NSInteger i = 0; i < _array.count; i++) {
        CustomLabel *label = [[CustomLabel alloc] init];
        label.text = _array[i];
        label.frame =CGRectMake(i*80, 5, 80, 30);
        label.textColor = [UIColor blackColor];
        label.tag = i + 100;
        label.userInteractionEnabled = YES;
        // 给label添加点击事件
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleClick:)];
        [label addGestureRecognizer:recognizer];
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(i*80+10, label.endY+4, 60, 2)];
        imageV.backgroundColor = [UIColor whiteColor];
        imageV.tag = 200 + i;
        [self.titleScrollView addSubview:imageV];
        [self.titleScrollView addSubview:label];
    }
    // 设置scrollView的 contentSize
    self.titleScrollView.contentSize = CGSizeMake(_array.count *80, 0);
    _titleScrollView.layer.borderWidth = 1;
    _titleScrollView.layer.borderColor = [[UIColor darkGrayColor]CGColor];
    self.contentScrollView.contentSize =CGSizeMake([UIScreen mainScreen].bounds.size.width * _array.count, 0);
    _isClick = NO;
}

- (void)titleClick:(UITapGestureRecognizer *)tap
{
    // 通过tag值找到label
    NSInteger index = tap.view.tag;
    UIImageView *img = [_titleScrollView viewWithTag:self.index];    
    CustomLabel *lbl = [_titleScrollView viewWithTag:self.index - 100];
    if (img.backgroundColor == [UIColor blueColor]){
        img.backgroundColor = [UIColor whiteColor];
        lbl.textColor = [UIColor blackColor];
    }
    if (index != 100) {
        UIImageView *imgV = [_titleScrollView viewWithTag:200];
        imgV.backgroundColor = [UIColor whiteColor];
        CustomLabel *lbl = [_titleScrollView viewWithTag:100 ];
        lbl.textColor = [UIColor blackColor];
    }
    CustomLabel *label = [_titleScrollView viewWithTag:index];
    label.textColor = [UIColor blueColor];
    UIImageView *imgV = [_titleScrollView viewWithTag: 100 + index];
    imgV.backgroundColor = [UIColor blueColor];
    self.index = 100 + index;
    // 改变scrollView的偏移量
    CGPoint offset =  self.contentScrollView.contentOffset;
    offset.x = (index -100)*[UIScreen mainScreen].bounds.size.width;
    // 赋值偏移量
    [self.contentScrollView setContentOffset:offset animated:YES];
}

// 动画执行完后走的方法
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 活动屏幕的宽度，也就是scrollView在屏幕上的宽度
    CGFloat width = scrollView.frame.size.width;
    // 获得偏移量
    CGFloat offsetX = scrollView.contentOffset.x;
    // 获得当前所在位置的索引
    NSInteger index = offsetX/width;
    // 获得scrollView对应labelOffset
    CGPoint labelOffset = self.titleScrollView.contentOffset;
    
    UIImageView *imageV = [_titleScrollView viewWithTag:200 + index];
    imageV.backgroundColor = [UIColor blueColor];
    UIImageView *imageV1 = [_titleScrollView viewWithTag:199 + index];
    imageV1.backgroundColor = [UIColor whiteColor];
    UIImageView *imageV2 = [_titleScrollView viewWithTag:201 + index];
    imageV2.backgroundColor = [UIColor whiteColor];
    CustomLabel *label = [_titleScrollView viewWithTag:100 + index];
    label.textColor = [UIColor blueColor];
    CustomLabel *label1 = [_titleScrollView viewWithTag:99 + index];
    label1.textColor = [UIColor blackColor];
    CustomLabel *label2 = [_titleScrollView viewWithTag:101 + index];
    label2.textColor = [UIColor blackColor];
    
    labelOffset.x = label.center.x - width/2;
    // 左边最大的偏移量
    if (labelOffset.x < 0) {
        labelOffset.x = 0;
    }
    // 右边最大的偏移量
    if (labelOffset.x > self.titleScrollView.contentSize.width - width) {
        labelOffset.x = self.titleScrollView.contentSize.width - width;
    }
    [self.titleScrollView setContentOffset:labelOffset animated:YES];
    // 取出我们的控制器
    UIViewController *VC =  self.childViewControllers[index];
    // 判断控制器是否已经加载，加载过后就不在执行加载代码
    if ([VC isViewLoaded]) {
        return;
    }
    // 添加视图控制器的视图到contentScrollView
    VC.view.frame = CGRectMake(offsetX, 0, width, scrollView.frame.size.height);
    [scrollView addSubview:VC.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

- (void)creatViewWithSubView
{
    HeaderlineViewController *headerVC = [[HeaderlineViewController alloc] init];
    headerVC.title = _array[0];
    [self addChildViewController:headerVC];
    OlympicViewController *olymVC = [[OlympicViewController alloc] init];
    olymVC.title = _array[1];
    [self addChildViewController:olymVC];
    BeautyGirlViewController *beautyVC = [[BeautyGirlViewController alloc] init];
    beautyVC.title = _array[2];
    [self addChildViewController:beautyVC];
    SubscriptionViewController *subscripVC = [[SubscriptionViewController alloc] init];
    subscripVC.title = _array[3];
    [self addChildViewController:subscripVC];
    MakeFunnyViewController *makeFunnyVC = [[MakeFunnyViewController alloc] init];
    makeFunnyVC.title = _array[4];
    [self addChildViewController:makeFunnyVC];
    SocietyViewController *societyVC = [[SocietyViewController alloc] init];
    societyVC.title = _array[5];
    [self addChildViewController:societyVC];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.array  = @[@"头条", @"奥运会", @"美女", @"订阅", @"搞笑", @"社会"];
    // 关闭导航栏自适应
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 创建标题
    [self creatSelectedButton];
    [self creatTitleScrollViewWithLabel];
    [self creatViewWithSubView];
    [self scrollViewDidEndScrollingAnimation:self.contentScrollView];
}

- (void)creatSelectedButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(kScreenWidth - 100, 64, 100, _titleScrollView.ownHeight);
    [button setBackgroundImage:[UIImage imageNamed:@"向下"] forState:(UIControlStateNormal)];
    [self.titleScrollView addSubview:button];
}

@end
