//
//  ListViewModel.m
//  RandomImage
//
//  Created by Miguel Solans on 05/11/2020.
//

#import "ListViewModel.h"

@implementation ListViewModel


- (void)loadWords {
    self.request = [[RequestService alloc] initWithDelegate:self];
    
    [self.request addObserver:self forKeyPath:@"result" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    NSURL *wordsApi = [NSURL URLWithString:@"https://api.datamuse.com/words?topics=music,nature,world,code"];
    
    [self.request requestWithMethod:GET path:wordsApi parameters:(NSData *) nil success:^(id  _Nonnull output) {
        
        self.wordsArray = output;
        NSLog(@"Data passed for ViewModel");
        
    } error:^(NSError * _Nonnull error) {
        NSLog(@"Error fetching words");
    }];
}

// This object is notified when API changes... Is observing RequestService
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"result"]) {
        NSLog(@"Observer Changed Values. Notifying ViewController");
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadTableview" object:nil];
    }
}

@end
