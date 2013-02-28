//
//  SessionInfoPreviewViewController.m
//  iShare
//
//  Created by Bryant on 2/28/13.
//  Copyright (c) 2013 NCS. All rights reserved.
//

#import "SessionInfoPreviewViewController.h"
#import "Constants.h"
#import "UILabel+VerticalAlign.h"

@interface SessionInfoPreviewViewController ()

@end

@implementation SessionInfoPreviewViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithSessionInfo:(NSDictionary *)sessionInfo
{
    self = [super init];
    if (self) {
        self.sessionDetails = sessionInfo;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.sessionNameLabel.text = [self.sessionDetails objectForKey:@"sessionname"];
    self.lectureLabel.text = [self.sessionDetails objectForKey:@"lecture"];
    self.locationLabel.text = [self.sessionDetails objectForKey:@"location"];
    self.sessionDescLabel.text = [self.sessionDetails objectForKey:@"sessiondesc"];
    [self.sessionDescLabel alignTop];
    
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc]init];
    [dateFormater setDateFormat:kDateFormat];
    
    NSDate *startTime = [dateFormater dateFromString:[self.sessionDetails objectForKey:@"starttime"]];
    if (startTime == nil) return;
    
    self.sessionTimeLabel.text = [dateFormater stringFromDate:startTime];
    
    NSDate *endTime = [dateFormater dateFromString:[self.sessionDetails objectForKey:@"endtime"]];
    if (endTime != nil)
    {
        NSDateFormatter *timeFormater = [[NSDateFormatter alloc]init];
        [timeFormater setDateFormat:@"HH:mm"];
        
        self.sessionTimeLabel.text = [NSString stringWithFormat:@"%@ - %@", [dateFormater stringFromDate:startTime], [timeFormater stringFromDate:endTime]];
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveCurrentSession:(id)sender {
    
    //TODO: save here
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (IBAction)rescan:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
        [notificationCenter postNotification:[NSNotification notificationWithName:@"SessionScanStart" object:nil]];
    }];
}
@end