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


}

- (void)stopScanner
{
    if (![self.scanner isRunning]) {
        return;
    }


}

- (IBAction)toggleStartCancel:(UIButton *)sender
{
    sender.selected = !sender.selected;
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
