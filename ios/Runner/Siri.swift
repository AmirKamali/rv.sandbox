import UIKit
import Flutter
import IntentsUI
import CoreSpotlight
import MobileCoreServices
import Foundation

public let SiriShortcutActivityType = "rv.interview.sandbox.siri.shortcut"

func AddSiriShortcut(controller: FlutterViewController) {
    return

    // TODO: Setup as much of the siri add short cut as you can
    //         Feel free to copy and paste from an article or walkthrough,
    //         just be prepared to go the setup if you do.
//     let activity = siriShortcut()
//     if #available(iOS 12.0, *) {
//         let shortcut = INShortcut(userActivity: activity)
//         let vc = INUIAddVoiceShortcutViewController(shortcut: shortcut)
//         vc.delegate = controller
//         controller.present(vc, animated: true, completion: nil)
//     }
}

func siriShortcut() -> NSUserActivity {
    let activity = NSUserActivity(activityType: SiriShortcutActivityType)
    if #available(iOS 12.0, *) {
        activity.persistentIdentifier = NSUserActivityPersistentIdentifier(SiriShortcutActivityType)
        activity.isEligibleForSearch = true
        activity.isEligibleForPrediction = true
        activity.suggestedInvocationPhrase = "Nacho Libre"
    }

    activity.title = "Ramseys is not dancing because he does not like to dance."
    let attributes = CSSearchableItemAttributeSet(itemContentType: kUTTypeItem as String)
    attributes.contentDescription = "Eagle Powers"
    activity.contentAttributeSet = attributes

    return activity
}
