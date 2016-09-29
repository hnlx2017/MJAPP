//
//  LXLoginRegisterViewController.m
//  百思不得姐
//
//  Created by LiuXing on 16/9/21.
//  Copyright © 2016年 kmznst. All rights reserved.
//

#import "LXLoginRegisterViewController.h"

@interface LXLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginLeadingConstraint;


@end

@implementation LXLoginRegisterViewController
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    //富文本技术
//    NSAttributedString *placeholder = [[NSAttributedString alloc]initWithString:@"手机号" attributes:attrs];
   // self.phoneField.attributedPlaceholder = placeholder;
    // Do any additional setup after loading the view from its nib.
//     NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc]initWithString:@"手机号"];
//    [placeholder setAttributes:@{
//                                 NSForegroundColorAttributeName:[UIColor redColor],
//                                 NSFontAttributeName:[UIFont systemFontOfSize:16]
//                                } range:NSMakeRange(0, 1)];
//    self.phoneField.attributedPlaceholder = placeholder;
}
- (IBAction)loginRegister:(UIButton *)button {
    [self.view endEditing:YES];
   
    if (self.loginLeadingConstraint.constant == 0) {
         self.loginLeadingConstraint.constant = -self.view.width;
//          button.selected = YES;
        [button setTitle:@"已有帐号" forState:UIControlStateNormal];
    }else{
        self.loginLeadingConstraint.constant = 0;
       [button setTitle:@"登录注册" forState:UIControlStateNormal];
//        button.selected = NO;
    }
    
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];

    
   
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

// 设置状态栏
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
