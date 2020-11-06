//
//  ImageViewController.h
//  RandomImage
//
//  Created by Miguel Solans on 06/11/2020.
//

#import <UIKit/UIKit.h>
#import "ImageViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ImageViewController : UIViewController

@property (nonatomic, strong) NSString *word;
@property (nonatomic, strong) ImageViewModel *imageViewModel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (void)reloadImageView:(NSNotification *)notification;
@end

NS_ASSUME_NONNULL_END
