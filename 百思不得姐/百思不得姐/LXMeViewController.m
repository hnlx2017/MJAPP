//
//  LXMeViewController.m
//  百思不得姐
//
//  Created by LiuXing on 16/9/19.
//  Copyright © 2016年 kmznst. All rights reserved.
//

#import "LXMeViewController.h"

@implementation LXMeViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.title = @"我的";
    UIBarButtonItem *setting = [UIBarButtonItem itemWithimage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
     UIBarButtonItem *night = [UIBarButtonItem itemWithimage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(nightClick)];
    self.navigationItem.rightBarButtonItems = @[setting,night];
                                             
}

- (void)settingClick{
    LXLogFunc;
}

- (void)nightClick{
      LXLogFunc;
}
@end
