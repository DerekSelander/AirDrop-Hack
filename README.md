# AirDrop-Hack

#### Works on iOS 11, need to still fix it up for 12

## The Story

Way back when, I stumbled across [@NeoNacho](https://twitter.com/NeoNacho)'s [Trolldrop repo](https://github.com/neonichu/trolldrop). This thing was awesome, and I think it has got to be my all time favorite repo. So I wanted an iOS equivalent. Here is an iOS Trolldrop version with a couple of improvements:

* Spams people with Airdrop opened to everyone. Great for firing it off at conferences! 
* Monitors the refusal/acceptance pingback, meaning you can keep on spamming your recipients


Cons:
 * People can see your Apple ID. Either log into a tmp Apple ID or modify the `sharingd` daemon (via jailbreak) to export a different Apple ID
