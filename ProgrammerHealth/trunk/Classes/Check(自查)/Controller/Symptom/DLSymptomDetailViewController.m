//
//  DLSymptomDetailViewController.m
//  ProgrammerHealth
//
//  Created by David on 11/7/14.
//  Copyright (c) 2014 Mac. All rights reserved.
//

#import "DLSymptomDetailViewController.h"
#import "DLSymptomFrame.h"
#import "DLSymptom.h"
#import "UIImageView+WebCache.h"


@interface DLSymptomDetailViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic)  UIImageView *symptomImage;
@property (weak, nonatomic)  UILabel *symptomTitle;
@property (weak, nonatomic)  UILabel *symptomContent;

@end

@implementation DLSymptomDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpScrollView];
    [self setData];
    
}

#pragma mark - 创建scrollView
- (void)setUpScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(0, self.symptomFrame.contentHeight + 200);
    [self.view addSubview:scrollView];
    
    UIImageView *symptomImage = [[UIImageView alloc] init];
    [scrollView addSubview:symptomImage];
    self.symptomImage = symptomImage;
    
    UILabel *symptomTitle = [[UILabel alloc] init];
    symptomTitle.backgroundColor = [UIColor lightTextColor];
    symptomTitle.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:symptomTitle];
    self.symptomTitle = symptomTitle;
    
    UILabel *symptomContent = [[UILabel alloc] init];
    symptomContent.numberOfLines = 0;
    symptomContent.font = contenFont;
    [scrollView addSubview:symptomContent];
    self.symptomContent = symptomContent;
}

- (void)setData
{
    DLSymptom *symptom = self.symptomFrame.symptom;
    self.symptomTitle.text = symptom.title;
    self.symptomContent.text = symptom.content;

    [self.symptomImage sd_setImageWithURL:[NSURL URLWithString:symptom.img] placeholderImage:[UIImage imageNamed:@"img1"]];
}


- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.symptomImage.frame = CGRectMake(20, 20, 150, 150);
    self.symptomTitle.frame = CGRectMake(180, 20, 120, 150);
    self.symptomContent.frame = CGRectMake(20, 190, 280, self.symptomFrame.contentHeight);
}

- (void)setSymptomFrame:(DLSymptomFrame *)symptomFrame
{
    // 由于是懒加载，在这里直接对控件进行设置的话，此时的Label还没有被创建出来，为Nil,所以设置无效;
    _symptomFrame = symptomFrame;
}

@end
