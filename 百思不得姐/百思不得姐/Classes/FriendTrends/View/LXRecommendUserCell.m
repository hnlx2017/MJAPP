//
//  LXRecommendUserCell.m
//  百思不得姐
//
//  Created by LiuXing on 16/9/20.
//  Copyright © 2016年 kmznst. All rights reserved.
//

#import "LXRecommendUserCell.h"
#import "LXRecommendUser.h"
#import <UIImageView+WebCache.h>
@interface LXRecommendUserCell()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *ScreenNameLable;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLable;


@end

@implementation LXRecommendUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setUser:(LXRecommendUser *)user{
    _user = user;
    
    self.ScreenNameLable.text = user.screen_name;
    NSString *fansCount = nil;
    if (user.fans_count < 10000) {
        fansCount = [NSString stringWithFormat:@"%zd人关注",user.fans_count];
    }else{
        fansCount = [NSString stringWithFormat:@"%0.1f万人关注",user.fans_count / 10000.0];
    }
    self.fansCountLable.text = fansCount;
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
