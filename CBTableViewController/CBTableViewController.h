//
//  CBTableViewController.h
//  CBTableViewController
//
//  Created by vernon on 15/7/27.
//  Copyright (c) 2015年 coderbook. All rights reserved.
//

#import <UIKit/UIKit.h>

static const int defaultPageSize=10;


@protocol CBTableViewControllerNetWork <NSObject>
@required

-(void)send:(NSString*)url params:(NSDictionary*)params success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure;

-(void)send:(NSString*)url params:(NSDictionary*)params success:(void (^)(id responseObject))success;

-(void)send:(NSString*)url params:(NSDictionary*)params hudMessage:(NSString*)message success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end


@interface CBTableViewController : UIViewController<UITableViewDataSource>{
    NSMutableArray * _data;
    
    int _firstPageIndex;
    
    int _currentPage;
    
    int _pageSize;
    
    int _totalSize;
    
    NSString * _totalSizeName;
    
    NSString *_action;
    
    NSString *_currentPageKey;
    
    NSString *_pageSizeKey;
    
    NSString *_responseDataKey;
    
    
    NSMutableDictionary * _params;
    
    UITableView * _baseTableView;
    
    
    BOOL isFirst;
    
    BOOL isUsingNibCell;

}
@property(nonatomic,assign,setter=setCBTableViewControllerNetWork:)id<CBTableViewControllerNetWork> networkHandler;
@property(nonatomic) BOOL isFirstLoad;


-(void)refresh;

-(void)clear;

-(void)setCBTableViewControllerNetWork:(id<CBTableViewControllerNetWork>)network;

-(void)setNeedLoadMoreFeature;

#pragma -mark 子类必须调用的方法
/**
 对tableview进行初始化设置
 @param tableivew 要进行设置的tableview
 @param action 请求数据的地址
 @param curPage 请求参数中currentpage 的key 没有可以为nil
 @param pageSize 请求参数中pageSize的key  没有可以为nil
 **/
-(void)initTableView:(UITableView*)tableView action:(NSString*)action reqCurrentPagekey:(NSString*)curPage reqPageSizeKey:(NSString*)pageSize andNetWorkHandler:(id<CBTableViewControllerNetWork>)network;

-(void)setTableCellIdentifier:(NSString*)identity withNibName:(NSString*)nibName;

-(void)setTableCellIdentifier:(NSString*)identity withCellCalss:(Class)cellClazz;

#pragma -mark  子类必须实现的方法
-(Class)getItemModelClazz;

@end
