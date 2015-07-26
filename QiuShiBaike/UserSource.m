//
//  UserSource.m
//  QiuShiBaike
//
//  Created by 翁佳 on 15-6-7.
//  Copyright (c) 2015年 翁佳. All rights reserved.
//

#import "UserSource.h"

@interface UserSource ()

@property (readwrite, nonatomic, copy) NSString *login;
@property (readwrite, nonatomic, copy) NSString *id;
@property (readwrite, nonatomic, copy) NSString *iconUrl;

@end

@implementation UserSource

- (instancetype)initWithAttributes:(NSDictionary *)attributes{
    if (self == [super init]) {
        //属性赋值［NSULL null］报错 原因user字段为[NSNull null]
        if ((id)attributes == [NSNull null] || attributes == nil || attributes.allKeys.count <= 0) return nil;
        self.login = [attributes valueForKey:@"login"];
        self.id = [attributes valueForKey:@"id"];
        NSString *iconStr = [[attributes valueForKey:@"icon"] isEqual:[NSNull null]] ? nil :[attributes valueForKey:@"icon"];
        if (iconStr) {
            self.iconUrl = [NSString stringWithFormat:@"http://pic.qiushibaike.com/system/avtnew/%@/%@/medium/%@", [self.id substringToIndex:4], self.id, iconStr];
        }
    }
    return self;
}

@end
