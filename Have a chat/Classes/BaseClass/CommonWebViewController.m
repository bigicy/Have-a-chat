//
//  CommonWebViewController.m
//  Have a chat
//
//  Created by 黄兵 on 16/8/10.
//  Copyright © 2016年 yun. All rights reserved.
//

#import "CommonWebViewController.h"

@interface CommonWebViewController ()

@property (nonatomic, strong) UIWebView *webView;
// articleId
//
@property (nonatomic, strong) AVPlayer *player;

@end

@implementation CommonWebViewController
- (IBAction)backButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
    [self.view addSubview: _webView];
    if (_articleUrl != nil&&_vId == nil) {
        [self creatHeaderlineWebView];
    }else if(_permalink != nil) {
        [self creatBeautyWebView];
    }else if (_vId !=nil){
        [self playVideo];
    }
    else{
        [self creatOlympicWebView];
    }
}

- (void)playVideo
{
    NSString *string = [NSString stringWithFormat:@"http://api.v.meizu.com/api/video/detail/new/%@/0?deviceType=MX5&supportSDK=16&vip=1", _vId];
    _webView.scalesPageToFit = YES;  //关闭屏幕自适应
    [NetWorkRequestManager requestWithType:GET urlString:string parDic:nil finish:^(NSData *data) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSString *urlStr = dictionary[@"value"][@"addresses"][0][@"url"];
        // 请求数据
        AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:urlStr]];
        self.player = [AVPlayer playerWithPlayerItem:item];
        [self.player play];
        // 显示
        AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        layer.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        // 屏幕旋转
        layer.videoGravity = AVLayerVideoGravityResizeAspect;
        layer.backgroundColor = (__bridge CGColorRef _Nullable)([UIColor cyanColor]);
        [self.view.layer addSublayer:layer];
    } finishError:^(NSError *error) {
        NSLog(@"数据解析错误");
    }];
}


- (void)creatHeaderlineWebView
{
    [NetWorkRequestManager requestWithType:GET urlString:_articleUrl parDic:nil finish:^(NSData *data) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if (dictionary[@"sourceUrl"] != nil) {
            NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:dictionary[@"sourceUrl"]]];
//            _webView.scalesPageToFit = YES;
            [_webView loadRequest:request];
        }else{
            NSString *htmlStr = dictionary[@"content"];
            _webView.scalesPageToFit = NO;  //关闭屏幕自适应
            // 修改html布局
            NSString *newStr = [NSString importStyleWithHtmlString:htmlStr];
            // 让页面加载按照本地样式去加载
            NSURL *baseUrl = [NSURL fileURLWithPath:[NSBundle mainBundle].bundlePath];
            [self.webView loadHTMLString:newStr baseURL:baseUrl];
        }
    } finishError:^(NSError *error) {
        NSLog(@"数据解析错误");
    }];
}

- (void)creatBeautyWebView
{
    NSString *string = [NSString stringWithFormat:@"http://www.lofter.com/meizu/singlepost.do?permalink=%@&source=2&mark=1", _permalink];
    NSString *str1 = @"&tag=%E6%B7%B1%E5%9C%B3";
    NSString *str = [string stringByAppendingString:str1];
    _webView.scalesPageToFit = YES;  //关闭屏幕自适应
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:str]];
    [_webView loadRequest:request];
}

- (void)creatSubscriptionWebView
{
    NSString *string = [NSString stringWithFormat:@"http://reader.res.meizu.com/reader/articlecontent/20160811/%@.json", _subId];
    [NetWorkRequestManager requestWithType:GET urlString:string parDic:nil finish:^(NSData *data) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if (dictionary[@"sourceUrl"] != nil) {
            NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:dictionary[@"sourceUrl"]]];
            [_webView loadRequest:request];
            _webView.scalesPageToFit = NO;  //关闭屏幕自适应
        }else{
            NSString *htmlStr = dictionary[@"content"];
            // _webView.scalesPageToFit = NO;  //关闭屏幕自适应
            // 修改html布局
            NSString *newStr = [NSString importStyleWithHtmlString:htmlStr];
            // 让页面加载按照本地样式去加载
            NSURL *baseUrl = [NSURL fileURLWithPath:[NSBundle mainBundle].bundlePath];
            [self.webView loadHTMLString:newStr baseURL:baseUrl];
        }
    } finishError:^(NSError *error) {
        NSLog(@"数据解析错误");
    }];
}

- (void)creatOlympicWebView
{
    _webView.scalesPageToFit = YES;  //关闭屏幕自适应
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:_olympicUrl]];
    [_webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
