//
//  UserSource.h
//  QiuShiBaike
//
//  Created by 翁佳 on 15-6-7.
//  Copyright (c) 2015年 翁佳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserSource : NSObject

@property (readonly, nonatomic, copy) NSString *login;
@property (readonly, nonatomic, copy) NSString *id;
@property (readonly, nonatomic, copy) NSString *iconUrl;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

@end
