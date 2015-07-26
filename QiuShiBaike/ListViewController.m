//
//  NewTableViewController.m
//  QiuShiBaike
//
//  Created by 翁佳 on 15-6-2.
//  Copyright (c) 2015年 翁佳. All rights reserved.
//

#import "ListViewController.h"
#import "WebJokeSouce.h"
#import "LoadMoreView.h"
#import "MJRefresh.h"

@interface ListViewController (){
    NSString *_jokeTitle;
    NSInteger _jokeType;//用索引值作为jokeType方便辨别各个网络地址
    NSInteger _pageNumber;
}
@property (nonatomic, strong) NSMutableArray * dataSource;
@end

@implementation ListViewController

- (instancetype)initWithAttributes :(NSArray *)commonInfos :(NSInteger)jokeType;{
    if (self = [super init]) {
        _jokeTitle = commonInfos[jokeType];
        _jokeType = jokeType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [self customNavigationTitleLabelWithString :_jokeTitle];
    _pageNumber = 1;
    //调用刷新方法
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl setTintColor:[UIColor orangeColor]];
    [self.refreshControl addTarget:self action:@selector(handleRefreshAction:) forControlEvents:UIControlEventValueChanged];
    [self.refreshControl beginRefreshing];
    [self refreshControlData];
    //初始化加载更多控件
    [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(refreshControlData)];
    self.tableView.footer.textColor = [UIColor orangeColor];
}

#pragma mark - Drop down refresh

- (void)handleRefreshAction:(UIRefreshControl *)sender {
    //刷新前将page重置为1，并清除缓存,重新加载网络资源
    _pageNumber = 1;
    [self refreshControlData];
}

- (void)refreshControlData{
    //刷新(网络请求)
    [WebJokeSouce requestWithJokeType:_jokeType pageNo:_pageNumber success:^(NSMutableArray * webJokeSources) {
        //区分是下拉刷新，还是上拉加载
        if (_pageNumber == 1) {self.dataSource = webJokeSources;}else{[self.dataSource addObjectsFromArray:webJokeSources];}
        [self.refreshControl endRefreshing];
        [self.tableView.footer endRefreshing];
        [self.tableView reloadData];
        _pageNumber++;
        
    } fail:^{
        [self.refreshControl endRefreshing];
        NSLog(@"fail");
    }];
}

- (void)viewDidAppear:(BOOL)animated{
    //以下是iOS 8中非常酷的导航交互方式，可以让用户看到更多内容。滚动页面时隐藏Bar
    [super viewDidAppear:animated];
    self.navigationController.hidesBarsOnSwipe = YES;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SimpleTableIdentifier];
    }
    WebJokeSouce *webJokeSource = self.dataSource[indexPath.row];
    cell.textLabel.text = webJokeSource.user.login;
    cell.detailTextLabel.text = webJokeSource.conetent;
    return cell;
}

#pragma mark - customNavigationItemTitle
- (UILabel *)customNavigationTitleLabelWithString:(NSString *)title{
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setText:title];
    [titleLabel setTextColor:[UIColor orangeColor]];
    return titleLabel;
}
@end
