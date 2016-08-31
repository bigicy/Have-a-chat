//
//  SubscriptionModel.h
//  Have a chat
//
//  Created by 黄兵 on 16/8/9.
//  Copyright © 2016年 yun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubscriptionModel : NSObject

// title
@property (nonatomic, strong) NSString *title;
//
@property (nonatomic, strong) NSNumber *pv;
//
@property (nonatomic, strong) NSArray *imgUrlList;

//
@property (nonatomic, strong) NSString *contentSourceName;

//
@property (nonatomic, strong) NSString *articleId;

//
@property (nonatomic, strong) NSString *articleUrl;

@end
