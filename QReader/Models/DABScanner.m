//
//  DABScanner.m
//  QReader
//
//  Created by Danilo Braband on 18.11.13.
//  Copyright (c) 2013 Danilo Braband. All rights reserved.
//

#import "DABScanner.h"
#import <AVFoundation/AVFoundation.h>

@interface DABScanner () <AVCaptureMetadataOutputObjectsDelegate>
@property (nonatomic, strong) id<DABScannerDelegate> delegate;
@property (nonatomic, weak) UIView *view;
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureDevice *device;
@property (nonatomic, strong) AVCaptureDeviceInput *input;
@property (nonatomic, strong) AVCaptureMetadataOutput *output;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
@end

@implementation DABScanner

+ (DABScanner *)scannerWithDelegate:(id<DABScannerDelegate>)delegate
                             onView:(UIView *)view
{
    DABScanner *scanner = [[DABScanner alloc] init];
    scanner.delegate = delegate;
    scanner.view = view;

    return scanner;
}

#pragma mark - Lazy Instantiation

- (AVCaptureDevice *)device
{
    if (!_device) {
        _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }

    return _device;
}

- (AVCaptureSession *)session
{
    if (!_session) {
        _session = [[AVCaptureSession alloc] init];
        [_session addInput:self.input];
        [_session addOutput:self.output];
        [self.output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    }

    return _session;
}

- (AVCaptureDeviceInput *)input
{
    if (!_input) {
        _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    }

    return _input;
}

- (AVCaptureMetadataOutput *)output
{
    if (!_output) {
        _output = [[AVCaptureMetadataOutput alloc] init];
        [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    }

    return _output;
}

- (AVCaptureVideoPreviewLayer *)previewLayer
{
    if (!_previewLayer) {
        _previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
        _previewLayer.frame = self.view.bounds;
        _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    }

    return _previewLayer;
}

#pragma mark - Public Methods

- (BOOL)isRunning
{
    return [self.session isRunning];
}

- (void)start
{
    if ([self isRunning]) {
        return;
    }

    [self.view.layer addSublayer:self.previewLayer];
    [self.session startRunning];
}

- (void)stop
{
    if (![self isRunning]) {
        return;
    }

    [self.previewLayer removeFromSuperlayer];
    [self.session stopRunning];
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput
didOutputMetadataObjects:(NSArray *)metadataObjects
       fromConnection:(AVCaptureConnection *)connection
{
    AVMetadataObject *metadata = [metadataObjects firstObject];

    if ([metadata.type isEqualToString:AVMetadataObjectTypeQRCode]) {
        NSString *qrCode = [(AVMetadataMachineReadableCodeObject *)metadata stringValue];

        [self.delegate captureScanner:self didOutputCode:qrCode];
    }

}

@end
