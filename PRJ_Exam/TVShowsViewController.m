//
//  TVShowsViewController.m
//  PRJ_Exam
//
//  Created by iOS applicant on 20/08/2015.
//  Copyright (c) 2015 iOS applicant. All rights reserved.
//

#import "TVShowsViewController.h"
#import "TVShow.h"
#import "ViewController.h"
#import "TableViewCell.h"

@interface TVShowsViewController ()

@end

NSMutableArray * tvswhows;
int showCount = 0;
NSArray * teasers;

@implementation TVShowsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    tvswhows = [[NSMutableArray alloc] init];
    teasers = @[@"teaser1.jpg", @"teaser2.jpg", @"teaser3.jpg", @"teaser4.jpg", @"teaser5.jpg"];
    //Navigation UI
    self.navigationController.navigationBar.backgroundColor = [UIColor blueColor];//[UIColor colorWithRed:31.0f green:154.0f blue:226.0f alpha:0.5f];
    self.navigationController.navigationBar.barTintColor = [UIColor blueColor];//[UIColor colorWithRed:31.0f green:154.0f blue:226.0f alpha:0.5f];
    self.navigationItem.title = @"My Movies";
    
    self.tableView.sectionHeaderHeight = 50;
    NSURL *url = [NSURL URLWithString:@"http://www.whatsbeef.net/wabz/guide.php?start=1"];
    NSError * error;
    if([url checkResourceIsReachableAndReturnError:&error])
        NSLog(@"Error : %@\n", error.localizedDescription);
    else
        NSLog(@"OK\n");
    NSURLConnection * urlConn = [NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:url] delegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return showCount;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(section == 0)
            return @"TONIGHT";
    else {
        NSDate * today = [NSDate date];
        NSDate * showDate = [today dateByAddingTimeInterval:(double)(3600*24*section)];
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        NSString * d = [df stringFromDate:showDate];//[NSDateFormatter dateFormatFromTemplate:@"mm/dd/yy" options:nil locale:[NSLocale currentLocale]];
        return [df stringFromDate:showDate];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"showCell" forIndexPath:indexPath];
    if(showCount > 0) {
        TVShow *show = (TVShow*)[tvswhows objectAtIndex:indexPath.row];
        cell.label.text = show.name;
        cell.detailedLabel.text =show.time;
        [cell.logo setImage:show.imgLogo];
        cell.indicator = show.imgRating;
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.tag = indexPath.row;
    }
    return cell;
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ViewController * detailedView = (ViewController*)[segue destinationViewController];
    TableViewCell * tbCell = (UITableViewCell*)sender;
    detailedView.title = tbCell.label.text;
    detailedView.name = tbCell.label.text;
    detailedView.time = tbCell.detailedLabel.text;
    detailedView.summary = ((TVShow*)[tvswhows objectAtIndex:tbCell.tag]).summary;
    detailedView.showTease = ((TVShow*)[tvswhows objectAtIndex:tbCell.tag]).imgTeaser;
    self.navigationItem.backBarButtonItem.title = @"";
}

#pragma mark - NSURLConnection Delegate Method
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    //parse data and add to tvshows
    
    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSError *err = nil;
    NSData *jsonData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData options: NSJSONReadingMutableContainers error: &err];
    NSArray * movies = [json objectForKey:@"results"];
    showCount = [movies count];
    NSEnumerator * enumerator = [movies objectEnumerator];
    int c = 0;
    while(c < showCount) {
        id tmp = [movies objectAtIndex:c++];
        TVShow * tShow = [[TVShow alloc] init];
        tShow.name = [tmp valueForKey:@"name"];
        tShow.time = [[[tmp valueForKey:@"start_time"] stringByAppendingString:@" - "] stringByAppendingString:[tmp valueForKey:@"end_time"]];
        tShow.summary = [tmp valueForKey:@"channel"];
        tShow.imgLogo = [UIImage imageNamed:[teasers objectAtIndex:c%5]];
//        tShow.imgRating = [UIImage imageNamed:@""];
        tShow.imgTeaser = [teasers objectAtIndex:c%5];
        
        [tvswhows addObject:tShow];
    }
    [self.tableView reloadData];
    
}


@end
