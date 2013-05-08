//
//  MainViewController.m
//  PhotoGalleryAV
//
//  Created by Thuy Copeland on 5/7/13.
//  Copyright (c) 2013 Thuy Copeland. All rights reserved.
//

#import "MainViewController.h"
// import the MediaPlayer framework
#import <MediaPlayer/MediaPlayer.h>

@interface MainViewController ()
// we need to declare this property as strong so it's not accidentally unloaded by ARC.
@property (strong, nonatomic) MPMoviePlayerController *player;
@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // url to video feed
    NSURL *url = [NSURL URLWithString:@"http://ia600506.us.archive.org/3/items/folk.guitar/guitar1_512kb.mp4"];
    // init the player
    self.player = [[MPMoviePlayerController alloc] init];
    // we want a streaming source
    self.player.movieSourceType = MPMovieSourceTypeStreaming;
    // pass the formatted url as the contentURL
    self.player.contentURL = url;
    // be kind. say NO to autoplay :)
    self.player.shouldAutoplay = NO;
    // create the movie player's size and position based on the containerView
    self.player.view.frame = self.containerView.frame;
    // add the player to the view controller's view
    [self.view addSubview:self.player.view];
    [self.player prepareToPlay];
    // have some fun. Uncomment this line :)
    // self.player.view.transform = CGAffineTransformMakeScale(1, -1);
}



- (IBAction)selectPhoto:(id)sender{
    // let's use the built in class to select images
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    // if you delve into the class, you can see the options for the sourceType.
    controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    // the sourceType for the camera is very similar to the photo library.
    // UIImagePickerControllerCameraCaptureMode
    
    // set up the delegate
    controller.delegate = self;
    
    /* 
       Let's present the image picker controller we just made.
       This line will bring up the Camera Photos.
     */
    [self presentViewController:controller animated:YES completion:^{
        // do nothing
    }];
}

// dig into the UIImagePickerControlDelegate protocol and you'll find...
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    // since this method makes a dictionary, and all we want is an image path,
    // this isn't as useful as we want. So let's dig into the info this dictionary is storing.
    NSLog(@"%@", info);
    // found it! UIImagePickerControllerOriginalImage! let's get the info for that value.
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    /* assign the image to the imageView. 
     Uh oh. Why does the album not dismiss itself now?
     Because we overrode the default delegate. */
    self.imageView.image = image;
    // let's make the new photo do something interesting.
    [self flip];
    
    // so now we have to dismiss it by hand
    [self dismissViewControllerAnimated:YES completion:^{
        // do something when it's finished dismissing
    }];
}

- (void) flip{
    [UIView animateWithDuration:2.0f animations:^{
        self.imageView.transform = CGAffineTransformMakeScale(-1, 1);
        
    }completion:^(BOOL finished) {
       // [self flipBack];
    }];
}
- (void) flipBack{
    [UIView animateWithDuration:2.0f animations:^{
        self.imageView.transform = CGAffineTransformMakeScale(1, 1);
    }completion:^(BOOL finished) {
        [self flip];
    }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
