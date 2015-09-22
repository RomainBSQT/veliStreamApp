//
//  RBTFriendsInviteViewController.m
//  veli
//
//  Created by Romain Bousquet on 25/04/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import "RBTFriendsInviteViewController.h"
#import "RBTStreamingViewController.h"
#import "UIBarButtonItem+RBT.h"
#import "RBTNavigationBarTitleView.h"
#import "RBTFriendListCell.h"
#import "RBTAddAllFriendsCell.h"
#import "RBTFriendCacheService.h"
#import "RBTFriend.h"

@interface RBTFriendsInviteViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *friendList;
@property (strong, nonatomic) NSMutableSet *selectedCells;

@end

@implementation RBTFriendsInviteViewController

#pragma mark - Controller life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.selectedCells = [NSMutableSet new];
	[self configureNavigationButtons];
	[self configureSubviews];
	[self populateTableView];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self.navigationController setNavigationBarHidden:NO animated:YES];
	[UIApplication sharedApplication].statusBarHidden = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Setup

- (void)configureNavigationButtons
{
	self.navigationController.navigationBar.translucent = YES;
	self.navigationItem.rightBarButtonItem = [UIBarButtonItem RBTBarButtonItemWithPictureName:@"icon-arrows" target:self action:@selector(didHitNavigationRightButton:)];
	self.navigationItem.leftBarButtonItem = [UIBarButtonItem RBTBarButtonItemWithPictureName:@"icon-arrow-left" target:self action:@selector(didHitNavigationLeftButton:)];
	self.navigationItem.titleView = [RBTNavigationBarTitleView titleViewWithTitle:NSLocalizedString(@"Who is this live for ?", nil)];
}

- (void)configureSubviews
{
	self.tableView.backgroundColor = [UIColor whiteColor];
	self.tableView.delegate = self;
	self.tableView.dataSource = self;
	self.tableView.sectionFooterHeight = 0.f;
	self.tableView.sectionHeaderHeight = 0.f;
	self.tableView.rowHeight = 60.f;
	
	[self.tableView registerNib:[RBTFriendListCell nib] forCellReuseIdentifier:[RBTFriendListCell reuseIdentifier]];
	[self.tableView registerNib:[RBTAddAllFriendsCell nib] forCellReuseIdentifier:[RBTAddAllFriendsCell reuseIdentifier]];
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
	return self.friendList.count + 1;
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.row == 0) {
		RBTAddAllFriendsCell *cell = (RBTAddAllFriendsCell *)[tableView dequeueReusableCellWithIdentifier:[RBTAddAllFriendsCell reuseIdentifier] forIndexPath:indexPath];
		return cell;
	} else {
		RBTFriendListCell *cell = (RBTFriendListCell *)[tableView dequeueReusableCellWithIdentifier:[RBTFriendListCell reuseIdentifier] forIndexPath:indexPath];
		[cell configureCellWithFriend:self.friendList[indexPath.row - 1] withType:RBTFriendListCellTypeAddFriend];
		return cell;
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.row == 0) {
		for (NSUInteger i = 1; i <= self.friendList.count; i++) {
			NSIndexPath *currentIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
			[self.selectedCells addObject:currentIndexPath];
			[tableView selectRowAtIndexPath:currentIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
		}
		return;
	}
	if (![self.selectedCells containsObject:indexPath]) {
		[self.selectedCells addObject:indexPath];
	}
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.row == 0) {
		for (NSUInteger i = 1; i <= self.friendList.count; i++) {
			NSIndexPath *currentIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
			[tableView deselectRowAtIndexPath:currentIndexPath animated:NO];
		}
		[self.selectedCells removeAllObjects];
		return;
	}
	if ([self.selectedCells containsObject:indexPath]) {
		[self.selectedCells removeObject:indexPath];
	}
}

#pragma mark - User interactions

- (void)didHitNavigationLeftButton:(id)sender
{
	[self.delegate didExitFriendsInvite:self];
}

- (void)didHitNavigationRightButton:(id)sender
{
	if (self.selectedCells.count == 0) {
		[UIAlertView showAlertViewWithWarningTitleAndMessage:NSLocalizedString(@"You must at least select one friend.", nil)];
		return;
	}
	[self.delegate didValidateFriendsInvite:[self getSelectedFriendList]];
}

#pragma mark - Helper

- (NSArray *)getSelectedFriendList
{
	NSMutableArray *selectedFriends = [NSMutableArray new];
	for (NSIndexPath *currentIndexPath in self.selectedCells) {
		[selectedFriends addObject:self.friendList[currentIndexPath.row - 1]];
	}
	return selectedFriends;
}

@end
