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
        publishButton.size = publishButton.currentBackgroundImage.size;
        self.publishButton = publishButton;
        [self addSubview:publishButton];
    }
    return self;
}



- (void)layoutSubviews{
    [super layoutSubviews];
  
    self.publishButton.center = CGPointMake(self.width * 0.5, self.height * 0.5);
    
        CGFloat buttonY = 0;
        CGFloat buttonW = self.width / 5.0;
        CGFloat buttonH = self.height;
    NSInteger index = 0;
    for (UIView *btn in self.subviews) {
        if (![btn isKindOfClass:[UIControl class]] || btn == self.publishButton) continue;
        CGFloat buttonX = ((index>1)?index+1:index) * buttonW;
       
        btn.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        index++;
        
    }
}

@end
