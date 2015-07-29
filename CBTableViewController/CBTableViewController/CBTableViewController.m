//
//  CBTableViewController.m
//  CBTableViewController
//
//  Created by vernon on 15/7/27.
//  Copyright (c) 2015年 coderbook. All rights reserved.
//

#import "CBTableViewController.h"
#import <MJRefresh/MJRefresh.h>

typedef NS_ENUM(int, LOADTYPE) {
    REFRESH,
    LOADMORE
};


@interface CBTableViewController()<UITableViewDataSource,UITableViewDelegate>{
    MJRefreshHeader *_header;
    MJRefreshFooter *_footer;
    CGFloat _tableViewHeight;
}

@end


@implementation CBTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    _params = [NSMutableDictionary dictionary];
    _data = [NSMutableArray array];
    _totalSize = -1;
    _currentPage = 1;
    isFirst = YES;
    _pageSize = defaultPageSize;
    _totalSizeName = @"totalPage";
    
}

-(void)initTableView:(UITableView*)tableView method:(NSString*)method dataKey:(NSString*)dataKey{
    _method = method;
    _dataKey = dataKey;
    
    _baseTableView = tableView;
    _tableViewHeight = _baseTableView.frame.size.height;
    _baseTableView.delegate = self;
    _baseTableView.dataSource = self;
    _baseTableView.header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
}

-(void)refresh{
    
}

-(void)clear{

}

-(void)loadData:(LOADTYPE)type{
    
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

@end
