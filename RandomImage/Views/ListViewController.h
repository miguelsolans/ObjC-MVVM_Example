//
//  ListViewController.h
//  RandomImage
//
//  Created by Miguel Solans on 05/11/2020.
//  

#import <UIKit/UIKit.h>
#import "ListViewModel.h"
#import "ImageViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) ListViewModel *listViewModel;
@property (weak, nonatomic) IBOutlet UITableView *wordsTableView;

- (void)reloadTableview:(NSNotification *)notification;
@end

NS_ASSUME_NONNULL_END
