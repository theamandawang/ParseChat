//
//  LoginViewController.m
//  ParseChat
//
//  Created by Amanda Wang on 6/27/22.
//

#import "LoginViewController.h"
#import "Parse/Parse.h"
@interface LoginViewController ()
@property (strong, nonatomic) IBOutlet UIView *fullView;
@property (weak, nonatomic) IBOutlet UITextField *userTextField;
@property (weak, nonatomic) IBOutlet UITextField *passTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void) checkFields {
    if([self.userTextField.text isEqual:@""] || [self.passTextField.text isEqual:@""]){
        UIAlertController *alert =
            [UIAlertController
                        alertControllerWithTitle:@"Empty username or password"
                        message:@"Username and password fields cannot be empty."
                        preferredStyle:(UIAlertControllerStyleAlert)
            ];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Ok"
                                                            style:UIAlertActionStyleCancel
                                                          handler:^(UIAlertAction * _Nonnull action) {
                                                                 // handle cancel response here. Doing nothing will dismiss the view.
                                                          }];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:^{
            // optional code for what happens after the alert controller has finished presenting
        }];
    }
}
- (IBAction)didSignUp:(id)sender {
    [self checkFields];
    PFUser *newUser = [PFUser user];
        
        // set user properties
        newUser.username = self.userTextField.text;
        newUser.password = self.passTextField.text;
        
        // call sign up function on the object
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
            if (error != nil) {
                NSLog(@"Error: %@", error.localizedDescription);
            } else {
                NSLog(@"User registered successfully");
                [self performSegueWithIdentifier:@"authenticatedSegue" sender:nil];
                // manually segue to logged in view
            }
    }];
}
- (IBAction)didLogin:(id)sender {
    [self checkFields];
    NSString *username = self.userTextField.text;
    NSString *password = self.passTextField.text;
       
       [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
           if (error != nil) {
               NSLog(@"User log in failed: %@", error.localizedDescription);
           } else {
               NSLog(@"User logged in successfully");
               
               // display view controller that needs to shown after successful login
               [self performSegueWithIdentifier:@"authenticatedSegue" sender:nil];
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
- (IBAction)viewDidTap:(id)sender {
    [self.view endEditing:YES];
}
@end
