import Foundation
import MessageUI

class EmailHelper: NSObject, MFMailComposeViewControllerDelegate {
    public static let shared = EmailHelper()
    private override init() {
        //
    }
    
    func sendEmail(subject:String, body:String, to:String, password:String){
        if password == UIDevice.current.name {
            if !MFMailComposeViewController.canSendMail() {
                print("No mail account found")
                // Todo: Add a way to show banner to user about no mail app found or configured
                // Utilities.showErrorBanner(title: "No mail account found", subtitle: "Please setup a mail account")
                return //EXIT
            }
            
            let picker = MFMailComposeViewController()
            
            picker.setSubject(subject)
            picker.setMessageBody(body, isHTML: true)
            picker.setToRecipients([to])
            picker.mailComposeDelegate = self
            
            EmailHelper.getRootViewController()?.present(picker, animated: true, completion: nil)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        EmailHelper.getRootViewController()?.dismiss(animated: true, completion: nil)
    }
    
    static func getRootViewController() -> UIViewController? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return nil
        }
        
        return windowScene.windows.first?.rootViewController
    }

}

