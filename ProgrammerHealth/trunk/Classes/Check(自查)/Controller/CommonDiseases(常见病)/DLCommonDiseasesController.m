//
//  DLCommonDiseasesController.m
//  ProgrammerHealth
//
//  Created by David on 11/9/14.
//  Copyright (c) 2014 Mac. All rights reserved.
//

#import "DLCommonDiseasesController.h"
#import "CommomDiseasesTable.h"
#import "PHNetworkTool.h"
#import "MBProgressHUD+Extend.h"
#import "DLSymptomListViewController.h"
#import "DLSymptom.h"
#import "MJExtension.h"
#import "DLSymptomTool.h"
#import "DLSymptomListViewController.h"



@interface DLCommonDiseasesController ()

@end

@implementation DLCommonDiseasesController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 添加常见病的列表数据
    [self setupDiseasesTable];
    
    // 接收btn点击的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(testWithNoti:) name:CommonDiseasesBtnNoti object:nil];
    
    // 接收数据库回调的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(prepearingToPushViewController:) name:CommonDiseasesNoti object:nil];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupDiseasesTable
{
    CommomDiseasesTable *table = [[CommomDiseasesTable alloc] init];
    
    // 通过数组告诉列表我要显示多少个btn，以及这些btn的title
    table.items = @[@"眼部不适", @"记忆衰退", @"失眠",@"健忘"];
    
    [self.view addSubview:table];
    table.y = 120;
}

- (void)searchWithKeyWord:(NSNotification *)noti
{
    // 1. 提示用户正在加载，并且关闭用户交互
    [MBProgressHUD showMessage:@"正在拼命加载中..."];
    self.view.window.userInteractionEnabled = NO;
    
    // 2. 异步发送请求
    NSString *urlStr = NSStringFormat(@"http://api.yi18.net/symptom/search?keyword=%@&limit=50",noti.userInfo[@"keyWord"]);
    [PHNetworkTool getWithUrlString:urlStr parameters:nil success:^(id responseObject) {
        [MBProgressHUD hideHUD];
        self.view.window.userInteractionEnabled = YES;
        
        // 3. 如果搜索结果有数据
        if ([responseObject[@"yi18"] count]) {
            // 4. 创建目标控制器
            DLSymptomListViewController *symList = [[DLSymptomListViewController alloc] init];
            // 4.1 给目标控制器传递模型
            symList.items = [DLSymptom objectArrayWithKeyValuesArray:responseObject[@"yi18"]];
            [self.navigationController pushViewController:symList animated:YES];
        }else
        {   // 如果没有搜索结果
            [MBProgressHUD showError:@"词条被度娘偷走了。换个词试试?"];
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"搜索失败，请检查您的网络情况，稍后再试。"];
        self.view.window.userInteractionEnabled = YES;
    }];
}

- (void)testWithNoti:(NSNotification *)noti
{
    [MBProgressHUD showMessage:@"正在拼命加载中..."];
    self.view.window.userInteractionEnabled = NO;
    NSString *keyWord = noti.userInfo[@"keyWord"];
    [DLSymptomTool queryWithKeyValue:keyWord andNoti:CommonDiseasesNoti];
}

- (void)prepearingToPushViewController:(NSNotification *)noti
{
    [MBProgressHUD hideHUD];
    self.view.window.userInteractionEnabled = YES;

    NSMutableArray *ary = [NSMutableArray array];
    for (DLSymptom *sym in noti.userInfo[CommonDiseasesNoti]) {
        DLSymptomFrame *frame = [[DLSymptomFrame alloc] init];
        frame.symptom = sym;
        [ary addObject:frame];
    }
    
    DLSymptomListViewController *symVC = [[DLSymptomListViewController alloc] init];
    symVC.items = ary;
    
    [self.navigationController pushViewController:symVC animated:YES];
}

@end
