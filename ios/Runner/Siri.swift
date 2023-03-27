import UIKit
import Flutter
import IntentsUI
import CoreSpotlight
import MobileCoreServices
import Foundation

public let SiriShortcutActivityType = "rv.interview.sandbox.siri.shortcut"

func AddSiriShortcut(controller: FlutterViewController) {
    

    // TODO: Setup as much of the siri add short cut as you can
    //         Feel free to copy and paste from an article or walkthrough,
    //         just be prepared to go the setup if you do.
     let activity = siriShortcut()
     if #available(iOS 12.0, *) {
         let shortcut = INShortcut(userActivity: activity)
         let vc = INUIAddVoiceShortcutViewController(shortcut: shortcut)
         vc.delegate = siriController
         controller.present(vc, animated: true, completion: nil)
     }
}

@available(iOS 12.0, *)
let siriController = SiriController()

@available(iOS 12.0, *)
class SiriController:NSObject,INUIAddVoiceShortcutViewControllerDelegate {
    
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
        controller.dismiss(animated: true)

    }
    
    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        controller.dismiss(animated: true)

    }
    
    
}

func siriShortcut() -> NSUserActivity {
    let activity = NSUserActivity(activityType: SiriShortcutActivityType)
    if #available(iOS 12.0, *) {
        activity.persistentIdentifier = NSUserActivityPersistentIdentifier(SiriShortcutActivityType)
        activity.isEligibleForSearch = true
        activity.isEligibleForPrediction = true
        activity.suggestedInvocationPhrase = "Open http page"
        activity.userInfo?["page"] = "/record"
    }
    activity.title = "Ramseys is not dancing because he does not like to dance."
    let attributes = CSSearchableItemAttributeSet(itemContentType: kUTTypeItem as String)
    attributes.contentDescription = "My flutter app"
    activity.contentAttributeSet = attributes

    return activity
}
