//
//  RBTFriendListViewController.m
//  veli
//
//  Created by Romain Bousquet on 26/03/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import "RBTFriendListViewController.h"
#import "RBTHomeAndStreamingViewController.h"
#import "RBTPlayerViewController.h"

#import "RBTNavigationBarTitleView.h"
#import "RBTFriendListHeaderView.h"
#import "RBTSearchBar.h"
#import "RBTFriendListCell.h"

#import "UIBarButtonItem+RBT.h"
#import "UINavigationController+RBT.h"
#import "RBTFriendCacheService.h"

#import "RBTFriend.h"

static CGFloat const kHeightNavigationBar = 64.f;

@interface RBTFriendListViewController () <UITableViewDelegate, UITableViewDataSource> {
	UIEdgeInsets preAnimationInsets;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *keyboardHeight;
@property (strong, nonatomic) RBTFriendListHeaderView *headerView;
@property (strong, nonatomic) NSArray *friendList;
@property (strong, nonatomic) UITapGestureRecognizer *dismissKeyboardTap;

@end

@implementation RBTFriendListViewController

#pragma mark - Controller life cyle

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[self configureNavigationButtons];
	[self configureSubviews];
	[self populateTableView];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self.navigationController setNavigationBarHidden:NO animated:YES];
	[UIApplication sharedApplication].statusBarHidden = NO;
	[self.navigationController.view addGestureRecognizer:self.dismissKeyboardTap];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	[self.navigationController.view removeGestureRecognizer:self.dismissKeyboardTap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Setup

- (void)configureNavigationButtons
{
	self.navigationController.navigationBar.translucent = YES;
	self.navigationItem.rightBarButtonItem = [UIBarButtonItem RBTBarButtonItemWithPictureName:@"icon-arrow-right" target:self action:@selector(didHitNavigationRightButton:)];
	self.navigationItem.titleView = [RBTNavigationBarTitleView titleViewWithTitle:NSLocalizedString(@"Explore", nil)];
}

- (void)configureSubviews
{
	self.tableView.backgroundColor = [UIColor whiteColor];
	self.headerView = [[RBTFriendListHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), [RBTFriendListHeaderView height])];
	self.tableView.tableHeaderView = self.headerView;
	self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
	self.tableView.delegate = self;
	self.tableView.dataSource = self;
	self.tableView.sectionFooterHeight = 0.f;
	self.tableView.sectionHeaderHeight = 0.f;
	self.tableView.rowHeight = 60.f;
	preAnimationInsets = self.tableView.scrollIndicatorInsets;
	preAnimationInsets.top = kHeightNavigationBar;
	
	[self.tableView registerNib:[RBTFriendListCell nib] forCellReuseIdentifier:[RBTFriendListCell reuseIdentifier]];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
	self.dismissKeyboardTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
	self.dismissKeyboardTap.cancelsTouchesInView = NO;
}

- (void)populateTableView
{
	@weakify(self)
	[[[RBTFriendCacheService sharedInstance] retrieveFriends] subscribeNext:^(NSArray *friendArray) {
		@strongify(self)
		self.friendList = friendArray;
		[self.tableView reloadData];
	}];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.friendList.count;
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	RBTFriendListCell *cell = (RBTFriendListCell *)[tableView dequeueReusableCellWithIdentifier:[RBTFriendListCell reuseIdentifier] forIndexPath:indexPath];
	cell.confirmButton.tag = indexPath.row;
	cell.cancelButton.tag  = indexPath.row;
	[cell.confirmButton addTarget:self action:@selector(didHitConfirm:) forControlEvents:UIControlEventTouchUpInside];
	[cell.cancelButton addTarget:self action:@selector(didHitCancel:) forControlEvents:UIControlEventTouchUpInside];
	[cell configureCellWithFriend:self.friendList[indexPath.row] withType:RBTFriendListCellTypeFriendList];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	RBTPlayerViewController *playerViewController = [[RBTPlayerViewController alloc] init];
	playerViewController.streamingFriend = self.friendList[indexPath.row];
	[self.navigationController pushViewController:playerViewController animated:YES];
}

#pragma mark - Keyboard handling

- (void)keyboardWasShown:(NSNotification *)notification
{
	NSDictionary *info = [notification userInfo];
	NSValue *kbFrame = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
	CGRect keyboardFrame = [kbFrame CGRectValue];
	CGFloat height = keyboardFrame.size.height;
	
	UIEdgeInsets contentInsets = UIEdgeInsetsMake(kHeightNavigationBar, 0.0, height, 0.0);
	self.tableView.contentInset = contentInsets;
	self.tableView.scrollIndicatorInsets = contentInsets;
}

- (void)keyboardWillBeHidden:(NSNotification *)notification
{
	self.tableView.contentInset = preAnimationInsets;
	self.tableView.scrollIndicatorInsets = preAnimationInsets;
}

- (void)dismissKeyboard
{
	[self.headerView.searchBar dismissKeyboard];
}

#pragma mark - User interactions

- (void)didHitConfirm:(UIButton *)sender
{
	
}

- (void)didHitCancel:(UIButton *)sender
{
	
}

- (void)didHitNavigationRightButton:(id)sender
{
	RBTHomeAndStreamingViewController *controller = [[RBTHomeAndStreamingViewController alloc] init];
	[self.navigationController pushViewController:controller animated:YES];
}

@end
