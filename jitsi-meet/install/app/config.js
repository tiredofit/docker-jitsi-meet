var config = {

    hosts: {
        domain: 'jitsi-meet.example.com',
        muc: 'conference.jitsi-meet.example.com',
        bridge: 'jitsi-videobridge.jitsi-meet.example.com',
        anonymousdomain: 'guest.jitsi-meet.example.com',
        authdomain: 'jitsi-meet.example.com',
        focus: 'focus.jitsi-meet.example.com',
    },

    bosh: '//jitsi-meet.example.com/http-bind',
    clientNode: 'http://jitsi.org/jitsimeet',

    testing: {
        enableFirefoxSimulcast: false,
        p2pTestMode: false
    },

    resolution: 1080,
    disableSuspendVideo: true,
    desktopSharingChromeExtId: null,
    desktopSharingChromeDisabled: false,
    desktopSharingChromeSources: [ 'screen', 'window', 'tab' ],
    desktopSharingChromeMinExtVersion: '0.1',
    desktopSharingFirefoxExtId: null,
    desktopSharingFirefoxDisabled: false,
    desktopSharingFirefoxMaxVersionExtRequired: 51,
    desktopSharingFirefoxExtensionURL: null,
    channelLastN: -1,
    useIPv6: false,
    useNicks: false,
    requireDisplayName: true,
    enableWelcomePage: true,
    minHDHeight: 540,
    defaultLanguage: 'en',
    enableUserRolesBasedOnToken: false,
    //noticeMessage: ' ',

    disableThirdPartyRequests: true,

    p2p: {
        enabled: true,
        stunServers: [
            { urls: 'stun:stun.l.google.com:19302' },
            { urls: 'stun:stun1.l.google.com:19302' },
            { urls: 'stun:stun2.l.google.com:19302' }
        ],
        preferH264: true
    },

};

/* eslint-enable no-unused-vars, no-var */

