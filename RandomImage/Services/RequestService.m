//
//  RequestService.m
//  RandomImage
//
//  Created by Miguel Solans on 05/11/2020.
//

#import "RequestService.h"

@implementation RequestService


- (instancetype)initWithDelegate:(id)delegate {
    self = [super init];
    self.result = nil;
    return self;
}

- (void) requestWithMethod:(RequestMethod)method
                      path:(NSURL *)path
                parameters:(NSData *)parameters
                   success:(void (^)(id output))sucess
                     error:(void (^)(NSError *error))serviceError {
    
    // 1. Initialize the request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:path];
    
    // TODO: find the purpose of this
    __weak typeof(self) weakSelf = self;
    
    
    // 2. Set request type
    switch (method) {
        case GET:
            [request setHTTPMethod:@"GET"];
            break;
        case POST:
            [request setHTTPMethod:@"POST"];
            // TODO: set JSON content prior to body
            [request setHTTPBody:parameters];
            break;
        case PUT:
            [request setHTTPMethod:@"PUT"];
            [request setHTTPBody:parameters];
            break;
        case PATCH:
            [request setHTTPMethod:@"PATCH"];
            [request setHTTPBody:parameters];
            break;
        case DELETE:
            [request setHTTPMethod:@"DELETE"];
            break;
    }
    
    // 3. Init URLSession for the API Call
    // sharedSessions works for simple requests
    NSURLSession *urlSession = [NSURLSession sharedSession];
    
    NSURLSessionTask *sessionTask = [urlSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable urlResponse, NSError * _Nullable error) {
        
        // 4. Parse response so we can access statusCode (?)
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)urlResponse;
        // TODO: Verify status for each type of request
        // GET or POST was ok
        if([response statusCode] == 200 || [response statusCode] == 201) {
            
            // 5. Find response content type
            NSString *contentType = [response.allHeaderFields valueForKey:@"Content-Type"];
            NSError *error = nil;
            
            // TODO: What if it's not jpeg? Find a wildcard for this. Regex (?)
            if([contentType isEqualToString:@"image/jpeg"]) {
                
                NSURL *url = [response URL];
                self.result = url;
                
                sucess(url);
            } else {
                // (hopefully) content might be JSON
                NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                
                weakSelf.result = responseDic;
                
                sucess(responseDic);
            }
            
        } else {
            // Error ocurred, parse response
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            // TODO: isn't this the same as self.result (???)
            weakSelf.result = responseDict;
            // TODO: why success and not error callback since we are dealing with an error (???)
            sucess(responseDict);
        }
        
        // Notify subscribers of a result
        [self setValue:weakSelf forKey:@"result"];
    }];
    
    [sessionTask resume];
}

@end
