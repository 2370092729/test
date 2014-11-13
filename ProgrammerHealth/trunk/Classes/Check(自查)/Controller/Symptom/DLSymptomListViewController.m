//
//  DLSymptomListViewController.m
//  ProgrammerHealth
//
//  Created by David on 11/7/14.
//  Copyright (c) 2014 Mac. All rights reserved.
//

#import "DLSymptomListViewController.h"
#import "DLSymptomDetailViewController.h"


@interface DLSymptomListViewController ()

@end

@implementation DLSymptomListViewController

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
    // Do any additional setup after loading the view.
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DLSymptomDetailViewController *symDetail = [[DLSymptomDetailViewController alloc] init];
    symDetail.symptomFrame = self.items[indexPath.row];
    symDetail.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:symDetail animated:YES];
}


@end
