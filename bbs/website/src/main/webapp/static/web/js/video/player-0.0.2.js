const options = {
  autoplay : false,
  controls : true,
  controlBar : {
    currentTimeDisplay : true,
    timeDivider : true,
    durationDisplay : true,
    remainingTimeDisplay : false,
    volumePanel : {
      inline : false,
      vertical : true
    }
  },
  preload : 'auto',
};


let GLOBAL_VIDEO_INIT = function (acwing_player_id, normal_div_id, full_div_id) {
    let acwing_player = videojs('#' + acwing_player_id, options);

    acwing_player.normal_div_id = normal_div_id;
    acwing_player.full_div_id = full_div_id;
    acwing_player.playbackrate({
        text: '1x'
    });

    if (normal_div_id) acwing_player.webfullscreen();

    acwing_player.watermark({
        image: VIDEO_CONTENT_WATERMARK_LOGO_URL,
        url: 'https://www.acwing.com/'
      });

  const keyDownEventHandler = function(event) {
    if (event.keyCode === 32) { // Space
      event.preventDefault();
      if (acwing_player.paused()) {
        acwing_player.play();
      } else if (acwing_player.played()) {
        acwing_player.pause();
      }
    } else if (event.keyCode === 37) {  // Left
      event.preventDefault();
      acwing_player.currentTime(acwing_player.currentTime() - 10);
    } else if (event.keyCode === 39) {  // Right
      event.preventDefault();
      acwing_player.currentTime(acwing_player.currentTime() + 10);
    } else if (event.keyCode === 38) { // Up
      event.preventDefault();
      acwing_player.volume(acwing_player.volume() + 0.1);
    } else if (event.keyCode === 40) { // Down
      event.preventDefault();
      acwing_player.volume(acwing_player.volume() - 0.1);
    }
  };

  const mouseDownEventHandler = function(event) {
    if (event.button === 2) { // Mouse right click
      event.preventDefault();
    }
  };

  const contextMenu = function(event) {
    event.preventDefault();
  };


  acwing_player.on('keydown', keyDownEventHandler);
  acwing_player.on('contextmenu', contextMenu);
  acwing_player.on('mousedown', mouseDownEventHandler);
};