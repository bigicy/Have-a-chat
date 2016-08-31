//
//  HeaderlineModel.h
//  Have a chat
//
//  Created by 黄兵 on 16/8/8.
//  Copyright © 2016年 yun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeaderlineModel : NSObject

// title
@property (nonatomic, strong) NSString *title;
//
@property (nonatomic, strong) NSNumber *pv;
//
@property (nonatomic, strong) NSArray *imgUrlList;

//
@property (nonatomic, strong) NSString *contentSourceName;

// id
@property (nonatomic, strong) NSString *articleId;

//
@property (nonatomic, strong) NSString *articleUrl;
//

@end
