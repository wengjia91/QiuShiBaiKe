//
//  WebJokeSouce.m
//  QiuShiBaike
//
//  Created by 翁佳 on 15-6-4.
//  Copyright (c) 2015年 翁佳. All rights reserved.
//

#import "WebJokeSouce.h"
#import "NetworkEngine.h"

@interface WebJokeSouce()

@property (readwrite, nonatomic, assign) long down;//顶
@property (readwrite, nonatomic, assign) long up;//踩
@property (readwrite, nonatomic, copy) NSString *avatarImageURL;//发表的图片地址
@property (readwrite, nonatomic, copy) NSString *conetent;//发表的评论文字内容
@property (readwrite, nonatomic, assign) long comments_count;// 评论数
@property (readwrite, nonatomic, copy) NSString *type;
@property (readwrite, nonatomic, copy) NSString *id;//identifier
@property (readwrite, nonatomic, strong) UserSource *user;//user info

@end

@implementation WebJokeSouce

- (instancetype)initWithAttributes:(NSDictionary *)attributes {
    //init hot/new/truth model
    if (self == [super init]) {
        self.down = (NSInteger)[[attributes valueForKeyPath:@"votes.down"] integerValue];
        self.up = (NSInteger)[[attributes valueForKeyPath:@"votes.up"] integerValue];
        self.conetent = [attributes valueForKey:@"content"];
        self.comments_count = (NSInteger)[[attributes valueForKey:@"comments_count"] integerValue];
        self.type = [attributes valueForKey:@"type"];
        self.id = [attributes valueForKey:@"id"];
        NSString *imageStr = [[attributes valueForKey:@"image"] isEqual:[NSNull null]] ? nil : [attributes valueForKey:@"image"];
        if (imageStr) {
            self.avatarImageURL = [NSString stringWithFormat:@"http://pic.qiushibaike.com/system/pictures/%@/%@/small/%@", [self.id substringToIndex:4], self.id, imageStr];
        }
        self.user = [[UserSource alloc] initWithAttributes:[attributes valueForKey:@"user"]];
    }
    return self;
}

#pragma mark - Network
+ (NSString *)getWithUrl:(NSInteger)type pageNo:(NSInteger)pageNo
{
    //get append url
    if (type == 0) {
        return [NSString stringWithFormat:@"%@%ld", @"http://m2.qiushibaike.com/article/list/suggest?count=20&page=", (long)pageNo];
    }else if (type == 1){
        return [NSString stringWithFormat:@"%@%ld", @"http://m2.qiushibaike.com/article/list/latest?count=20&page=", (long)pageNo];
    }else if (type == 2){
        return [NSString stringWithFormat:@"%@%ld", @"http://m2.qiushibaike.com/article/list/imgrank?count=20&page=", (long)pageNo];
    }
    return nil;
}

+ (void)requestWithJokeType:(NSInteger)jokeType pageNo:(NSInteger)pageNo success:(void (^)(NSMutableArray * webJokeSources))success fail:(void (^)())fail
{
    //request web joke info and block to controller
    NSString *requestUrl = [self getWithUrl:jokeType pageNo:pageNo];
    [NetworkEngine requestWebSourceWithUrl:requestUrl success:^(NSDictionary *jsonData) {
        NSArray *itemsFromResponse = [jsonData valueForKey:@"items"];
        NSMutableArray *mutableWebJokeSources = [NSMutableArray arrayWithCapacity:[[jsonData valueForKey:@"count"] integerValue]];
        for (NSDictionary *attributes in itemsFromResponse) {
            WebJokeSouce *webSourceData = [[WebJokeSouce alloc] initWithAttributes:attributes];
            if (webSourceData) {[mutableWebJokeSources addObject:webSourceData];}
        }
        success(mutableWebJokeSources);
    } fail:^{
        fail();
    }];
}
@end
