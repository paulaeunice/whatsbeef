//
//  ViewController.m
//  PRJ_Exam
//
//  Created by iOS applicant on 20/08/2015.
//  Copyright (c) 2015 iOS applicant. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize showTeaser;
@synthesize showName;
@synthesize showTime;
@synthesize showSummary;
@synthesize showTease;

- (void)viewDidLoad {
    [super viewDidLoad];
    showTeaser.backgroundColor = [UIColor blueColor];
    UIImage * img = [UIImage imageNamed:showTease];
    [showTeaser setImage:img];
    showName.text = self.name;
    showTime.text = self.time;
    showSummary.text = [[NSString stringWithString:@"SUMMARY\n\n"] stringByAppendingString:self.summary];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
