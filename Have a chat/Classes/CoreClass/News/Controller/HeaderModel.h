//
//  HeaderModel.h
//  Have a chat
//
//  Created by 黄兵 on 16/8/9.
//  Copyright © 2016年 yun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeaderModel : NSObject

// 图片
@property (nonatomic, strong) NSArray *imgUrlList;

//
@property (nonatomic, strong) NSString *articleId;

//
@property (nonatomic, strong) NSString *title;

//
@property (nonatomic, strong) NSString *articleUrl;

//
@property (nonatomic, strong) NSString *vScreenImg;
//
@property (nonatomic, strong) NSString *vTitle;

@property (nonatomic, strong) NSString *vId;


@end
