//
//  CBTableViewController.m
//  CBTableViewController
//
//  Created by vernon on 15/7/27.
//  Copyright (c) 2015年 coderbook. All rights reserved.
//

#import "CBTableViewController.h"
#import <MJRefresh/MJRefresh.h>
#import <MJExtension/MJExtension.h>
#import "CBTableCellProtocol.h"

typedef NS_ENUM(int, LOADTYPE) {
    REFRESH,
    LOADMORE
};


@interface CBTableViewController(){
    MJRefreshHeader *_header;
    MJRefreshFooter *_footer;
    CGFloat _tableViewHeight;
    
    Class modelCalzzName;
    
    NSString *_cellIdentifier;
}

@end


@implementation CBTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    _params = [NSMutableDictionary dictionary];
    _data = [NSMutableArray array];
    _totalSize = -1;
    _currentPage = _firstPageIndex;
    _pageSize = defaultPageSize;
    _totalSizeName = @"totalPage";
    
}

-(void)initTableView:(UITableView*)tableView action:(NSString*)action reqCurrentPagekey:(NSString *)curPage reqPageSizeKey:(NSString *)pageSize andNetWorkHandler:(id<CBTableViewControllerNetWork>)network{
    _action = [action copy];
    _currentPageKey = curPage;
    
    _pageSizeKey=pageSize;
    
    _baseTableView = tableView;
    _tableViewHeight = _baseTableView.frame.size.height;
    _baseTableView.dataSource = self;
    _baseTableView.header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    
    [self setCBTableViewControllerNetWork:network];
}

-(void)setNeedLoadMoreFeature{
    _baseTableView.footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

-(void)refresh{
    _currentPage=_firstPageIndex;

    if (_baseTableView.footer.isRefreshing) {
        //try cancel
        [_baseTableView.footer endRefreshing];
    }
    [_data removeAllObjects];
    [_baseTableView reloadData];
    [self loadData:REFRESH];
}

-(void)clear{

}

-(void)loadMoreData{
    if((_totalSize==-1 || _totalSize > _data.count)){
        if (_baseTableView.header.isRefreshing) {
            [_baseTableView.header endRefreshing];
        }
        _currentPage++;
        [self loadData:LOADMORE];
    }
}

-(void)loadData:(LOADTYPE)type{
    LOADTYPE curType=type;
    [_params setObject:[NSNumber numberWithInt:_currentPage] forKey:_currentPageKey];
    [_params setObject:[NSNumber numberWithInt:_pageSize] forKey:_pageSizeKey];
    [self.networkHandler send:_action params:_params success:^(id responseObject) {
        
        if (curType==REFRESH) {
            if (!_baseTableView.header.isRefreshing && _data.count>0) {
                //maybe canceled
                return ;
            }
        }else{
            if (!_baseTableView.footer.isRefreshing) {
                return;
            }
        }
        if ([responseObject isKindOfClass:[NSArray class]]) {
            NSArray *tmpArray= [[self getItemModelClazz] objectArrayWithKeyValuesArray:responseObject];
            [_data addObjectsFromArray:tmpArray];
        }else if ([responseObject isKindOfClass:[NSDictionary class]] && _responseDataKey){
            NSArray *tmpArray= [[self getItemModelClazz] objectArrayWithKeyValuesArray:[responseObject objectForKey:_responseDataKey]];
            [_data addObjectsFromArray:tmpArray];
        }
        
        [_baseTableView.header endRefreshing];
        [_baseTableView.footer endRefreshing];
        
        [_baseTableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

-(void)setTableCellIdentifier:(NSString*)identity withNibName:(NSString*)nibName{
    isUsingNibCell=YES;
    _cellIdentifier=identity;
    if (_baseTableView) {
        [_baseTableView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:identity];
    }else{
        NSLog(@"setTableCellIdentifier:withNibName: 这个方法必须在initTableView方法之后调用");
    }
}

-(void)setTableCellIdentifier:(NSString*)identity withCellCalss:(Class)cellClazz{
    isUsingNibCell=NO;
    _cellIdentifier=identity;
    if (_baseTableView) {
        [_baseTableView registerClass:cellClazz forCellReuseIdentifier:identity];
    }else{
        NSLog(@"setTableCellIdentifier:withNibName: 这个方法必须在initTableView方法之后调用");
    }
}

#pragma -mark tableviewdatasource


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    id  model=[_data objectAtIndex:indexPath.row];
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:_cellIdentifier forIndexPath:indexPath];
    if ([cell respondsToSelector:@selector(setCBCellItemDataSource:)]) {
        [cell performSelector:@selector(setCBCellItemDataSource:) withObject:model];
    }
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _data.count;
}

#pragma -mark  子类必须实现的方法
-(Class)getItemModelClazz{
    NSLog(@"CBTableViewController的getItemModelClazz 这个方法必须由子类实现");
    return [NSObject class];
}

@end
