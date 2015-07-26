//
//  WebJokeSouce.h
//  QiuShiBaike
//
//  Created by 翁佳 on 15-6-4.
//  Copyright (c) 2015年 翁佳. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "UserSource.h"

@interface WebJokeSouce:NSObject

@property (readonly, nonatomic, assign) long down;//顶
@property (readonly, nonatomic, assign) long up;//踩
@property (readonly, nonatomic, copy) NSString *avatarImageURL;//发表的图片地址
@property (readonly, nonatomic, copy) NSString *conetent;//发表的评论文字内容
@property (readonly, nonatomic, assign) long comments_count;// 评论数
@property (readonly, nonatomic, copy) NSString *type;
@property (readonly, nonatomic, copy) NSString *id;//identifier
@property (readonly, nonatomic, strong) UserSource *user;

+ (void)requestWithJokeType:(NSInteger)jokeType pageNo:(NSInteger)pageNo success:(void (^)(NSMutableArray * webJokeSources))success fail:(void (^)())fail;
+ (NSString *)getWithUrl:(NSInteger)type pageNo:(NSInteger)pageNo;

@end
