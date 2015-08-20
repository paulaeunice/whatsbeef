//
//  ViewController.h
//  PRJ_Exam
//
//  Created by iOS applicant on 20/08/2015.
//  Copyright (c) 2015 iOS applicant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *showName;
@property (weak, nonatomic) IBOutlet UILabel *showTime;
@property (weak, nonatomic) IBOutlet UIImageView *showTeaser;
@property (weak, nonatomic) IBOutlet UITextView *showSummary;


@property (weak, nonatomic)  NSString *name;
@property (weak, nonatomic)  NSString *time;
@property (weak, nonatomic)  NSString *summary;
@property (weak, nonatomic)  NSString *showTease;

@end

