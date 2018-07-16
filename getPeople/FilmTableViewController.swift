import UIKit
class FilmTableViewController: UITableViewController {
    // Hardcoded data for now
    var people: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData(from: "http://swapi.co/api/films/")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //    override func numberOfSections(in tableView: UITableView) -> Int {
    //        // if we return - sections we won't have any sections to put our rows in
    //        return 1
    //    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the count of people in our data array
        return people.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create a generic cell
        let cell = UITableViewCell()
        // set the default cell label to the corresponding element in the people array
        cell.textLabel?.text = people[indexPath.row]
        // return the cell so that it can be rendered
        return cell
    }
    
    func getData(from url: String) {
        StarWarsModel.getAllPeople(urlStarWars: url){
            data, response, error in
            do {
                // Try converting the JSON object to "Foundation Types" (NSDictionary, NSArray, NSString, etc.)
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    if let results = jsonResult["results"] as? NSArray {
                        for person in results {
                            let personDict = person as! NSDictionary
                            self.people.append(personDict["title"]! as! String)
                        }
                    }
                    if let nextURL = jsonResult["next"] as? String{
                        self.getData(from: nextURL)
                        
                    }
                }
                DispatchQueue.main.async{
                    self.tableView.reloadData()
                    
                }
                
                
            }
            catch {
                print("Something went wrong")
            }
        }
        
        
    }
}
