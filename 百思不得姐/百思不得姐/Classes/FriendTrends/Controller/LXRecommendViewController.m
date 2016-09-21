//
//  LXRecommendViewController.m
//  百思不得姐
//
//  Created by liuxing on 16/9/20.
//  Copyright © 2016年 kmznst. All rights reserved.
//

#import "LXRecommendViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import <MJRefresh.h>
#import "LXRecommendCategoryCell.h"
#import "LXRecommendUserCell.h"
#import "LXRecommendCategory.h"
#import "LXRecommendUser.h"

#define LXSelectdeCategory self.categories[self.categoryTableView.indexPathForSelectedRow.row]

@interface LXRecommendViewController ()<UITableViewDataSource,UITableViewDelegate>
/**
 *  左边的类别表格
 */
@property (weak, nonatomic) IBOutlet UITableView *userTableView;
/**
 *  右边的用户表格
 */
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
/** 类别数据 */
@property (nonatomic,strong) NSArray *categories;

@end

@implementation LXRecommendViewController
static NSString *const LXCategoryID = @"Category";
static NSString *const LXUserID = @"User";
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [LXRecommendCategory mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
//        
//        
//    }];
    //控件初始化
    [self setupTableView];
    //添加刷新控件
    [self setupRefresh];
    self.navigationItem.title = @"推荐关注";
    self.view.backgroundColor = LXGlobalBg;
    
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        self.categories = [LXRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        LXLog(@"%@",responseObject);
       
        [self.categoryTableView reloadData];
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
    }];
  
}

/**
 *  控件初始化
 */
- (void)setupTableView{
     [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([LXRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:LXCategoryID];
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([LXRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:LXUserID];
    self.userTableView.rowHeight = 70;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
}


/**
 *  添加刷新控件
 */
- (void)setupRefresh{
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    
    
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    self.userTableView.mj_footer.hidden = YES;
    
}

#pragma mark - 加载用户数据
- (void)loadNewUsers{
    LXRecommendCategory *rc = LXSelectdeCategory;
    
    rc.currentPage = 1;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(rc.id);
    params[@"page"] = @(rc.currentPage);
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //字典数组转模型数组
        NSArray *users =  [LXRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //清除所有旧数据
        [rc.users removeAllObjects];
        [rc.users addObjectsFromArray:users];
        rc.total = [responseObject[@"total"] integerValue];
        [self.userTableView reloadData];
        
        [self.userTableView.mj_header endRefreshing];
        
        [self checkFooterState];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
         [self.userTableView.mj_header endRefreshing];
    }];
    
}

- (void)loadMoreUsers{
    LXRecommendCategory *category = LXSelectdeCategory;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(category.id);
    params[@"page"] = @(++category.currentPage);
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //字典数组转模型数组
        NSArray *users =  [LXRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [category.users addObjectsFromArray:users];
        [self.userTableView reloadData];
       
        [self checkFooterState];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
          [self.userTableView.mj_footer endRefreshing];
    }];

}
/**
 *  时刻监测footer的状态
 */

- (void)checkFooterState{
      LXRecommendCategory *rc = LXSelectdeCategory;
     self.userTableView.mj_footer.hidden = ( rc.users.count == 0);
    if (rc.users.count == rc.total) {//全部加载完毕
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    }else{
        [self.userTableView.mj_footer endRefreshing];
    }
}

#pragma mark -<UITableViewDataSource>
//每次刷新都会来到这个方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.categoryTableView == tableView) return self.categories.count;
   
    //监测footer
        [self checkFooterState];
        return [LXSelectdeCategory users].count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.categoryTableView == tableView) {
         LXRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:LXCategoryID];
    
       cell.category = self.categories[indexPath.row];
      return cell;
    }else{
        LXRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:LXUserID];
       
        cell.user = [LXSelectdeCategory users][indexPath.row];
        
        return cell;
    }
   
}




#pragma mark - <UITableViewDelegate>
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.categoryTableView == tableView) {
        LXRecommendCategory *c = self.categories[indexPath.row];
        
        LXLog(@"%@",c.name);
        //判断右边曾经是不是有数据
        if (c.users.count) {
            [self.userTableView reloadData];
        }else{
            /**
             *  马上刷新数据
             */
            [self.userTableView reloadData];
            
            [self.userTableView.mj_header beginRefreshing];
        }

    }else{
        
    }
    
}

/**
 1.重复发送请求
 2.目前只能显示1页数据
 3.网络慢带来的细节问题
 */

@end
