//
//  NetworkEngine.m
//  QiuShiBaike
//
//  Created by 翁佳 on 15-6-4.
//  Copyright (c) 2015年 翁佳. All rights reserved.
//

#import "NetworkEngine.h"

@interface NetworkEngine()

@end

@implementation NetworkEngine

+ (void)requestWebSourceWithUrl:(NSString *)url success:(void (^)(NSDictionary * jsonData))success fail:(void (^)())fail{
    //URLEncode
    NSString *newStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //create webUrl instance
    NSURL *webUrl = [NSURL URLWithString:newStr];
    //create request instance  ／／此处时异步请求，如果时同步的话，访问超时它会一直阻塞线程
    NSURLRequest *request = [NSURLRequest requestWithURL:webUrl];
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            if (fail) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    fail();
                });
            }
        }
        else{
            NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    success(jsonData);
                });
            }
        }
    }];
}

@end
