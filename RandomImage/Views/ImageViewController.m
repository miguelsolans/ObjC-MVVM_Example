//
//  ImageViewController.m
//  RandomImage
//
//  Created by Miguel Solans on 06/11/2020.
//

#import "ImageViewController.h"

@interface ImageViewController ()

@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadImageView:) name:@"ReloadImageView" object:nil];
    [self setTitle:self.word];
    self.imageViewModel = [[ImageViewModel alloc] initWithWord:self.word];
    
    [self.imageViewModel loadImage];
    
}

- (void)reloadImageView:(NSNotification *)notification {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.imageView.image = [UIImage imageWithData: self.imageViewModel.imageData];
    });
}
@end
