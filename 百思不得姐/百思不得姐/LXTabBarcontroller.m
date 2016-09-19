//
//  LXTabBarcontroller.m
//  百思不得姐
//
//  Created by LiuXing on 16/9/19.
//  Copyright © 2016年 kmznst. All rights reserved.
//

#import "LXTabBarcontroller.h"

@implementation LXTabBarcontroller
- (void)viewDidLoad{
    [super viewDidLoad];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    dict[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedDict = [NSMutableDictionary dictionary];
    selectedDict[NSFontAttributeName] = dict[NSForegroundColorAttributeName];
    selectedDict[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    UITabBarItem *tabBar = [UITabBarItem appearanceWhenContainedIn:[self class], nil];
    
    [tabBar setTitleTextAttributes:dict forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedDict forState:UIControlStateSelected];
    
    UIViewController *vc1 = [[UIViewController alloc]init];
    vc1.view.backgroundColor = [UIColor redColor];
    [vc1.tabBarItem setImage:[UIImage imageNamed:@"tabBar_essence_icon"]];
    [vc1.tabBarItem setSelectedImage:[UIImage imageNamed:@"tabBar_essence_click_icon"]];
    vc1.tabBarItem.title = @"精华";
    
    UIViewController *vc2 = [[UIViewController alloc]init];
    [vc2.tabBarItem setImage:[UIImage imageNamed:@"tabBar_new_icon"]];
    [vc2.tabBarItem setSelectedImage:[UIImage imageNamed:@"tabBar_new_click_icon"]];
    vc2.view.backgroundColor = [UIColor yellowColor];
    vc2.tabBarItem.title = @"新贴";
    
    UIViewController *vc3 = [[UIViewController alloc]init];
    [vc3.tabBarItem setImage:[UIImage imageNamed:@"tabBar_friendTrends_icon"]];
    [vc3.tabBarItem setSelectedImage:[UIImage imageNamed:@"tabBar_friendTrends_click_icon"]];
    vc3.view.backgroundColor = [UIColor purpleColor];
    vc3.tabBarItem.title = @"关注";
    
    UIViewController *vc4 = [[UIViewController alloc]init];
    [vc4.tabBarItem setImage:[UIImage imageNamed:@"tabBar_me_icon"]];
    [vc4.tabBarItem setSelectedImage:[UIImage imageNamed:@"tabBar_me_click_icon"]];
    vc4.view.backgroundColor = [UIColor orangeColor];
    vc4.tabBarItem.title = @"我";
    
    self.viewControllers = @[vc1,vc2,vc3,vc4];
}


@end
