//
//  MoviesController.swift
//  Project1-FlickM
//
//  Created by Monte's Pro 13" on 1/16/16.
//  Copyright © 2016 MonteThakkar. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

class MoviesController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var MoviesTableView: UITableView!
    
    var movies: [NSDictionary]?
    var endPoint : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        MoviesTableView.dataSource = self
        MoviesTableView.delegate = self
        
        
        // Initialize a UIRefreshControl
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
        MoviesTableView.insertSubview(refreshControl, atIndex: 0)
        
        // Display HUD right before next request is made
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        //Call the endpoint to get all the movies
        makeAPICall()
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
                           
                            self.movies = responseDictionary["results"] as? [NSDictionary]
                            self.MoviesTableView.reloadData()
                    }
                }
                
                // Hide HUD once network request comes back (must be done on main UI thread)
                MBProgressHUD.hideHUDForView(self.view, animated: true)
        });
        task.resume()
    }
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        
        // Make API call to fetch all the movies data
        makeAPICall()
        
        // Do the following when the network request comes back successfully:
        // Update tableView data source
        self.MoviesTableView.reloadData()
        refreshControl.endRefreshing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) as! MovieCell
        
        let movie = movies![indexPath.row]
        
        cell.titleLabel.text = movie["title"] as? String
        cell.overviewLabel.text = movie["overview"] as? String

        let baseImageURL = "http://image.tmdb.org/t/p/w500/"
        let imagePath = movie["poster_path"] as! String
        let imageURL = NSURL(string: baseImageURL + imagePath)
        
        cell.posterImage.setImageWithURL(imageURL!)
        
        return cell
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using
        
        let cell = sender as! UITableViewCell
        let indexPath = MoviesTableView.indexPathForCell(cell)
        let movie = movies![indexPath!.row]
        
        let detailViewController = segue.destinationViewController as! MovieInfoViewController
        
        detailViewController.movie = movie
        
    }
    

}
