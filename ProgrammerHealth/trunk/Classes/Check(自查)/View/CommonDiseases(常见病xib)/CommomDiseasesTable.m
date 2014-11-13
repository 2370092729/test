//
//  CommomDiseasesTable.m
//  ProgrammerHealth
//
//  Created by David on 11/9/14.
//  Copyright (c) 2014 Mac. All rights reserved.
//

#import "CommomDiseasesTable.h"
#import "DLSymptomFrame.h"
#import "DLSymptom.h"

@interface CommomDiseasesTable ()
@property (nonatomic, strong) UIImage *bgImg;
@end

@implementation CommomDiseasesTable

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor yellowColor];
           }
    return self;
}

- (void)setItems:(NSArray *)items
{
    _items = items;
    [self setupBtns];
    int row = (items.count / 3) + 1;
    self.frame = CGRectMake(0, 0, 320, row * 40 + 10);

}

- (void)setupBtns
{
    for (int i = 0; i< self.items.count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        NSString *str = self.items[i];
        [btn setTitle:str forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setBackgroundImage:self.bgImg forState:UIControlStateNormal];
        btn.tag = i;
        [btn addTarget:self action:@selector(btnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
}

- (void)btnDidClick:(UIButton *)btn
{
    // 发出通知。并且把string发出去
    NSDictionary *diseasesDict = @{@"keyWord": btn.currentTitle};
    
    [[NSNotificationCenter defaultCenter] postNotificationName:CommonDiseasesBtnNoti object:nil userInfo:diseasesDict];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // 九宫格部署子控件btn
    CGFloat btnWidth = 80;
    CGFloat btnHeight = 30;
    CGFloat margingX = 30;
    CGFloat margingY = 10;
    
    for (int i = 0; i< self.items.count; i++) {
        UIButton *btn = self.subviews[i];
        int col = i % 3;
        int row = i / 3;
        btn.x = margingX + (btnWidth + 5)* col;
        btn.y = margingY + (btnHeight + margingY) * row;
        btn.width = btnWidth;
        btn.height = btnHeight;
        }
}

- (UIImage *)bgImg
{
    if (!_bgImg) {
        _bgImg = [UIImage imageNamed:@"common_card_middle_background"];
    }
    return _bgImg;
}

@end
