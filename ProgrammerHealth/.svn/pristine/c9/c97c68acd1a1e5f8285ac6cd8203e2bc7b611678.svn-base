//
//  ZZCheckController.m
//  程序员健康
//
//  Created by Mac on 14-11-4.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "ZZCheckController.h"
#import "DLSymptomSearchController.h"
#import "ZZUsualDrugController.h"
#import "DLCommonDiseasesController.h"


@interface ZZCheckController ()

@end

@implementation ZZCheckController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"自查";
    
    [self setupBtnWithButtonType:ZZCheckButtonSelfSymptom];
    [self setupBtnWithButtonType:ZZCheckButtonNormalDisease];
    [self setupBtnWithButtonType:ZZCheckButtonNormalDrug];
}
/**
 *  主界面的添加按钮
 *
 *  @param ZZCheckButtonType 按钮枚举类型
 */
- (void)setupBtnWithButtonType:(ZZCheckButton)ZZCheckButtonType
{
    // 创建三个按钮
    UIButton *btn = [[UIButton alloc] init];
    btn.backgroundColor = ZZRandomColor;
    [self.view addSubview:btn];
    
    switch (ZZCheckButtonType) {
        case ZZCheckButtonSelfSymptom:
            [btn setTitle:@"症状自查" forState:UIControlStateNormal];
            break;
        case ZZCheckButtonNormalDisease:
            [btn setTitle:@"常见病" forState:UIControlStateNormal];
            break;
        case ZZCheckButtonNormalDrug:
            [btn setTitle:@"常见药" forState:UIControlStateNormal];
            break;
        default:
            [btn setTitle:@"呵呵呵" forState:UIControlStateNormal];
            break;
    }
    btn.tag = ZZCheckButtonType;
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    
    // 设置frame
    int row = ZZCheckButtonType/3; // 行号
    int col = ZZCheckButtonType%3; // 列号
    
    CGFloat btnW = self.view.width/3.0;
    CGFloat btnX = col * btnW;
    CGFloat btnY = row * btnW + 100;
    CGFloat btnH = btnW;
    
    btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    
    
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
}


- (void)btnClick:(UIButton *)btn
{
    // 把btn.tag 转换为枚举类
    ZZCheckButton type = btn.tag;
    //    if (type == ZZCheckButtonSelfSymptom) {
    //        DLSymptomSearchController *symVC = [[DLSymptomSearchController alloc] init];
    //        [self.navigationController pushViewController:symVC animated:YES];
    //    }
    
    
    
    switch (type) {
        case ZZCheckButtonSelfSymptom:
            [self pushViewController:[DLSymptomSearchController class]];
            break;
        case ZZCheckButtonNormalDrug:
            [self pushViewController:[ZZUsualDrugController class]];
            break;
        case ZZCheckButtonNormalDisease:
            [self pushViewController:[DLCommonDiseasesController class]];
            break;
            
        default:
            break;
    }
}


#pragma mark - 私有方法
/**
 *  快速push到下一个控制器
 *
 *  @param class 控制器类名
 */
- (void)pushViewController:(Class)class
{
    UIViewController *vc = (UIViewController *)[[class alloc] init];
    // 隐藏tabbar
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
