//
//  JWBoltingBaseController.m
//  AppKitLibrary
//
//  Created by jinwei on 15/11/26.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import "JWBoltingBaseController.h"

@interface JWBoltingBaseController () <UITableViewDataSource,UITableViewDelegate>

/** 导航view左侧返回按钮*/
@property (nonatomic, strong) UIButton *leftButton;

/** 导航view右侧侧返回按钮*/
@property (nonatomic, strong) UIButton *rightButton;

/** 导航view标题*/
@property (nonatomic, strong) UILabel *bTitleLabel;

/** 导航view*/
@property (nonatomic, strong) UIView *barView;

@end

@implementation JWBoltingBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    self.title = @"筛选";

    if (self.barView) {
        [self.view addSubview:self.barView];
    }
    if (self.condictTable) {
        [self.view addSubview:self.condictTable];
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- UITableViewDataSource,UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.backgroundColor = [UIColor orangeColor];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.cellType == JWBoltingCellTypeMain || self.cellType == JWBoltingCellTypePrice) {
        return 2;
    }
    if (self.cellType == JWBoltingCellTypeShow) {
        return self.dataArray.count;
    }
    return self.dataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.cellType == JWBoltingCellTypeMain || self.cellType == JWBoltingCellTypePrice) {
        return 2;
    }
    if (self.cellType == JWBoltingCellTypeShow) {
        return self.dataArray.count;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}


#pragma mark -- init views

- (UITableView *)condictTable
{
    if (!_condictTable) {
        _condictTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64)];
        _condictTable.delegate = self;
        _condictTable.dataSource = self;
        _condictTable.tableFooterView = [UIView new];
        _condictTable.backgroundColor = self.view.backgroundColor=[UIColor whiteColor];
    }
    return _condictTable;
}

- (UIView *)barView
{
    if (!_barView ) {
        _barView = [UIView new];
        _barView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 64);
        self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.leftButton setTitleColor:JWBoltingTextGrayColor forState:UIControlStateNormal];
        [self.leftButton setTitleColor:JWBoltingSelectedColor forState:UIControlStateHighlighted];
        [self.leftButton setTitleColor:JWBoltingTextGrayColor forState:UIControlStateSelected];
        [self.leftButton addTarget:self action:@selector(leftbuttonFunction:) forControlEvents:UIControlEventTouchUpInside];
        self.leftButton.frame = CGRectMake(10, 24, 40, 40);
        [self.leftButton setTitle:@"取消" forState:UIControlStateNormal];
        self.leftButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_barView addSubview:self.leftButton];
        
        self.bTitleLabel = [UILabel new];
        self.bTitleLabel.backgroundColor = [UIColor whiteColor];
        self.bTitleLabel.font = [UIFont boldSystemFontOfSize:18];
        self.bTitleLabel.textColor = [UIColor blackColor];
        self.bTitleLabel.frame = CGRectMake(0, 0, 100, 40);
        self.bTitleLabel.center = CGPointMake(_barView.bounds.size.width/2, 24+20);
        self.bTitleLabel.textAlignment = 1;
        if (self.title) {
            self.bTitleLabel.text = self.title;
        }
        [_barView addSubview:self.bTitleLabel];
        
        self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.rightButton setTitleColor:JWBoltingTextGrayColor forState:UIControlStateNormal];
        [self.rightButton setTitleColor:JWBoltingSelectedColor forState:UIControlStateHighlighted];
        [self.rightButton setTitleColor:JWBoltingTextGrayColor forState:UIControlStateSelected];
        [self.rightButton addTarget:self action:@selector(RightbuttonFunction:) forControlEvents:UIControlEventTouchUpInside];
        self.rightButton.frame = CGRectMake(_barView.bounds.size.width-60, 24, 40, 40);
        [self.rightButton setTitle:@"确定" forState:UIControlStateNormal];
        self.rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_barView addSubview:self.rightButton];
        
    }
    return _barView;
}


- (void)setTitle:(NSString *)title
{
    [super setTitle:title];
    if (title) {
        if (self.bTitleLabel) {
            self.bTitleLabel.text = title;
        }
    }
}

- (JWBoltingCellType)cellType
{
    if (!_cellType) {
        _cellType = JWBoltingCellTypeMain;
    }
    return _cellType;
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
