//
//  VBDateFormatter.h
//  DateFormatTest
//
//  Created by Vitaly Berg on 02.08.13.
//  Copyright (c) 2013 Vitaly Berg. All rights reserved.
//

#import <Foundation/Foundation.h>

// Only for Russia
@interface VBDateFormatter : NSDateFormatter

- (NSString *)stringFromDate:(NSDate *)date;

@end
