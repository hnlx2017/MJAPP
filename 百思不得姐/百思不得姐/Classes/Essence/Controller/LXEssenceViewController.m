//
//  LXEssenceViewController.m
//  百思不得姐
//
//  Created by LiuXing on 16/9/19.
//  Copyright © 2016年 kmznst. All rights reserved.
//

#import "LXEssenceViewController.h"
#import "LXRecommendTagsTableViewController.h"
#import "LXAllViewController.h"
#import "LXVideoViewController.h"
#import "LXVoiceViewController.h"
#import "LXPictureViewController.h"
#import "LXWordViewController.h"
@interface LXEssenceViewController()<UIScrollViewDelegate>

/** indicator */
@property (nonatomic,weak) UIView *indicatorV;
/** 上一次点击的按钮 */
@property (nonatomic,weak) UIButton  *preButton;
/**  */
@property (nonatomic,weak) UIView *titlesView;

/**  */
@property (nonatomic,weak) UIScrollView *contentView;
@end

@implementation LXEssenceViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    //添加子控制器
    [self setupChildVces];
    //设置导航栏
    [self setupNav];
    //设置顶部标题栏
    [self setupTitlesView];
    //设置底部ScrollView
    [self setupContentView];
   
}

- (void)setupChildVces{
    LXAllViewController *allVC = [[LXAllViewController alloc]init];
    [self addChildViewController:allVC];
    LXVideoViewController *videoVC = [[LXVideoViewController alloc]init];
    [self addChildViewController:videoVC];
    LXVoiceViewController *voiceVC = [[LXVoiceViewController alloc]init];
    [self addChildViewController:voiceVC];
    LXPictureViewController *pictureVC = [[LXPictureViewController alloc]init];
    [self addChildViewController:pictureVC];
    LXWordViewController *wordVC = [[LXWordViewController alloc]init];
    [self addChildViewController:wordVC];
 
    
    
}

- (void)setupContentView{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *contentView = [[UIScrollView alloc]init];
    contentView.frame = self.view.bounds;
    contentView.delegate = self;
  // LXLog(@"contentOffset = %@",NSStringFromCGPoint( contentView.contentOffset));
    contentView.pagingEnabled = YES;
   
    //标签栏调到最底下去
    [self.view insertSubview:contentView atIndex:0];
  
    
    self.contentView = contentView;
    //把子控制器放在前面才能取到count
    contentView.contentSize = CGSizeMake(self.childViewControllers.count *contentView.width, 0);
     LXLog(@"contentOffset = %@",NSStringFromCGPoint( contentView.contentOffset));
   
    //在Scroll添加控制器的View
    [self scrollViewDidEndScrollingAnimation:contentView];
    
//    for (NSInteger i = 0; i < self.childViewControllers.count  ; i++) {
//        UITableViewController *vc = self.childViewControllers[i];
//        vc.view.x = i * self.contentView.width;
//        CGFloat top = CGRectGetMaxY(self.titlesView.frame);
//        LXLog(@"contentOffset = %@",NSStringFromCGPoint( vc.tableView.contentOffset));
//        CGFloat bottom = self.tabBarController.tabBar.height;
//        vc.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
//        [self.contentView addSubview:vc.tableView];
//    }
   

    
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
    self.titlesView = titlesView;
    
    
    
    NSArray *titles = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    
    
    CGFloat width = titlesView.width / titles.count;
    CGFloat height = titlesView.height;
    
    UIView *indicatorV = [[UIView alloc]init];
    indicatorV.backgroundColor = [UIColor redColor];
    indicatorV.height = 2;
    
    indicatorV.y = height - indicatorV.height;
    
   
    self.indicatorV = indicatorV;
    
    for (int i = 0; i< titles.count ; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.width = width;
        btn.height = height;
        btn.tag = i;
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
            
            btn.enabled = NO;
            self.preButton = btn;
            //方法1
            //[btn.titleLabel sizeToFit];
            //方法2[titles[i] sizeWithAttributes:@{NSFontAttributeName : btn.titleLabel.font}].width;
            self.indicatorV.width = [titles[i] sizeWithAttributes:@{NSFontAttributeName : btn.titleLabel.font}].width;
            self.indicatorV.centerX = btn.centerX;
        }
        
    }
     [titlesView addSubview:indicatorV];
   
    
}

//事件响应
- (void)changeItem:(UIButton *)btn{
    
    self.preButton.enabled = YES;
    btn.enabled = NO;
    self.preButton = btn;
    
    
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorV.width = btn.titleLabel.width;
        self.indicatorV.centerX = btn.centerX;
    }];
    
    //滚动完才加载子控制器（设置滚动contentoffset）加上动画
    CGPoint offset = self.contentView.contentOffset;//更改当前偏移量的X
    offset.x = btn.tag * self.contentView.width;
    
    [self.contentView setContentOffset:offset animated:YES];
    
   
    
    
}

- (void)tagClick{
    [self.navigationController pushViewController:[[LXRecommendTagsTableViewController alloc]init] animated:YES];
    
}


#pragma mark - <UIScrollViewDelegate>
//当滚动动画完毕时调用（在滚动完毕时我们才去加载控件）
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    NSInteger index = self.contentView.contentOffset.x / self.contentView.width;
    UITableViewController *vc = self.childViewControllers[index];
    vc.view.x = self.contentView.contentOffset.x;
    vc.view.y = 0;
    vc.view.height = self.contentView.height;

    [self.contentView addSubview:vc.tableView];
     
}


//停止减速
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    //停止减速时点击btn
     NSInteger index = self.contentView.contentOffset.x / self.contentView.width;
    
    [self changeItem:self.titlesView.subviews[index]];
    
}

@end
