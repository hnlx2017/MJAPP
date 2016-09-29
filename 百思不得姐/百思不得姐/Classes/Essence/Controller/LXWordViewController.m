//
//  LXWordViewController.m
//  百思不得姐
//
//  Created by LiuXing on 16/9/23.
//  Copyright © 2016年 kmznst. All rights reserved.
//

#import "LXWordViewController.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import <MJExtension.h>
#import "LXTopic.h"
#import <MJRefresh.h>
#import "LXTopicCell.h"


@interface LXWordViewController ()
/**  */
@property (nonatomic,strong) NSMutableArray *topics;
/** 当前页 */
@property (nonatomic,assign) NSInteger page;
/** 加载下一页 */
@property (nonatomic,copy) NSString * maxtime ;
@property (nonatomic, strong) NSDictionary *params;

@end

@implementation LXWordViewController





/** topics */
- (NSMutableArray *)topics{
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    /** 初始化表格 */
    [self setupTableView];
    // 加载刷新控件
    [self setupRefresh];
   

}

static NSString *LXTopicId = @"topic";
- (void)setupTableView{
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = LXTitilesViewY + LXTitilesViewH;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    //滚动条的内边距
    
    self.tableView.scrollIndicatorInsets =  self.tableView.contentInset;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = LXGlobalBg;
    
    /** 注册 */
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LXTopicCell class]) bundle:nil] forCellReuseIdentifier:LXTopicId];
    
}


/**
 *  加载刷新控件
 */
- (void)setupRefresh{
    self.tableView.mj_header                          = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];/** 加载下拉刷新 */
    self.tableView.mj_header.automaticallyChangeAlpha = YES;//隐藏透明度-下拉刷新
    [self.tableView.mj_header beginRefreshing];

    self.tableView.mj_footer                          = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    /** 一开始默认是隐藏的 */
    
    
    
    
}

/**
 *  下拉刷新
 */
- (void)loadNewUsers{
    
    [self.tableView.mj_footer endRefreshing];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"]    = @"list";
    params[@"c"]    = @"data";
    params[@"type"] = @"29";//加载段子数据
    self.params = params;
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * responseObject) {
        if (self.params != params) return;
        self.maxtime = responseObject[@"info"][@"maxtime"];
        /** 下拉重新覆盖 */
        self.topics  = [LXTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
     
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
         self.page = 0;//加载成功才清零
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

/** 上拉刷新 */
- (void)loadMoreUsers{
 
    if ([self.maxtime isEqualToString:@""]) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    
    [self.tableView.mj_header endRefreshing];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"]       = @"list";
    params[@"c"]       = @"data";
    params[@"type"] = @"29";
    params[@"page"]    = @(self.page + 1);//加载段子数据
    params[@"maxtime"] = self.maxtime;
    self.params = params;
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * responseObject) {
        if (self.params != params) return;
        self.maxtime = responseObject[@"info"][@"maxtime"];
        NSArray *topics = [LXTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:topics];
          self.page++;
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.mj_footer.hidden     =  (self.topics.count == 0);
    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LXTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:LXTopicId];
    cell.topic = self.topics[indexPath.row];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}











@end
