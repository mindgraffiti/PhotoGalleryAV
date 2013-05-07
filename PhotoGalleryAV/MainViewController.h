//
//  MainViewController.h
//  PhotoGalleryAV
//
//  Created by Thuy Copeland on 5/7/13.
//  Copyright (c) 2013 Thuy Copeland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController <UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)selectPhoto:(id)sender;
@end
