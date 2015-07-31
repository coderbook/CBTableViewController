//
//  CBTableViewCell.m
//  CBTableViewControllerExamples
//
//  Created by vernon on 15/7/30.
//  Copyright (c) 2015年 coderbook. All rights reserved.
//

#import "CBTableViewCell.h"
#import "ProjectItemModel.h"

@implementation CBTableViewCell

- (void)awakeFromNib {
//    self getCBCellItemDataSource
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCBCellItemDataSource:(id)itemData{
    if ([itemData isKindOfClass:[ProjectItemModel class]]) {
        ProjectItemModel *model=itemData;
        [self.availableLabel setText:model.avalableAmount];
        [self.loanPurposeLabel setText:model.loanPurpose];
    }
}

@end
