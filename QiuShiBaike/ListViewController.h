//
//  NewTableViewController.h
//  QiuShiBaike
//
//  Created by 翁佳 on 15-6-2.
//  Copyright (c) 2015年 翁佳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate>

- (instancetype)initWithAttributes :(NSArray *)commonInfos :(NSInteger)jokeType;

@end
