//
//  LXRecommendTagsTableViewController.m
//  百思不得姐
//
//  Created by LiuXing on 16/9/21.
//  Copyright © 2016年 kmznst. All rights reserved.
//

#import "LXRecommendTagsTableViewController.h"
#import <SVProgressHUD.h>
#import <AFNetworking.h>
#import <MJExtension.h>
#import "LXRecommendTag.h"
#import "LXRecommendTagCell.h"

@interface LXRecommendTagsTableViewController ()
/**  */
@property (nonatomic,strong) NSArray *tags;

@end

@implementation LXRecommendTagsTableViewController
static NSString *const LXTagId = @"tag";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"推荐标签";
    [self setupTableView];
    [self loadTagData];
    
}

- (void)setupTableView{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LXRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:LXTagId];
    self.tableView.rowHeight = 70;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = LXGlobalBg;
    
}

- (void)loadTagData{
    //发送请求
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"c"] = @"topic";
    params[@"action"] = @"sub";
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        self.tags = [LXRecommendTag mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
        LXLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载数据失败!"];
        
    }];
}



#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tags.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LXRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:LXTagId];
    
    cell.recommendTag = self.tags[indexPath.row];
    
    return cell;
}

@end
