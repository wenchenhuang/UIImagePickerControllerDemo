//
//  ViewController.m
//  PhotoDemo
//
//  Created by huangwenchen on 15/3/31.
//  Copyright (c) 2015年 huangwenchen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *selectBarButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (strong,nonatomic)UIImagePickerController * imagePikerViewController;

@end

@implementation ViewController
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
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
-(void)showAlertWithMessage:(NSString *)message{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Warning"
                                                                    message:message
                                                             preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)showSelectBar:(id)sender {
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil
                                                                              message: nil
                                                                       preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alertController addAction: [UIAlertAction actionWithTitle: @"Take Photo" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            self.imagePikerViewController.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:self.imagePikerViewController animated:YES completion:NULL];
        }else{
            [self showAlertWithMessage:@"Camera is not available in this device or simulator"];
        }
        // Handle Take Photo here
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"Choose Existing Photo" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
            self.imagePikerViewController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:self.imagePikerViewController animated:YES completion:NULL];
        }
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"Cancel" style: UIAlertActionStyleCancel handler:nil]];
    [self presentViewController: alertController animated: YES completion: nil];
}

@end
