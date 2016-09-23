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

@interface LXWordViewController ()
/**  */
@property (nonatomic,strong) NSArray *topics;

@end

@implementation LXWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @"29";

    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * responseObject) {
        self.topics  = [NSArray arrayWithArray:responseObject[@"list"]];
        [self.tableView reloadData];
        
           } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
  
    }];



}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    NSDictionary *topic = self.topics[indexPath.row];
    cell.textLabel.text = topic[@"name"];
    cell.detailTextLabel.text = topic[@"text"];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:topic[@"profile_image"]] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    
    return cell;
}

@end
