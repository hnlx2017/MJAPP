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
/** 请求参数 */
@property (nonatomic,strong) NSMutableDictionary *params;
/** AFN的请求管理者 */
@property (nonatomic,strong) AFHTTPSessionManager *manager;

@end

@implementation LXRecommendViewController
static NSString *const LXCategoryID = @"Category";
static NSString *const LXUserID = @"User";

/** AFN的请求管理者 */
- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [LXRecommendCategory mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
//        
//        
//    }];
    self.navigationItem.title = @"推荐关注";
    self.view.backgroundColor = LXGlobalBg;
    //控件初始化
    [self setupTableView];
    //添加刷新控件
    [self setupRefresh];
    
    [self loadCategories];
    
}

- (void)loadCategories{
   
    
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        self.categories = [LXRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
    
        
        [self.categoryTableView reloadData];
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        [self.userTableView.mj_header beginRefreshing];
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
    self.params = params;
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
     
        //字典数组转模型数组
        NSArray *users =  [LXRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //清除所有旧数据
        [rc.users removeAllObjects];
        [rc.users addObjectsFromArray:users];
        rc.total = [responseObject[@"total"] integerValue];
        if (self.params != params) return;
        [self.userTableView reloadData];
        
        [self.userTableView.mj_header endRefreshing];
        
        [self checkFooterState];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         if (self.params != params) return;
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
     self.params = params;
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //字典数组转模型数组
        NSArray *users =  [LXRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [category.users addObjectsFromArray:users];
        if (self.params != params) return;
        [self.userTableView reloadData];
    
        [self checkFooterState];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         if (self.params != params) return;
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
          [self.userTableView.mj_footer endRefreshing];
    }];

}
/**
 *  时刻监测footer的显示状态
 */

- (void)checkFooterState{
      LXRecommendCategory *rc = LXSelectdeCategory;
    //如果右边没有数据，让它隐藏
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
   
    //监测footer是否加载完毕
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
        //先结束刷新
        [self.userTableView.mj_header endRefreshingCompletionBlock];
        [self.userTableView.mj_footer endRefreshing];
        
        LXRecommendCategory *c = self.categories[indexPath.row];
        
       
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

-(void)dealloc{
    
    //停止管理者中的所有请求操作（一旦退出控制器，避免出现崩溃）
    [self.manager.operationQueue cancelAllOperations];
}

/**
 *
 1.重复发送请求--param来判断最后一次请求，对最后一次请求才去处理
 2.目前只能显示1页数据--对总数判断，请求页数++
 3.网络慢带来的细节问题
 */

@end
