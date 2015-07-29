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

typedef NS_ENUM(int, LOADTYPE) {
    REFRESH,
    LOADMORE
};


@interface CBTableViewController(){
    MJRefreshHeader *_header;
    MJRefreshFooter *_footer;
    CGFloat _tableViewHeight;
    
    Class modelCalzzName;
}

@end


@implementation CBTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    _params = [NSMutableDictionary dictionary];
    _data = [NSMutableArray array];
    _totalSize = -1;
    _currentPage = 0;
    _pageSize = defaultPageSize;
    _totalSizeName = @"totalPage";
    
}

-(void)initTableView:(UITableView*)tableView action:(NSString*)action reqCurrentPagekey:(NSString *)curPage reqPageSizeKey:(NSString *)pageSize{
    _action = [action copy];
    _currentPageKey = curPage;
    
    _pageSizeKey=pageSize;
    
    _baseTableView = tableView;
    _tableViewHeight = _baseTableView.frame.size.height;
    _baseTableView.delegate = self;
    _baseTableView.dataSource = self;
    _baseTableView.header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
}

-(void)refresh{
    _currentPage=0;
    [_params setObject:[NSNumber numberWithInt:_currentPage] forKey:_currentPageKey];
    [_params setObject:[NSNumber numberWithInt:_pageSize] forKey:_pageSizeKey];
    [self loadData:REFRESH];
}

-(void)clear{

}

-(void)loadData:(LOADTYPE)type{
    LOADTYPE curType=type;
    [self.networkHandler send:_action params:_params success:^(id responseObject) {
        if (curType==REFRESH) {
            [_data removeAllObjects];
        }
        if ([responseObject isKindOfClass:[NSArray class]]) {
            NSArray *tmpArray= [[self getItemModelClazz] objectArrayWithKeyValuesArray:responseObject];
            [_data addObjectsFromArray:tmpArray];
        }else if ([responseObject isKindOfClass:[NSDictionary class]] && _responseDataKey){
            NSArray *tmpArray= [[self getItemModelClazz] objectArrayWithKeyValuesArray:[responseObject objectForKey:_responseDataKey]];
            [_data addObjectsFromArray:tmpArray];
        }
        
    } failure:^(NSError *error) {
        
    }];
}


#pragma -mark tableview datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CGFloat height = _tableViewHeight;
    if(_data.count ==0 ){
        height = 0;
    }
    else{
        if((_baseTableView.rowHeight * _data.count) < _tableViewHeight){
            height = (_baseTableView.rowHeight * _data.count);
        }
    }
    
    _baseTableView.frame = CGRectMake(_baseTableView.frame.origin.x, _baseTableView.frame.origin.y, _baseTableView.frame.size.width, height);
    return _data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}


#pragma -mark  子类必须实现的方法
-(Class)getItemModelClazz{
    NSLog(@"CBTableViewController的getItemModelClazz 这个方法必须由子类实现");
    return [NSObject class];
}

@end
