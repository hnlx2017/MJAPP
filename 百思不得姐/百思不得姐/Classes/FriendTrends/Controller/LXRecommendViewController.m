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
#import "LXRecommendCategory.h"

@interface LXRecommendViewController ()<UITableViewDataSource,UITableViewDelegate>
/**
 *  左边的类别表格
 */
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
/** 类别数组 */
@property (nonatomic,strong) NSArray *categories;
@end

@implementation LXRecommendViewController
static NSString *const LXCategoryID = @"Category";
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [LXRecommendCategory mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
//        
//        
//    }];
    
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([LXRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:LXCategoryID];
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

#pragma mark -<UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.categories.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LXRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:LXCategoryID];
    
    cell.category = self.categories[indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
