//
//  ChatTableViewCell.h
//  ParseChat
//
//  Created by Amanda Wang on 6/27/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChatTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *chatLabel;
@property (weak, nonatomic) IBOutlet UILabel *userChatLabel;

@end

NS_ASSUME_NONNULL_END
