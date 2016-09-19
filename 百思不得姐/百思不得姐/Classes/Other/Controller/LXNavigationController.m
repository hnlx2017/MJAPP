//
//  LXNavigationController.m
//  百思不得姐
//
//  Created by LiuXing on 16/9/19.
//  Copyright © 2016年 kmznst. All rights reserved.
//

#import "LXNavigationController.h"

@implementation LXNavigationController
- (void)viewDidLoad{
    [super viewDidLoad];
     [[UINavigationBar appearanceWhenContainedIn:[self class], nil] setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    
    LXLog(@"count = %zd",self.viewControllers.count);
    if (self.viewControllers.count > 0) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"返回" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
       // button.backgroundColor = [UIColor blueColor];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        button.size = CGSizeMake(70, 30);
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    }
    //调用了父类方法，栈内count就加1
    [super pushViewController:viewController animated:animated];
}

- (void)back{
    [self popViewControllerAnimated:YES];
}

@end
