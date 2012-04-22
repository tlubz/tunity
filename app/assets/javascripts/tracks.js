var yt_api_url = 'http://www.youtube.com/apiplayer?enablejsapi=1&version=3';
var player;
var playerDivId = 'ytplayer'

function loadPlayer() {
    swfobject.embedSWF(yt_api_url, playerDivId, "425", "365", "8", null, null, { allowScriptAccess: "always" });
}

function onYouTubePlayerReady() {
    console.log('player ready: ' + playerDivId)
    player = $('#' + playerDivId)[0];
    if (tunity.pageVars.youtube_id) {
        player.cueVideoById(tunity.pageVars.youtube_id, tunity.pageVars.pos);
        player.playVideo();
        player.addEventListener("onStateChange", "onPlayerStateChange");
    }
}

function onPlayerStateChange(newState) {
    // if player ended play, then reload window
    if(newState == 0) {
        window.location = $('#reload')[0].href;
    }
}

$(loadPlayer);