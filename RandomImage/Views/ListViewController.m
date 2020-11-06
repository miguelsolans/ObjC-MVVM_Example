//
//  ListViewController.m
//  RandomImage
//
//  Created by Miguel Solans on 05/11/2020.
//

#import "ListViewController.h"

@interface ListViewController ()

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableview:) name:@"ReloadTableview" object:nil];
    
    // 1. Initialize View and Words Array
    self.listViewModel = [[ListViewModel alloc] init];
    self.listViewModel.wordsArray = [[NSMutableArray alloc] init];
    [self.listViewModel loadWords];
    
}

- (void)reloadTableview:(NSNotification *)notification {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.wordsTableView reloadData];
    });
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if([keyPath isEqualToString:@"wordsArray"]) {
        // [self updateView];
    }
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    
    NSString *word = [[self.listViewModel.wordsArray objectAtIndex:indexPath.row] objectForKey:@"word"];
    cell.textLabel.text = [[self.listViewModel.wordsArray objectAtIndex:indexPath.row] objectForKey:@"word"];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.listViewModel.wordsArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *selectedWord = [[self.listViewModel.wordsArray objectAtIndex:indexPath.row] objectForKey:@"word"];
    NSLog(@"Selected %@", selectedWord);
    
    self.listViewModel.selectedWord = selectedWord;
    [self performSegueWithIdentifier:@"wordToPicture" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"Preparing Segue");
    
    if([segue.identifier isEqualToString:@"wordToPicture"]) {
        ImageViewController *imageViewController = [segue destinationViewController];
        
        imageViewController.word = self.listViewModel.selectedWord;
        
        
    }
}


@end
