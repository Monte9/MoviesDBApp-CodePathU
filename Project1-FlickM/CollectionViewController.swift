//
//  CollectionViewController.swift
//  Project1-FlickM
//
//  Created by Monte's Pro 13" on 1/19/16.
//  Copyright © 2016 MonteThakkar. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD
import Foundation
import SystemConfiguration
import ReachabilitySwift

extension CollectionViewController: UICollectionViewDataSource, UISearchBarDelegate {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchedMovies?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MoviesCollectionViewCell", forIndexPath: indexPath) as! MoviesCollectionViewCell
        
        let movie = searchedMovies![indexPath.row]
        
        let baseImageURL = "http://image.tmdb.org/t/p/w500/"
        
        if let imageBGPath = movie["backdrop_path"] as? String {
           let imageBGURL = NSURL(string: baseImageURL + imageBGPath)
            cell.backgroundImageView.setImageWithURL(imageBGURL!)
        } else {
            cell.backgroundImageView.image = UIImage(named: "black")
        }
        
        if let imagePosterPath = movie["poster_path"] as? String {
            let imagePosterURL = NSURL(string: baseImageURL + imagePosterPath)
            cell.posterImageView.setImageWithURL(imagePosterURL!)
        } else {
            cell.posterImageView.image = UIImage(named: "black")
        }
        
        cell.movieTitleLabel.text = movie["title"] as? String
        cell.popularLabel.text = String(movie["popularity"] as! Int * 10) +  " %"
        cell.ratingLabel.text = String(movie["vote_average"] as! Int) + "/10"
        
        
        return cell
    }
}


class CollectionViewController: UIViewController, UIScrollViewDelegate{

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var networkView: UIView!
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var countButton: UIButton!
    
    var count = 0
    
    var genre = false
    
    var genreID: Int!
    var genreName: String!
    var movies: [NSDictionary]?
    var endPoint : String!
    var searchedMovies : [NSDictionary]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        
        
        searchBar.delegate = self
        searchBar.barTintColor = UIColor.blackColor()
 
    
        
        // Initialize a UIRefreshControl
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
        collectionView.insertSubview(refreshControl, atIndex: 0)
        
        //check for reachability- is there internet or not?
        let reachability = try! Reachability.reachabilityForInternetConnection()
        if reachability.currentReachabilityStatus == .NotReachable {
            collectionView.hidden = true
            searchBar.hidden = true
            networkView.hidden = false
            
            countButton.layer.cornerRadius = 50
        } else {
            networkView.hidden = true
            countButton.hidden = true
            countLabel.hidden = true
            // Display HUD right before next request is made
            MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            
            
            if (genre != true) {
            //Call the endpoint to get all the movies
            makeAPICall()
            }
            else {
                
                print(genreName)
                makeGenreAPICall()
            
            }
        }
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        self.searchedMovies = self.movies
        self.collectionView.reloadData()
    }
    
    
    @IBAction func countButtonPressed(sender: AnyObject) {
        if (count == 18) {
            countLabel.text = String("M")
        }
        else {
            countLabel.text = "."
            ++count
            countLabel.text = String(count)
        }
    }
    
    func makeGenreAPICall() {
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string:"https://api.themoviedb.org/3/genre/\(genreID!)/movies?api_key=\(apiKey)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            if (responseDictionary["status_code"] == nil ) {
                                
                                self.movies = responseDictionary["results"] as? [NSDictionary]
                                self.searchedMovies = self.movies
                                self.collectionView.reloadData()
                                print("Connection to API successful!")
                                
                                //   print(self.searchedMovies)
                                
                            }
                            else {
                                print("error")
                                self.collectionView.hidden = true
                                self.searchBar.hidden = true
                                self.networkView.hidden = false
                                self.countButton.hidden = false
                                self.countLabel.hidden = false
                                self.countButton.layer.cornerRadius = 50
                            }
                            // Hide HUD once network request comes back (must be done on main UI thread)
                            MBProgressHUD.hideHUDForView(self.view, animated: true)
                    }
                }
        });
        task.resume()
    }
    
    
    func makeAPICall() {
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string:"https://api.themoviedb.org/3/movie/\(endPoint)?api_key=\(apiKey)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            if (responseDictionary["status_code"] == nil ) {
                                
                                self.movies = responseDictionary["results"] as? [NSDictionary]
                                self.searchedMovies = self.movies
                                self.collectionView.reloadData()
                                print("Connection to API successful!")
                                
                             //   print(self.searchedMovies)
                                
                            }
                            else {
                                print("error")
                                self.collectionView.hidden = true
                                self.searchBar.hidden = true
                                self.networkView.hidden = false
                                self.countButton.hidden = false
                                self.countLabel.hidden = false
                                self.countButton.layer.cornerRadius = 50
                            }
                            // Hide HUD once network request comes back (must be done on main UI thread)
                            MBProgressHUD.hideHUDForView(self.view, animated: true)
                    }
                }
        });
        task.resume()
    }
    
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        searchedMovies = searchText.isEmpty ? movies : movies!.filter({(movie: NSDictionary) -> Bool in
            return (movie["title"] as! String).rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil
        })
        collectionView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        
        // Make API call to fetch all the movies data
        makeAPICall()
        
        // Do the following when the network request comes back successfully:
        // Update collectionView data source
        self.collectionView.reloadData()
        refreshControl.endRefreshing()
    }
    

    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
        let cell = sender as! UICollectionViewCell
        let indexPath = collectionView.indexPathForCell(cell)
        let movie = searchedMovies![indexPath!.row]
        
        let detailViewController = segue.destinationViewController as! MovieInfoViewController
        
        detailViewController.movie = movie

    }
    

}
