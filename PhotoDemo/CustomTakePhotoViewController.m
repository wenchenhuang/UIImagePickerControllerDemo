//
//  CustomTakePhotoViewController.m
//  PhotoDemo
//
//  Created by huangwenchen on 15/3/31.
//  Copyright (c) 2015年 huangwenchen. All rights reserved.
//

#import "CustomTakePhotoViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface CustomTakePhotoViewController()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>


@property (strong, nonatomic) IBOutlet UIView *overlayView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *takePhotoBarButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet UIButton *takePictureButton;
@property (strong,nonatomic)UIImagePickerController * imagePikerViewController;


@end
@implementation CustomTakePhotoViewController
-(void)viewDidLoad{
    self.imagePikerViewController = [[UIImagePickerController alloc] init];
    self.imagePikerViewController.delegate = self;
    self.imagePikerViewController.allowsEditing = YES;
    self.imageview.contentMode = UIViewContentModeScaleAspectFit;
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage * image = info[UIImagePickerControllerEditedImage];
    if (!image) {
        image = info[UIImagePickerControllerOriginalImage];
    }
    self.imageview.image = image;
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)showAlertWithMessage:(NSString *)message{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Warning"
                                                                    message:message
                                                             preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)takePhotoOrChose:(id)sender {
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil
                                                                              message: nil
                                                                       preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alertController addAction: [UIAlertAction actionWithTitle: @"Take Photo" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            
            self.imagePikerViewController.sourceType = UIImagePickerControllerSourceTypeCamera;
            self.imagePikerViewController.showsCameraControls = NO;
            [[NSBundle mainBundle] loadNibNamed:@"CustomOverLayview" owner:self options:nil];
            self.takePictureButton.layer.cornerRadius = 20;
            self.takePictureButton.clipsToBounds = YES;
            self.overlayView.frame = self.imagePikerViewController.cameraOverlayView.frame;
            self.overlayView.backgroundColor = [UIColor clearColor];
            self.imagePikerViewController.cameraOverlayView = self.overlayView;
            self.overlayView = nil;
            [self presentViewController:self.imagePikerViewController animated:YES completion:NULL];
        }else{
            [self showAlertWithMessage:@"Camera is not available in this device or simulator"];
        }
        // Handle Take Photo here
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"Cancel" style: UIAlertActionStyleCancel handler:nil]];
    [self presentViewController: alertController animated: YES completion: nil];
}

- (IBAction)cameraSelect:(UISegmentedControl *)sender{
    NSInteger index = sender.selectedSegmentIndex;
    
    if (index == 0) {
        [UIView transitionWithView:self.imagePikerViewController.view duration:1.0 options:UIViewAnimationOptionAllowAnimatedContent | UIViewAnimationOptionTransitionCurlDown animations:^{
            self.imagePikerViewController.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        } completion:NULL];
    }else{
        [UIView transitionWithView:self.imagePikerViewController.view duration:1.0 options:UIViewAnimationOptionAllowAnimatedContent | UIViewAnimationOptionTransitionCurlUp animations:^{
            [self.imagePikerViewController setCameraDevice:UIImagePickerControllerCameraDeviceRear];
        } completion:NULL];
    }
}

- (IBAction)takePicture:(id)sender {
    [self.imagePikerViewController takePicture];
}
- (IBAction)cancelTakePicture:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
