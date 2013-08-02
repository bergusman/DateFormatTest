//
//  VBViewController.m
//  DateFormatTest
//
//  Created by Vitaly Berg on 02.08.13.
//  Copyright (c) 2013 Vitaly Berg. All rights reserved.
//

#import "VBViewController.h"

#import "VBDateFormatter.h"

@interface VBViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (strong, nonatomic) VBDateFormatter *dateFormatter;

@end

@implementation VBViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dateFormatter = [[VBDateFormatter alloc] init];
}

#pragma mark - Actions

- (IBAction)datePickerChanged:(UIDatePicker *)sender {
    self.dateLabel.text = [self.dateFormatter stringFromDate:sender.date];
}

@end
