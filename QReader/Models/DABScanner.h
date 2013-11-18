//
//  DABScanner.h
//  QReader
//
//  Created by Danilo Braband on 18.11.13.
//  Copyright (c) 2013 Danilo Braband. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DABScanner;

@protocol DABScannerDelegate <NSObject>
- (void)captureScanner:(DABScanner *)scanner didOutputCode:(NSString *)code;
@end

@interface DABScanner : NSObject
@property (nonatomic, readonly, getter = isRunning) BOOL running;

+ (DABScanner *)scannerWithDelegate:(id<DABScannerDelegate>)delegate
                             onView:(UIView *)view;
- (BOOL)isRunning;
- (void)start;
- (void)stop;
@end
