//
//  ViewController.m
//  MC_QRCode
//
//  Created by xulu on 15/8/19.
//  Copyright (c) 2015年 _MC. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "MC_ReactView.h"
@interface ViewController ()<AVCaptureMetadataOutputObjectsDelegate>
{
    AVCaptureSession * session;//输入输出的中间桥梁
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //获取摄像设备
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError * error;
    //创建输入流
    AVCaptureDeviceInput * input = [[AVCaptureDeviceInput alloc]initWithDevice:device error:&error];
    NSLog(@"%@",error);
    //创建输出流
    AVCaptureMetadataOutput * output = [[AVCaptureMetadataOutput alloc]init];
    output.rectOfInterest = CGRectMake(0.3, 0.2, 0.4, 0.6);
    //设置代理 在主线程刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    //初始化链接对象
    session = [[AVCaptureSession alloc]init];
    //高质量采集率
    [session setSessionPreset:AVCaptureSessionPresetHigh];
    
    [session addInput:input];
    [session addOutput:output];
    
    //设置扫码支持的编码格式
    output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode128Code];
    
    AVCaptureVideoPreviewLayer * layer = [AVCaptureVideoPreviewLayer layerWithSession:session];
    layer.frame = self.view.bounds;
    layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer insertSublayer:layer atIndex:0];
    MC_ReactView * view = [[MC_ReactView alloc]initWithFrame:self.view.bounds];
    view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:view];
    [session startRunning];
}


-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
    for (UIView * view in self.view.subviews) {
        if ([view isKindOfClass:[MC_ReactView class]]) {
            [view removeFromSuperview];
            break;
        }
    }
    [session stopRunning];
    for (CALayer * layer in self.view.layer.sublayers) {
        if ([layer isKindOfClass:[AVCaptureVideoPreviewLayer class]]) {
            [layer removeFromSuperlayer];
            break;
        }
    }
    NSLog(@"%@",metadataObject.stringValue);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
