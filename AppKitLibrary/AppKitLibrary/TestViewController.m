//
//  TestViewController.m
//  AppKitLibrary
//
//  Created by why_ios on 2016/12/29.
//  Copyright © 2016年 jinwei group. All rights reserved.
//

#import "TestViewController.h"

/** 当前屏幕宽度和高度*/
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

@interface TestViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *listTable;

@property (nonatomic, strong) NSMutableArray *listArray;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"例子";
    
    // Do any additional setup after loading the view.
    self.listTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-64)];
    self.listTable.delegate = self;
    self.listTable.dataSource = self;
    [self.view addSubview:self.listTable];
    
    [self.listArray addObjectsFromArray:
  @[@{@"title":@"仿QQ刷新",@"action":@"ViewController"},
    @{@"title":@"年化统计线",@"action":@"OtherViewController"},
                                          ]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellidentifier = @"cellidentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier];
    }
    cell.textLabel.text = [self.listArray[indexPath.row] objectForKey:@"title"];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = [self.listArray objectAtIndex:indexPath.row];
    NSString *action = [dict objectForKey:@"action"];
    if (action) {
        Class oneClass = NSClassFromString(action);
        if (oneClass && [oneClass isSubclassOfClass:[UIViewController class]]) {
            UIViewController *controller = [oneClass new];
            [self.navigationController pushViewController:controller animated:YES];
        }
        
    }
}



- (NSMutableArray *)listArray
{
    if (!_listArray) {
        
        _listArray = [[NSMutableArray alloc]init];
    }
    return _listArray;
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
