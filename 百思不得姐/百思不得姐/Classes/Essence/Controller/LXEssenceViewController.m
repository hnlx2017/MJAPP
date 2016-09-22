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
/** 上一次点击的按钮 */
@property (nonatomic,weak) UIButton  *preButton;
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
    
    UIView *indicatorV = [[UIView alloc]init];
    indicatorV.backgroundColor = [UIColor redColor];
    indicatorV.height = 2;
    indicatorV.y = height - indicatorV.height;
    
    [titlesView addSubview:indicatorV];
    self.indicatorV = indicatorV;
    
    for (int i = 0; i< titles.count ; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.width = width;
        btn.height = height;
        btn.x = i * width;
        
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        /**
         *  利用UIControlStateDisabled让Btn只能点击一次
         */
//        [btn layoutIfNeeded];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(changeItem:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:btn];
        if (i == 0) {
            self.preButton.enabled = YES;
            btn.enabled = NO;
            self.preButton = btn;
            [btn.titleLabel sizeToFit];
            self.indicatorV.width = btn.titleLabel.width;
            self.indicatorV.centerX = btn.centerX;
        }
        
    }
    
   
    
}


- (void)changeItem:(UIButton *)btn{
    
    self.preButton.enabled = YES;
    btn.enabled = NO;
    self.preButton = btn;
    
    
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorV.width = btn.titleLabel.width;
        self.indicatorV.centerX = btn.centerX;
    }];
   
    
    
}

- (void)tagClick{
    [self.navigationController pushViewController:[[LXRecommendTagsTableViewController alloc]init] animated:YES];
    
}
                                             
@end
