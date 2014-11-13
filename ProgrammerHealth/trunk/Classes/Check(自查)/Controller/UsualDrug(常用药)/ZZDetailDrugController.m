//
//  ZZDetailDrugController.m
//  ProgrammerHealth
//
//  Created by Mac on 14-11-8.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "ZZDetailDrugController.h"
#import "ZZDetailDrugMessage.h"
#import "ZZDetailDrugNetwork.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "NSString+tool.h"
#import "ZZMoreDetailController.h"
#define ZZKFontNameLabel [UIFont systemFontOfSize:14]
#define ZZKFontTagLabel [UIFont systemFontOfSize:13]
#define ZZKPadding 10
#define ZZKWith 300


@interface ZZDetailDrugController ()


@property (nonatomic,strong) ZZDetailDrugMessage *drugMessages;

@property (nonatomic,weak) UILabel *nameLabel;
@property (nonatomic,weak) UIImageView *drugImageView;
@property (nonatomic,weak) UILabel *tagLabel;
@property (nonatomic,weak) UIButton *detailBtn;


@end

@implementation ZZDetailDrugController

- (void)loadView
{
    self.view = [[UIScrollView alloc] init];
   
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    // 添加药名nameLabel
    UILabel *nameLabel = [[UILabel alloc] init];
    self.nameLabel = nameLabel;
//    self.nameLabel.backgroundColor = ZZRandomColor;
    [self.view addSubview:nameLabel];
    nameLabel.numberOfLines = 0;
    self.nameLabel.font = ZZKFontNameLabel;
    
    // 添加图片
    UIImageView *drugImageView = [[UIImageView alloc] init];
    self.drugImageView = drugImageView;
    [self.view addSubview:drugImageView];
//    drugImageView.backgroundColor = ZZRandomColor;
    
    // 添加tag
    UILabel *tagLabel = [[UILabel alloc] init];
    tagLabel.numberOfLines = 0;
    self.tagLabel = tagLabel;
    [self.view addSubview:tagLabel];
//    tagLabel.backgroundColor = ZZRandomColor;
    self.tagLabel.font = ZZKFontTagLabel;
    
    // 添加查看详细信息的按钮
    UIButton *detailBtn = [[UIButton alloc] init];
    self.detailBtn = detailBtn;
    [detailBtn setTitle:@"查看更多药品详情" forState:UIControlStateNormal];
    [detailBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [detailBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:detailBtn];
//    detailBtn.backgroundColor = ZZRandomColor;
    self.detailBtn.titleLabel.font = ZZKFontNameLabel;
    [detailBtn addTarget:self action:@selector(detailBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
/**
 *  跳转到药品更多详细内容控制器
 */
- (void)detailBtnClick
{
    ZZMoreDetailController *moreVc = [[ZZMoreDetailController alloc] init];
    moreVc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:moreVc animated:YES];
    moreVc.message = self.drugMessages.message;
    
}

- (void)setID:(NSNumber *)ID
{
    _ID = ID;
    
    // 有了这个ID就可加载详细数据了
    ZZDetailDrugParmeter *ddp = [[ZZDetailDrugParmeter alloc] init];
    ddp.ID = ID;
    
    [ZZDetailDrugNetwork detailDrugNetworkParmeters:ddp success:^(ZZDetailDrugResult *responseObject) {
        
        self.drugMessages =  responseObject.detailDrugMessage;
        MyLog(@"网络加载成功");
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setupSubView];
        });
        
    } failure:^(NSError *error) {
        MyLog(@"网络加载失败--%@",error);
    }];
    
}

- (void)setupSubView
{
    // 显示数据
    // 药名
    self.nameLabel.text = self.drugMessages.name;
    CGSize nameLabelSize = [self.drugMessages.name sizeWithFont:ZZKFontNameLabel andMaxSize:CGSizeMake(300, MAXFLOAT)];
    CGFloat nameLabelX = ZZKPadding;
    CGFloat nameLabelY = ZZKPadding;
    self.nameLabel.frame = CGRectMake(nameLabelX, nameLabelY, nameLabelSize.width, nameLabelSize.height);
    
    // 图片
    NSURL *imageURL = [NSURL URLWithString:[PHKBaseUrlString stringByAppendingString:self.drugMessages.image]] ;
    [self.drugImageView sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"133550N3Q0920-122E26"]];
    
    CGFloat drugImageViewX = ZZKPadding;
    CGFloat drugImageViewY = CGRectGetMaxY(self.nameLabel.frame) + ZZKPadding;
    CGFloat drugImageViewW = 100;
    CGFloat drugImageViewH = 100;
    self.drugImageView.frame = CGRectMake(drugImageViewX, drugImageViewY, drugImageViewW, drugImageViewH);
    
    // 简介tag
    self.tagLabel.text = self.drugMessages.tag;
    CGFloat tagLabelX = ZZKPadding;
    CGFloat tagLabelY = CGRectGetMaxY(self.drugImageView.frame) + ZZKPadding;
    CGSize tagLabelSize = [self.drugMessages.tag sizeWithFont:ZZKFontTagLabel andMaxSize:CGSizeMake(300, MAXFLOAT)];
    self.tagLabel.frame = CGRectMake(tagLabelX, tagLabelY, tagLabelSize.width, tagLabelSize.height);
    
    // 按钮
    CGFloat detailBtnX = ZZKPadding;
    CGFloat detailBtnY = CGRectGetMaxY(self.tagLabel.frame) + ZZKPadding;
    CGSize detailBtnSize = [self.detailBtn.titleLabel.text sizeWithFont:ZZKFontNameLabel andMaxSize:CGSizeMake(300, MAXFLOAT)];
    self.detailBtn.frame = CGRectMake(detailBtnX, detailBtnY, detailBtnSize.width, detailBtnSize.height);
  
    
    
    UIScrollView *sv = (UIScrollView *)self.view;
    sv.contentSize = CGSizeMake(ZZKScreenWidth, CGRectGetMaxY(self.detailBtn.frame));
}



@end
