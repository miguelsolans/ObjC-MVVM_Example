//
//  ImageViewModel.m
//  RandomImage
//
//  Created by Miguel Solans on 06/11/2020.
//

#import "ImageViewModel.h"

@implementation ImageViewModel

- (instancetype)initWithWord: (NSString *) word {
    self = [super init];
    if (self) {
        self.word = word;
    }
    return self;
}

- (void)loadImage {
    self.request = [[RequestService alloc] initWithDelegate:self];
    
    [self.request addObserver:self forKeyPath:@"result" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    NSURL *wordsApi = [NSURL URLWithString:[NSString stringWithFormat:@"https://source.unsplash.com/featured/?%@", self.word]];
    
    [self.request requestWithMethod:GET path:wordsApi parameters:(NSData *) nil success:^(id  _Nonnull output) {
        
        NSLog(@"Data passed for ImageViewModel");
        self.imageData = [NSData dataWithContentsOfURL:output];
        
        // self.imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: output]];
    } error:^(NSError * _Nonnull error) {
        NSLog(@"Error fetching image");
    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"result"]) {
        NSLog(@"Observer Changed Values. Notifying ViewController");
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadImageView" object:nil];
    }
}

@end
