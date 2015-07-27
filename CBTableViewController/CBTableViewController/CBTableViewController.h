//
//  CBTableViewController.h
//  CBTableViewController
//
//  Created by vernon on 15/7/27.
//  Copyright (c) 2015年 coderbook. All rights reserved.
//

#import <UIKit/UIKit.h>

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
    
    NSString * _listName;
    
    
    NSMutableDictionary * _params;
    
    UITableView * _baseTableView;
    
    BOOL _isNavLeftButton;
    
    BOOL isFirst;

}
@property(nonatomic,assign)id<CBTableViewControllerNetWork> networkHandler;




@end
