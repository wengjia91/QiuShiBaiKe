//
//  TabBarViewController.m
//  QiuShiBaike
//
//  Created by 翁佳 on 15-6-2.
//  Copyright (c) 2015年 翁佳. All rights reserved.
//

#import "TabBarViewController.h"
#import "ListViewController.h"
#import "ButtonGroupView.h"

@interface TabBarViewController ()<ButtonGroupDelegate>{
    NSArray *_commonInfos;
}

- (void)initControllers;
- (void)customTabBar;

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _commonInfos = @[@"最新", @"最热", @"真相", @"关于我"];
    [self customTabBar];
    [self initControllers];
}

#pragma mark - Tabbar
- (void)customTabBar{
    self.tabBar.hidden = YES;
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    ButtonGroupView *tabGroupView = [[ButtonGroupView alloc]initWithFrame:CGRectMake(0, screenSize.height - 51, screenSize.width, 51)];
    tabGroupView.delegate = self;
    tabGroupView.contentProvider = _commonInfos;
    [self.view addSubview:tabGroupView];
}

#pragma mark - Navigation
- (void)initControllers{
    UINavigationController *newViewController = [[UINavigationController alloc] initWithRootViewController:[[ListViewController alloc]initWithAttributes:_commonInfos :0]];
    UINavigationController *hotViewController = [[UINavigationController alloc] initWithRootViewController:[[ListViewController alloc]initWithAttributes:_commonInfos :1]];
    UINavigationController *truthViewController = [[UINavigationController alloc] initWithRootViewController:[[ListViewController alloc]initWithAttributes:_commonInfos :2]];
    self.viewControllers = @[newViewController, hotViewController, truthViewController];
    
}

#pragma mark - Delegate
- (void) tabarPressedAtIndex:(NSInteger)index{
    [self setSelectedIndex:index];
}
@end
