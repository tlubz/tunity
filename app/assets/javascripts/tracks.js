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
        player.cueVideoById(tunity.pageVars.youtube_id);
        player.playVideo();
    }
}

$(loadPlayer);