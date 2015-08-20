//
//  TableViewCell.h
//  PRJ_Exam
//
//  Created by iOS applicant on 20/08/2015.
//  Copyright (c) 2015 iOS applicant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *detailedLabel;
@property (weak, nonatomic) IBOutlet UIImageView *indicator;

@end
