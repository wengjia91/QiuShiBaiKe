//
//  ButtomGroupView.m
//  QiuShiBaike
//
//  Created by wengjia on 15/6/4.
//  Copyright (c) 2015年 翁佳. All rights reserved.
//

#import "ButtonGroupView.h"
#import "Masonry/Masonry.h"

#define SLIDERVIER_TAG 100001

@interface ButtonGroupView ()
@property (nonatomic, weak) UIButton *previousButton;
@property (nonatomic, weak) UIButton *afterButton;
@end


@implementation ButtonGroupView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor orangeColor];
    }
    return self;
}

- (void)setContentProvider:(NSArray *)contentProvider{
    _contentProvider = contentProvider;
    [self configureView];
}

- (void)configureView{
    //create slider view default index 0
    UIView *sliderView = [[UIView alloc]initWithFrame:[self positionForButtonAtIndex:0]];
    sliderView.tag = SLIDERVIER_TAG;
    sliderView.backgroundColor = [UIColor whiteColor];
    [self addSubview:sliderView];
    
    //create button
    for (int i = 0 ; i < _contentProvider.count ; i++) {
        UIButton *tabarButtom = [UIButton buttonWithType:UIButtonTypeCustom];
        tabarButtom.frame = [self positionForButtonAtIndex:i];
        [tabarButtom setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [tabarButtom addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [tabarButtom setTitle:_contentProvider[i] forState:UIControlStateNormal];
        if (i == 0) {
            [tabarButtom setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            self.previousButton = tabarButtom;
        }
        [self addSubview:tabarButtom];
    }
}

- (CGRect)positionForButtonAtIndex:(NSInteger)index{
    //calculate button position
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    return CGRectMake((index*(screenSize.width/_contentProvider.count)), 0, screenSize.width/_contentProvider.count, 51);
}

- (NSInteger)indexForButtonPosition:(CGRect)rect{
    //calculate button index
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGRect buttonSize = rect;
    return (buttonSize.origin.x/(screenSize.width/_contentProvider.count));
}


#pragma mark - Event
- (IBAction)buttonPressed:(UIButton *)sender {
    self.afterButton = sender;
    NSInteger previousIndex = [self indexForButtonPosition:self.previousButton.frame];
    NSInteger afterIndex = [self indexForButtonPosition:self.afterButton.frame];
    if (previousIndex == afterIndex) {
        return;
    }
    else
    {
        [self.afterButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [self.previousButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.2 animations:^{
            UIView *sliderView = [self viewWithTag:SLIDERVIER_TAG];
            sliderView.frame = self.afterButton.frame;
        }];
        self.previousButton = self.afterButton;
        if ([self.delegate respondsToSelector:@selector(tabarPressedAtIndex:)]) {
            [self.delegate tabarPressedAtIndex:afterIndex];
        }
    }
}

@end
