//
//  OlympicModel.h
//  Have a chat
//
//  Created by 黄兵 on 16/8/9.
//  Copyright © 2016年 yun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OlympicModel : NSObject


@property (nonatomic, strong) NSString *title;

//
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSString *source_name;
//
@property (nonatomic, strong) NSNumber *content_length;

// url
@property (nonatomic, strong) NSString *original_url;

@end
