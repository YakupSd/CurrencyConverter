//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Yakup Suda on 16.01.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var TryLabel: UILabel!
    @IBOutlet weak var EurLabel: UILabel!
    @IBOutlet weak var UsdLabel: UILabel!
    @IBOutlet weak var JpyLabel: UILabel!
    @IBOutlet weak var GbpLabel: UILabel!
    @IBOutlet weak var ChfLabel: UILabel!
    @IBOutlet weak var CadLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func GetRatesClick(_ sender: Any) {
        
        // 1=) Reqruest & Session
        // 2=) Response & Data
        // 3=) Parsing & JSON Serialization
        
        //Step 1
        let url = URL(string: "https://api.apilayer.com/fixer/latest?apikey=nvFRaMRzqzJxBdL9Ug261zssGILvbthk")
        
        let session = URLSession.shared
        //Closure
        let task = session.dataTask(with: url!) { (data, response, error) in
            if error != nil
            {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                
                let okButton  = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true,completion: nil)
            }
            else
            {
                //Step 2
                if data != nil {
                    do{
                    let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        
                        DispatchQueue.main.async {
                            if let rates = jsonResponse["rates"] as? [String : Any] {
                                //print(rates["TRY"])
                                if let cad = rates["CAD"] as? Double{
                                    self.CadLabel.text = "CAD: \(cad)"
                                }
                                if let chf = rates["CHF"] as? Double{
                                    self.ChfLabel.text = "CHF \(chf)"
                                }
                                if let gbp = rates["GBP"] as? Double{
                                    self.GbpLabel.text = "GBP: \(gbp)"
                                }
                                if let jpy = rates["JPY"] as? Double{
                                    self.JpyLabel.text = "JPY \(jpy)"
                                }
                                if let usd = rates["USD"] as? Double{
                                    self.UsdLabel.text = "USD: \(usd)"
                                }
                                if let eur  = rates["EUR"] as? Double{
                                    self.EurLabel.text = "EUR \(eur)"
                                }
                                if let ttry = rates["TRY"] as? Double{
                                    self.TryLabel.text = "TRY \(ttry)"
                                }
                                
                                
                            }
                                    
                        }
                    }
                    catch{
                        print("Error")
                    }
                }
            }
            
        }
        task.resume()
    }
    
}

