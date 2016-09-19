//
//  LXTabBarcontroller.m
//  百思不得姐
//
//  Created by LiuXing on 16/9/19.
//  Copyright © 2016年 kmznst. All rights reserved.
//

#import "LXTabBarcontroller.h"
#import "LXEssenceViewController.h"
#import "LXNewViewController.h"
#import "LXFriendTrendsViewController.h"
#import "LXMeViewController.h"
#import "LXTabBar.h"



@implementation LXTabBarcontroller



- (void)viewDidLoad{
    [super viewDidLoad];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    dict[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedDict = [NSMutableDictionary dictionary];
    selectedDict[NSFontAttributeName] = dict[NSForegroundColorAttributeName];
    selectedDict[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:[self class], nil];
    
    [item setTitleTextAttributes:dict forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedDict forState:UIControlStateSelected];
    
  
    [self setupChildVC:[[LXEssenceViewController alloc]init] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
   
    [self setupChildVC:[[LXNewViewController alloc]init] title:@"新贴" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    
   
    [self setupChildVC:[[LXFriendTrendsViewController alloc]init] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
   
    [self setupChildVC:[[LXMeViewController alloc]init] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
    [self setValue:[[LXTabBar alloc]init] forKeyPath:@"tabBar"];

    
  
   
    
    
}

- (void)setupChildVC:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString*)seletedImage{
    vc.navigationItem.title = title;
    [vc.tabBarItem setImage:[UIImage imageNamed:image]];
    [vc.tabBarItem setSelectedImage:[UIImage imageNamed:seletedImage]];
    vc.tabBarItem.title = title;
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    
     [[UINavigationBar appearanceWhenContainedIn:[nav class], nil] setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
  
    [self addChildViewController:nav];
}



@end
