//
//  VBDateFormatter.m
//  DateFormatTest
//
//  Created by Vitaly Berg on 02.08.13.
//  Copyright (c) 2013 Vitaly Berg. All rights reserved.
//

#import "VBDateFormatter.h"

@implementation VBDateFormatter

- (NSString *)stringFromDate:(NSDate *)date {
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *now = [NSDate date];
    NSDateComponents *components = [calendar components:unitFlags fromDate:date toDate:now options:0];
    NSDateComponents *dateComponents = [calendar components:unitFlags fromDate:date];
    NSDateComponents *nowComponents = [calendar components:unitFlags fromDate:now];
    
    NSLog(@"%@", components);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ru_RU"];
    
    NSTimeInterval timeInterval = [now timeIntervalSinceDate:date];
    
    if (timeInterval < 0) {
        return @"В будущем";
    }
    
    if (dateComponents.year == nowComponents.year) {
        if (dateComponents.month == nowComponents.month) {
            if (dateComponents.day == nowComponents.day) {
                if (dateComponents.hour == nowComponents.hour) {
                    if (components.minute == 0) {
                        return @"Только что";
                    } else {
                        if (components.minute == 1) {
                            return @"Минуту назад";
                        } else {
                            NSString *format = [self pluralStringWithCount:components.minute forms:@[@"%d минуту назад", @"%d минуты назад", @"%d минут назад"]];
                            return [NSString stringWithFormat:format, components.minute];
                        }
                        
                    }
                } else {
                    if (components.hour == 1) {
                        return @"Час назад";
                    } else {
                        NSString *format = [self pluralStringWithCount:components.hour forms:@[@"%d час назад", @"%d часа назад", @"%d часов назад"]];
                        return [NSString stringWithFormat:format, components.hour];
                    }
                    
                }
            } else if (dateComponents.day + 1 == nowComponents.day) {
                return @"Вчера";
            } else {
                dateFormatter.dateFormat = [NSDateFormatter dateFormatFromTemplate:@"MMMM d" options:0 locale:dateFormatter.locale];
                return [dateFormatter stringFromDate:date];
            }
        } else {
            dateFormatter.dateFormat = [NSDateFormatter dateFormatFromTemplate:@"MMMM d" options:0 locale:dateFormatter.locale];
            return [dateFormatter stringFromDate:date];
        }
    } else {
        dateFormatter.dateFormat = [NSDateFormatter dateFormatFromTemplate:@"yyyy MMMM d" options:0 locale:dateFormatter.locale];
        return [dateFormatter stringFromDate:date];
    }
    
    return nil;
}

- (NSString *)pluralStringWithCount:(NSInteger)count forms:(NSArray *)forms {
    if ([forms count] < 3) {
        return nil;
    }
    
    NSUInteger mod10 = count % 10;
    NSUInteger mod100 = count % 100;
    
    switch (mod10) {
        case 1:
            if (mod100 != 11) {
                return forms[0];
            }
            break;
        case 2:
        case 3:
        case 4:
            if (mod100 != 12 && mod100 != 13 && mod100 != 14) {
                return forms[1];
            }
            break;
        default:
            break;
    }
    
    return forms[2];
}

@end
