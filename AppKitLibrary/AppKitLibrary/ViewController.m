//
//  ViewController.m
//  AppKitLibrary
//
//  Created by jinwei on 15/10/17.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import "ViewController.h"
#import "UIView+JWKit.h"
#import "UIScrollView+JWRefresh.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) UITableView *listTable;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.listTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 375, 500)];
    self.listTable.delegate = self;
    self.listTable.dataSource = self;
    [self.view addSubview:self.listTable];

    
    //添加刷新控件
    __weak __typeof (self.listTable) weakScrollview = self.listTable;
    
    [self.listTable addRefreshBlock:^{
        
        NSLog(@"5111");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakScrollview finishRefresh:YES];
        });
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellidentifier = @"cellidentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
