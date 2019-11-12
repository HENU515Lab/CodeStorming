class WebFullScreen {
  constructor(player, acwing_player_id) {
    this.player = player;
  }

  onWebFullScreen() {
    if (this.buttonElement.className === 'glyphicon glyphicon-resize-full') {
      this.buttonElement.className = 'glyphicon glyphicon-resize-small';

      const videoElement = document.getElementsByClassName("embed-responsive embed-responsive-16by9")[0];

      this.videoElementParent = videoElement.parentNode;
      this.videoElementNextSibling = videoElement.nextSibling;
      this.videoElementParent.removeChild(this.videoElementParent.children[0]);

      const playerNormal = document.getElementById(this.player.normal_div_id);
      this.normal = playerNormal.children[0];
      playerNormal.removeChild(this.normal);

      const playerWebFullScreen = document.getElementById(this.player.full_div_id);
      playerWebFullScreen.style.display = "block";
      playerWebFullScreen.appendChild(videoElement);

    } else {
      this.buttonElement.className = 'glyphicon glyphicon-resize-full';

      const videoElement = document.getElementsByClassName("embed-responsive embed-responsive-16by9")[0];
      const playerWebFullScreen = document.getElementById(this.player.full_div_id);
      playerWebFullScreen.style.display = "none";
      playerWebFullScreen.removeChild(playerWebFullScreen.children[0]);

      const playerNormal = document.getElementById(this.player.normal_div_id);
      playerNormal.appendChild(this.normal);

      this.videoElementParent.insertBefore(videoElement, this.videoElementNextSibling);
    }
  }

  onPlayerReady() {
    let containerElement = document.createElement('div');
    containerElement.className = 'vjs-webfullscreen-container';

    this.buttonElement = document.createElement('button');
    this.buttonElement.className = 'glyphicon glyphicon-resize-full';
    this.buttonElement.onclick = () => this.onWebFullScreen();

    containerElement.appendChild(this.buttonElement);

    const fullScreenToggle = this.player.controlBar.fullscreenToggle.el();

    this.player.controlBar.el().insertBefore(containerElement, fullScreenToggle);

    this.player.addClass('vjs-webfullscreen');
  }
}

const webfullscreen = function(options) {
  this.ready(() => {
    let webFullScreenControl = new WebFullScreen(this);
    webFullScreenControl.onPlayerReady(videojs.mergeOptions(webFullScreenControl.defaults, options));
  });
};

videojs.registerPlugin('webfullscreen', webfullscreen);
