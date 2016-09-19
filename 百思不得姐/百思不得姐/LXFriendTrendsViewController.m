//
//  LXFriendTrendsViewController.m
//  百思不得姐
//
//  Created by LiuXing on 16/9/19.
//  Copyright © 2016年 kmznst. All rights reserved.
//

#import "LXFriendTrendsViewController.h"

@implementation LXFriendTrendsViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.title = @"我的关注";
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithimage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsClick)];
    
}

- (void)friendsClick{
    LXLogFunc;
}
                                             
@end
