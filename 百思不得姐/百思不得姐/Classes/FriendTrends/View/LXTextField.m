//
//  LXTextField.m
//  百思不得姐
//
//  Created by LiuXing on 16/9/22.
//  Copyright © 2016年 kmznst. All rights reserved.
//

#import "LXTextField.h"
#import <objc/runtime.h>


@implementation LXTextField
//第二种改变占位文字的方法

//- (void)drawPlaceholderInRect:(CGRect)rect{
//   
//     [self.placeholder drawInRect:CGRectMake(0, self.height * 0.5 - 5, self.width, self.height) withAttributes:@{
//                                                        NSForegroundColorAttributeName:[UIColor whiteColor]
//                                                        
//                                                        }];
//    
//}

//运行时查找属性
- (void)awakeFromNib{
    [super awakeFromNib];
//    //复制属性列表
//    unsigned int count  = 0;
//    //指向属性首地址的指针
//   Ivar * ivar = class_copyIvarList([UITextField class], &count);
//    for (int i = 0; i < count; i++) {
//       Ivar var = *(ivar + i);
//        LXLog(@"%s",ivar_getName(var));
//        
//        
//    }
//    free(ivar);
    //_placeholderLabel
    
//    UILabel *label = [self valueForKeyPath:@"_placeholderLabel"];
//    label.textColor = self.textColor;
    self.tintColor = self.textColor;
    [self resignFirstResponder];
}


//内部监听光标是否在textField上
//重写两个方法
- (BOOL)becomeFirstResponder{
   [self setValue:self.textColor forKeyPath:@"_placeholderLabel.textColor"];
    
  return  [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder{
    [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    return [super resignFirstResponder];
}

@end
