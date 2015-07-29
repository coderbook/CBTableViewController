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


@interface CBTableViewController : UIViewController{
    NSMutableArray * _data;
    
    int _currentPage;
    
    int _pageSize;
    
    int _totalSize;
    
    NSString * _totalSizeName;
    
    NSString *_method;
    
    NSString * _dataKey;
    
    
    NSMutableDictionary * _params;
    
    UITableView * _baseTableView;
    
    
    BOOL isFirst;

}
@property(nonatomic,assign)id<CBTableViewControllerNetWork> networkHandler;
@property(nonatomic) BOOL isFirstLoad;

/**
 对tableview进行初始化设置
 @param tableivew 要进行设置的tableview
 @param method 基于baseurl的请求的api的名字
 @param datakey 返回的数据中包含数据字段的key
 **/
-(void)initTableView:(UITableView*)tableView method:(NSString*)method dataKey:(NSString*)dataKey;

-(void)refresh;

-(void)clear;


@end
