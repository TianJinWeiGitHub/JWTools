//
//  OtherViewController.m
//  AppKitLibrary
//
//  Created by why_ios on 2016/12/29.
//  Copyright © 2016年 jinwei group. All rights reserved.
//

#import "OtherViewController.h"
#import "JWLineChart.h"


@interface OtherViewController ()

@end

@implementation OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    JWLineChart *line = [[JWLineChart alloc]initWithFrame:CGRectMake(0, 100, 300, 400)];
    [self.view addSubview:line];
    [line setChartData:@[@10,@12,@13,@15,@20,@90]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
