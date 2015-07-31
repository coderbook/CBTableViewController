//
//  UITableViewCell+CBTableViewControllerCell.m
//  Pods
//
//  Created by vernon on 15/7/30.
//
//

#import "UITableViewCell+CBTableViewControllerCell.h"
#import <objc/runtime.h>


static const char CBTableViewCellDataSourceKEY = '\0';


@implementation UITableViewCell (CBTableViewControllerCell)
-(void)setCBCellItemDataSource:(id)itemData{
    objc_setAssociatedObject(self, &CBTableViewCellDataSourceKEY, itemData, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(id)getCBCellItemDataSource{
    return objc_getAssociatedObject(self, &CBTableViewCellDataSourceKEY);
}
@end
