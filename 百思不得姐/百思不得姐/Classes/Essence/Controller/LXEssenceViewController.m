//
//  LXEssenceViewController.m
//  百思不得姐
//
//  Created by LiuXing on 16/9/19.
//  Copyright © 2016年 kmznst. All rights reserved.
//

#import "LXEssenceViewController.h"
#import "LXRecommendTagsTableViewController.h"
@interface LXEssenceViewController()

/** indicator */
@property (nonatomic,weak) UIView *indicatorV;
@end

@implementation LXEssenceViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    [self setupNav];
    
    [self setupTitlesView];
}

- (void)setupNav{
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithimage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    LXLogFunc;
    self.view.backgroundColor = LXGlobalBg;
}

- (void)setupTitlesView{
    UIView *titlesView =[[UIView alloc]init];
    titlesView.height = 35;
    titlesView.width = self.view.width;
    titlesView.y = 64;
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    [self.view addSubview:titlesView];
    
    NSArray *titles = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    
    
    CGFloat width = titlesView.width / titles.count;
    CGFloat height = titlesView.height;
    
    for (int i = 0; i< titles.count ; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.width = width;
        btn.height = height;
        btn.x = i * width;
        
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(changeItem:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:btn];
        
    }
    
    UIView *indicatorV = [[UIView alloc]init];
    indicatorV.backgroundColor = [UIColor redColor];
    indicatorV.height = 2;
    indicatorV.y = height - indicatorV.height;
    
    [titlesView addSubview:indicatorV];
    self.indicatorV = indicatorV;
    
}


- (void)changeItem:(UIButton *)btn{
    
    
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorV.width = btn.titleLabel.width;
        self.indicatorV.centerX = btn.centerX;
    }];
   
    
    
}

- (void)tagClick{
    [self.navigationController pushViewController:[[LXRecommendTagsTableViewController alloc]init] animated:YES];
    
}
                                             
@end
