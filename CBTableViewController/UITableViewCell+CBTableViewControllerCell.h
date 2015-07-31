//
//  UITableViewCell+CBTableViewControllerCell.h
//  Pods
//
//  Created by vernon on 15/7/30.
//
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (CBTableViewControllerCell)

-(void)setCBCellItemDataSource:(id)itemData;
-(id)getCBCellItemDataSource;

@end
