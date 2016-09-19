//
//  LXTabBar.m
//  百思不得姐
//
//  Created by LiuXing on 16/9/19.
//  Copyright © 2016年 kmznst. All rights reserved.
//

#import "LXTabBar.h"
@interface LXTabBar()

/** 加号按钮 */
@property (nonatomic,weak) UIButton *publishButton;
@end

@implementation LXTabBar
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIButton *publishButton =[UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
        self.publishButton = publishButton;
        [self addSubview:publishButton];
    }
    return self;
}



- (void)layoutSubviews{
    [super layoutSubviews];
   self.publishButton.bounds = CGRectMake(0, 0, self.publishButton.currentBackgroundImage.size.width, self.publishButton.currentBackgroundImage.size.height);
    self.publishButton.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    
        CGFloat buttonY = 0;
        CGFloat buttonW = self.frame.size.width / 5.0;
        CGFloat buttonH = self.frame.size.height;
    NSInteger index = 0;
    for (UIView *btn in self.subviews) {
        if (![btn isKindOfClass:[UIControl class]] || btn == self.publishButton) continue;
        CGFloat buttonX = ((index>1)?index+1:index) * buttonW;
       
        btn.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        index++;
        
    }
}

@end
