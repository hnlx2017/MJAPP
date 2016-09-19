//
//  LXEssenceViewController.m
//  百思不得姐
//
//  Created by LiuXing on 16/9/19.
//  Copyright © 2016年 kmznst. All rights reserved.
//

#import "LXEssenceViewController.h"

@implementation LXEssenceViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithimage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(essenceClick)];
    LXLogFunc;
    self.view.backgroundColor = LXGlobalBg;
}

- (void)essenceClick{
    LXLogFunc;
    
}
                                             
@end
