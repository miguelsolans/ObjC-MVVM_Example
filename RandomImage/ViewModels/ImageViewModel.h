//
//  ImageViewModel.h
//  RandomImage
//
//  Created by Miguel Solans on 06/11/2020.
//

#import <Foundation/Foundation.h>
#import "RequestService.h"

NS_ASSUME_NONNULL_BEGIN

@interface ImageViewModel : NSObject

@property (nonatomic, strong) RequestService *request;
@property (nonatomic, strong) NSString *word;
@property (nonatomic, strong) NSData *imageData;

- (instancetype)initWithWord: (NSString *) word;

- (void)loadImage;

@end

NS_ASSUME_NONNULL_END
