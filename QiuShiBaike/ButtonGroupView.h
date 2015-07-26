//
//  ButtomGroupView.h
//  QiuShiBaike
//
//  Created by wengjia on 15/6/4.
//  Copyright (c) 2015年 翁佳. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ButtonGroupDelegate <NSObject>

- (void) tabarPressedAtIndex:(NSInteger)index;

@end

@interface ButtonGroupView : UIView
@property (nonatomic, strong) id <ButtonGroupDelegate> delegate;
@property(nonatomic,copy) NSArray *contentProvider;
@end
