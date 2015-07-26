//
//  NetworkEngine.h
//  QiuShiBaike
//
//  Created by 翁佳 on 15-6-4.
//  Copyright (c) 2015年 翁佳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkEngine : NSObject
+ (void)requestWebSourceWithUrl:(NSString *)url success:(void (^)(NSDictionary * jsonData))success fail:(void (^)())fail;
@end
