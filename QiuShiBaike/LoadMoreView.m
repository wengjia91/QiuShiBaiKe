//
//  LoadMoreView.m
//  QiuShiBaike
//
//  Created by 翁佳 on 15-6-8.
//  Copyright (c) 2015年 翁佳. All rights reserved.
//

#import "LoadMoreView.h"

@interface LoadMoreView ()
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@end

@implementation LoadMoreView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.activityIndicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
        self.activityIndicator.color = [UIColor orangeColor];
        self.activityIndicator.center = self.center;
        [self addSubview: self.activityIndicator];
        [self.activityIndicator startAnimating];
    }
    return self;
}





@end
