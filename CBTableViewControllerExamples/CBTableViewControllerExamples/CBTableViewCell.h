//
//  CBTableViewCell.h
//  CBTableViewControllerExamples
//
//  Created by vernon on 15/7/30.
//  Copyright (c) 2015年 coderbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CBTableViewController/CBTableCellProtocol.h>
@interface CBTableViewCell : UITableViewCell<CBTableCellProtocol>

@property(nonatomic,weak)IBOutlet UILabel *availableLabel;
@property(nonatomic,weak)IBOutlet UILabel *loanPurposeLabel;
@end
