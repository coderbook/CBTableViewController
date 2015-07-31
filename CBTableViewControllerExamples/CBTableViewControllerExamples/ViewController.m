//
//  ViewController.m
//  CBTableViewControllerExamples
//
//  Created by vernon on 15/7/29.
//  Copyright (c) 2015年 coderbook. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "ProjectItemModel.h"

#define CBHOST @"http://123.57.60.191:18080/app/"

static NSString *cellIdentifier=@"CBTableViewCell";

@interface ViewController ()<CBTableViewControllerNetWork,UITextFieldDelegate>{
    IBOutlet UITableView *mTableView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _firstPageIndex=1;//default first index is 0
    
    //here url is http://123.57.60.191:18080/app/appProjectList.htm?pageNumber=1&pageSize=1&bizType=public&status=1
    //maybe you need other common params  ,then you can set them here
    [_params setObject:@"public" forKey:@"bizType"];
    [_params setObject:@"1" forKey:@"status"];
    
    [self initTableView:mTableView action:[NSString stringWithFormat:@"%@appProjectList.htm",CBHOST] reqCurrentPagekey:@"pageNumber" reqPageSizeKey:@"pageSize" andNetWorkHandler:self];
    [self setNeedLoadMoreFeature];
    [self setTableCellIdentifier:cellIdentifier withNibName:cellIdentifier];
    [self refresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma -mark model class

-(Class)getItemModelClazz{
    return [ProjectItemModel class];
}

#pragma -mark CBTableViewControllerNetWork
-(void)send:(NSString*)url params:(NSDictionary*)params success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure{
    [self send:url params:params hudMessage:nil success:success failure:failure];
}

-(void)send:(NSString*)url params:(NSDictionary*)params success:(void (^)(id responseObject))success{
    [self send:url params:params success:success failure:nil];
}

-(void)send:(NSString*)url params:(NSDictionary*)params hudMessage:(NSString*)message success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    if (message) {
        //TODO show
    }
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        if (message) {
            //TODO dismiss
        }
        _totalSize=[[responseObject objectForKey:@"totalPage"] intValue];
        success([responseObject objectForKey:@"list"]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        if (message) {
            //TODO dismiss
        }
    }];
    
}

@end
