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
#import "LXRecommendCategoryCell.h"
#import "LXRecommendUserCell.h"
#import "LXRecommendCategory.h"
#import "LXRecommendUser.h"

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
/** 用户数据 */
@property (nonatomic,strong) NSArray *users;
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
    
    [self setupTableView];
    
   
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

- (void)setupTableView{
     [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([LXRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:LXCategoryID];
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([LXRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:LXUserID];
    self.userTableView.rowHeight = 70;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
}

#pragma mark -<UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.categoryTableView == tableView) {
         return self.categories.count;
    }else{
        return self.users.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.categoryTableView == tableView) {
         LXRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:LXCategoryID];
    
       cell.category = self.categories[indexPath.row];
      return cell;
    }else{
        LXRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:LXUserID];
        cell.user = self.users[indexPath.row];
        
        return cell;
    }
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - <UITableViewDelegate>
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LXRecommendCategory *c = self.categories[indexPath.row];
    LXLog(@"%@",c.name);
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(c.id);
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      //字典数组转模型数组
      self.users =  [LXRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
       
      
        [self.userTableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
    }];

}

/**
 *  1.目前只能显示1页数据
 2.重复发送请求
 3.网络慢带来的细节问题
 */

@end
