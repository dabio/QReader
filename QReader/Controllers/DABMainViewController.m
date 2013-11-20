//
//  DABMainViewController.m
//  QReader
//
//  Created by Danilo Braband on 18.11.13.
//  Copyright (c) 2013 Danilo Braband. All rights reserved.
//

#import "DABMainViewController.h"
#import "DABScanner.h"

@interface DABMainViewController () <DABScannerDelegate>
@property (nonatomic, strong) DABScanner *scanner;
@property (weak, nonatomic) IBOutlet UIView *scannerView;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@end

@implementation DABMainViewController

#pragma mark - Lazy Instantiation

- (DABScanner *)scanner
{
    if (!_scanner) {
        _scanner = [DABScanner scannerWithDelegate:self onView:self.scannerView];
    }

    return _scanner;
}

#pragma mark - Actions

- (void)startScanner
{
    if ([self.scanner isRunning]) {
        return;
    }

    self.startButton.selected = YES;
}

- (void)stopScanner
{
    if (![self.scanner isRunning]) {
        return;
    }

    self.startButton.selected = NO;

}

- (IBAction)toggleStartCancel:(UIButton *)sender
{
    if ([self.scanner isRunning]) {
        [self stopScanner];
    } else {
        [self startScanner];
    }
}

#pragma mark - DABScannerDelegate

- (void)captureScanner:(DABScanner *)scanner didOutputCode:(NSString *)code
{
    if (scanner != self.scanner) {
        return;
    }

    NSLog(@"%@", code);
}


@end
