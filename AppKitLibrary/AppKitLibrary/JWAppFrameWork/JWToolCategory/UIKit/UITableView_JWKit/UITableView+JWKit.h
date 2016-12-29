//
//  UITableView+JWKit.h
//  AppKitLibrary
//
//  Created by jinwei on 15/10/19.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (JWKit)

/**
 *  Create an UITableView and set some parameters
 *
 *  @param frame              TableView's frame
 *  @param style              TableView's style
 *  @param cellSeparatorStyle Cell separator style
 *  @param separatorInset     Cell separator inset
 *  @param dataSource         TableView's data source
 *  @param delegate           TableView's delegate
 *
 *  @return Returns the created UITableView
 */
+ (UITableView *)initWithFrame:(CGRect)frame
                         style:(UITableViewStyle)style
            cellSeparatorStyle:(UITableViewCellSeparatorStyle)cellSeparatorStyle
                separatorInset:(UIEdgeInsets)separatorInset
                    dataSource:(id <UITableViewDataSource>)dataSource
                      delegate:(id <UITableViewDelegate>)delegate;

/**
 *  Retrive all the IndexPaths for the section
 *
 *  @param section The section
 *
 *  @return Return an array with all the IndexPaths
 */
- (NSArray *)getIndexPathsForSection:(NSUInteger)section;

/**
 *  Retrive the next index path for the given row at section
 *
 *  @param row     Row of the index path
 *  @param section Section of the index path
 *
 *  @return Returns the next index path
 */
- (NSIndexPath *)getNextIndexPath:(NSUInteger)row
                       forSection:(NSUInteger)section;

/**
 *  Retrive the previous index path for the given row at section
 *
 *  @param row     Row of the index path
 *  @param section Section of the index path
 *
 *  @return Returns the previous index path
 */
- (NSIndexPath *)getPreviousIndexPath:(NSUInteger)row
                           forSection:(NSUInteger)section;
@end
