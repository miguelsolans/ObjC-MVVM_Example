//
//  RequestService.h
//  RandomImage
//
//  Created by Miguel Solans on 05/11/2020.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RequestService : NSObject

typedef NS_ENUM(NSInteger, RequestMethod) {
    GET,
    POST,
    PUT,
    PATCH,
    DELETE
};

@property (nonatomic, strong) NSObject *result;

- (instancetype) initWithDelegate:(id) delegate;

- (void) requestWithMethod:(RequestMethod)method
                      path:(NSURL *)path
                parameters:(NSData *)parameters
                   success:(void (^)(id output))sucess
                     error:(void (^)(NSError *error))serviceError;
@end

NS_ASSUME_NONNULL_END
