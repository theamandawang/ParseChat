//
//  ChatViewController.m
//  ParseChat
//
//  Created by Amanda Wang on 6/27/22.
//

#import "ChatViewController.h"
#import "Parse/Parse.h"
#import "ChatTableViewCell.h"
@interface ChatViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *messageTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *queryResults;
@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.queryResults = [[NSMutableArray alloc] init];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimer) userInfo:nil repeats:true];
    [self setQuery];
    [self.tableView reloadData];
    // Do any additional setup after loading the view.
}
-(void)setQuery {
    PFQuery *query = [PFQuery queryWithClassName:@"Message_FBU2022"];
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            for (NSDictionary *i in posts){
                NSLog(@"%@", i[@"text"]);
                [self.queryResults addObject:i[@"text"]];
            }
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)didSend:(id)sender {
    if([self.messageTextField isEqual:@""]){
        //do nothing
    }
    else{
        PFObject *chatMessage = [PFObject objectWithClassName:@"Message_FBU2022"];
        chatMessage[@"text"] = self.messageTextField.text;
        [chatMessage saveInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
                if (succeeded) {
                    NSLog(@"The message was saved!");
                } else {
                    NSLog(@"Problem saving message: %@", error.localizedDescription);
                }
            }];
        [self.messageTextField setText:@""];
    }
}
- (void)onTimer {
   // Add code to be run periodically
    NSLog(@"every second");
    [self setQuery];
    [self.tableView reloadData];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ChatTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"ChatCell"];
    cell.chatLabel.text = self.queryResults[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.queryResults.count;
}


@end
