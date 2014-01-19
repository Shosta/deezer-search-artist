//--------------------------------------------------------
// Rémi Lavedrine Corp
//--------------------------------------------------------
// Project     : Deezer
// File        : SearchArtistViewController.h
// Created     : $ 19/01/2014 $
// Maintainer  : $ Rémi LAVEDRINE $
//
// Copyright Rémi Lavedrine 2004-2012, All Rights Reserved
//
// This software is the confidential and proprietary
// information of Rémi Lavedrine.
// You shall not disclose such Confidential Information
// and shall use it only in accordance with the terms
// of the license agreement you entered into with
// Rémi Lavedrine.
//--------------------------------------------------------
//
// @brief
// Allow the user to search for an artist and display the result in a TableView. Each result is an artist and the user can select one to display its album.
// The artistsTableView has two section. The first one contains the search IBOutlet and the second one contains the result from the artist search request.
//

#import <UIKit/UIKit.h>

//! @brief Allow the user to search for an artist and display the result in a TableView. Each result is an artist and the user can select one to display its album.
//! @class SearchArtistViewController
//! @ingroup Controllers
//! @author Rémi Lavedrine
@interface SearchArtistViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UIView *searchingArtistContainerView;
@property (weak, nonatomic) IBOutlet UITableView *artistsTableView;
@property (weak, nonatomic) IBOutlet UITextField *searchArtistTextField;
@property (weak, nonatomic) IBOutlet UIButton *searchArtistButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *searchArtistRequestActivityIndicator;


@end
