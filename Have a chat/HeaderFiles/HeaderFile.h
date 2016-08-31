//
//  HeaderFile.h
//  Have a chat
//
//  Created by 马凌云 on 16/8/5.
//  Copyright © 2016年 yun. All rights reserved.
//

#ifndef HeaderFile_h
#define HeaderFile_h

// 环信
#import "EMSDKFull.h"
// 尺寸
#import "UIView+ApViewAttr.h"
// 数据库
#import "FMDB.h"
//
#import "UIImageView+WebCache.h"
// 网络解析
#import "NetWorkRequestManager.h"

#import "FMDBManager.h"
#import "MJRefresh.h"
#import <AVFoundation/AVFoundation.h>

// 阅读
// 首页
#define kReadFirstPage  @"http://ebook.meizu.com/api/v1/public/user/timeline?count=20"
//分类
#define kReadCategory @"http://ebook.meizu.com/api/v1/public/category/list"
//排行榜
#define kReadRanklist @"http://ebook.meizu.com/api/v1/public/chart/list?ids=%5B8%2C9%2C10%5D"
//特价专区
#define kReadSpecialPrice @"http://ebook.meizu.com/api/v1/public/special/groups"
//免费专区
#define kReadFree @"http://ebook.meizu.com/api/v1/public/limit/groups"
//大家都在看
#define kReadAllLook @"http://ebook.meizu.com/api/v1/public/column/booklist?count=20&id=3"
//第一重磅推出
#define kReadMostImportant @"http://ebook.meizu.com/api/v1/public/column/booklist?count=20&id=1"
//重磅推出的页面  点击书籍
#define kReadMostImportantPage @"http://ebook.meizu.com/api/v1/public/book/catalog?total=0&id=333616"
//http://ebook.meizu.com/api/v1/public/booklist/detail?id=1716
//每一本书籍的接口
#define kReadEveryBook @"http://ebook.meizu.com/api/v1/public/book/catalog?total=0&id=333224"
//具体的每个章节的接口
#define kReadEveryParegraphic @"http://flyme.ikanshu.cn/flyme/getChapterById?sign=748d7ae05231daad0a899b01d412b790&time=1470472641&id=52015170"


// 新闻
//轮播图
#define kNewsWheelPage @"http://reader.meizu.com/android/unAuth/index/getBanner.do?supportSDK=16&deviceType=MX5&v=2801&operator=46002&flymeuid=111047824&nt=wifi&vn=2.8.01&deviceinfo=jLg2Zba55eJ4Ecou7UgiNb3%2BW3vX6dJOeIK%2FIMgXzKys0NrKwIFv6wEgcvHWyCmtJIdI4o0vwf519AvElPNp3oeun4rn3gtgwkbbGtWziLL19NgwE4%2FXEM%2BC9UhZnBIfI7lK%2BcI3MvLXfyakrFB4DKwCiAkXY4dsJPuc8pAIIns%3D&os=5.1-1466951374_stable"
//资讯  头条接口
#define kNewsHeadline @"http://reader.meizu.com/android/unauth/index/articles.do?supportSDK=16&columnIds=34_36_1_2_19_20_16_4_25_5_14&deviceType=MX5&v=2801&operator=46002&flymeuid=111047824&nt=wifi&vn=2.8.01&deviceinfo=GvvP2lE2HEYVI9mI2Am8fNiZohBKv17FEYKc7ZDRKfvBq53CT6KV8nsO5QU6V%2BEFlROswWG1wIUOKfxYLxsmKhMpL32grYS0h5zBbyR2Qt%2FH%2FnlPC0C5yDOgOEqP6icDPCSGKVlQYc6ZT9WBK8wUJbDlUbcwZ%2BV3OgM8OLutk04%3D&os=5.1-1466951374_stable"
//奥运会接口
//#define kNewsOlympicGames @"https://m.uczzd.cn/iflow/api/v1/channel/23154031?recoid=8620443132189663885&method=his&app=meizunews-iflow&auto=0&uc_param_str=frvesvmibichntgsdd&count=20&no_op=0&ftime=1470461567000&content_ratio=0&fr=android&ve=1.1.0&sv=official&mi=MX5&bi=35019&ch=meizu_news_sdk&nt=2&gs=lat:2147483647;lon:2147483647&dd=Vm1FaFNSVmh6cEVEQVBWN1lqaFlPNHJ1"

#define kNewsOlympicGames @"https://m.uczzd.cn/iflow/api/v1/channel/100?recoid=7046017342503628567&method=new&app=meizunews-iflow&auto=0&uc_param_str=frvesvmibichntgsdd&count=20&no_op=0&ftime=1471329306097&content_ratio=0&fr=android&ve=1.1.0&sv=official&mi=MX5&bi=35019&ch=meizu_news_sdk&nt=2&gs=lat:2147483647;lon:2147483647&dd=Vm1FaFNSVmh6cEVEQVBWN1lqaFlPNHJ1"
//美女接口
#define kNewsBeautyGirls @"http://reader.meizu.com/android/unauth/img/channelImgList.do?position=0&type=1&v=2801&operator=46002&flymeuid=111047824&nt=wifi&vn=2.8.01&deviceinfo=IE%2BNY1VUH%2BzqTd3BX%2F1xTf%2FHJ8ySMW%2BGk1uFiJU6Zbnf94oGd9vL4jKzd69VCYMMwkK%2Bhg1gwflWcamnnYNJ5T7%2BmkrjzHtgyCZZdycq5I1v9s91T6YDVSADjT0HFlIQ8goxnOIF6JcmRHzsT2KmzDIevZXf1Nb7OYBl9MDrjgM%3D&os=5.1-1466951374_stable"
//订阅 接口
#define kNewsSubscription @"http://reader.meizu.com/android/unauth/columns/articles.do?columnId=20&sourceIds=36_108_358_143_1006&v=2801&operator=46002&flymeuid=111047824&nt=wifi&vn=2.8.01&deviceinfo=LoFxlNF2vo9UDzhhdc9XEPfRrFvzewQxRUb3wPIUZIJd42WRTrxYEOQlEWCGIlND71%2BAKrBcrTgb8fseA7f1db07R3U0b%2FBhVZeuGfVjWDq2LZaPhwKhtBolNTe0cwlwrMBcUtm47HGJ%2Fds%2BsyTig0NRv9Zhmq9uZH4Da6dXkwA%3D&os=5.1-1466951374_stable"
//搞笑  接口
#define kNewsMakeJoke @"http://reader.meizu.com/android/unauth/columns/article/list.do?columnId=16&v=2801&operator=46002&flymeuid=111047824&nt=wifi&vn=2.8.01&deviceinfo=fiAKBiOwzfy0NOs%2FVbgDTim0p3HRG1syDB3%2BYOLEUI5qpOPEaY9ef%2FcOgYUXVR%2Fk9ySKYBVFN7YOKzDPgHFjyq%2BCo%2BBkbem4pah3rJGUq42mkBOrxGnU%2BpbAPfjQkO1aeN2Xj40uYvzC31z987TZXs2mQ61R%2Fj1BQQ16FSAUh10%3D&os=5.1-1466951374_stable"
//社会  接口
#define kNewsSociety @"http://rmrbapi.people.cn/ask/list?count=20&maxid=&userid=6494101&client_ver=5.3.2&visit_start_time=1470475694548&city=??&citycode=&device_os=4.3&device_model=OPPO-R7007&channel_num=oppo&province=??&longitude=&district=&platform=android&device_product=OPPO&securitykey=3fa06ed123f51bf8052640f07cd9a479&sp=????&device_size=720.0x1280.0&MNC=02&app_key=2_2015_03_52&udid=864892021698688&ctime=1470475694547&client_code=73&sessionId=c0a1c65badea40e3b8e26a8add76165ebXiJpxtM&visit_id=1470475694548&adcode=&isoCC=cn&MCC=460&latitude=&network_state=wifi"


#define kNewsSociety1 @"https://m.uczzd.cn/iflow/api/v1/channel/1192652582?recoid=17734765233793088968&method=new&app=meizunews-iflow&auto=0&uc_param_str=frvesvmibichntgsdd&count=20&no_op=0&ftime=1470901731166&content_ratio=0&fr=android&ve=1.1.0&sv=official&mi=MX5&bi=35019&ch=meizu_news_sdk&nt=2&gs=lat:2147483647;lon:2147483647&dd=Vm1FaFNSVmh6cEVEQVBWN1lqaFlPNHJ1"


#endif /* HeaderFile_h */
