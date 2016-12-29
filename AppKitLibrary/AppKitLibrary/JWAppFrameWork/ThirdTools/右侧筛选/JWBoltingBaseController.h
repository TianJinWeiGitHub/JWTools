//
//  JWBoltingBaseController.h
//  AppKitLibrary
//
//  Created by jinwei on 15/11/26.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JWBoltingConfi.h"

typedef enum {
    JWBoltingCellTypeMain,
    JWBoltingCellTypePush,
    JWBoltingCellTypeSelect,
    JWBoltingCellTypeShow,
    JWBoltingCellTypePrice,
} JWBoltingCellType;

@interface JWBoltingBaseController : UIViewController

/** 列表 */
@property (nonatomic, strong) UITableView *condictTable;

/** 数据源 */
@property (nonatomic, strong) NSMutableArray *dataArray;

/** 当前选择的数据*/
@property (nonatomic, strong) NSMutableArray *currentSelectedArray;

/** 选择类型 */
@property (nonatomic, assign) JWBoltingCellType cellType;


#pragma mark --methods

/** 左侧按钮点击功能*/
- (void)leftbuttonFunction:(UIButton *)sender;

/** 右侧按钮点击功能*/
- (void)RightbuttonFunction:(UIButton *)sender;



@end
