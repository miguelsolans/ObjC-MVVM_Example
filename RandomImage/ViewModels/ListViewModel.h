//
//  ListViewModel.h
//  RandomImage
//
//  Created by Miguel Solans on 05/11/2020.
//

#import <Foundation/Foundation.h>

#import "RequestService.h"

NS_ASSUME_NONNULL_BEGIN

@interface ListViewModel : NSObject

@property (nonatomic, strong) NSMutableArray *wordsArray;
@property (nonatomic, strong) RequestService *request;
@property (nonatomic, weak) NSString *selectedWord;

- (void) loadWords;

@end

NS_ASSUME_NONNULL_END
