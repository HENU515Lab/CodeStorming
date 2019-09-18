class QualitySelector {
  constructor(player) {
    this.player = player;
    this.sources = [];
    this.callback = undefined;
    this.containerDropdownElement = undefined;
    this.defaults = {};
  }

  selected(quality) {
    Array.from(this.containerDropdownElement.firstChild.childNodes).forEach(ele => {
      if (ele.dataset.code === quality) {
        ele.setAttribute('class', 'current');
      } else {
        ele.removeAttribute('class');
      }
    });
  }

	/**
	 * event on selected the quality
	 */
  onQualitySelect(quality) {
    if (this.callback) {
      this.callback(quality);
    }

    if (this.sources) {
      // tries to find the source with this quality
      let source = this.sources.find(ss => ss.format === quality.code);

      if (source) {
        let currTime = this.player.currentTime();
        let currPlaybackRate = this.player.playbackRate();

        this.player.src({ src: source.src, type: source.type });

        this.player.on('loadedmetadata', () => {
          this.player.currentTime(currTime);
          this.player.playbackRate(currPlaybackRate);
          this.player.play();

          this.selected(quality.code);
        });
      }

      const player = document.getElementById(this.player.id_);
      const qualitySelector = player.getElementsByClassName('vjs-brand-quality-link');

      if (qualitySelector && qualitySelector.length > 0) {
        qualitySelector[0].innerText = quality.name;
      }
    }

    this.hide();
  }

  hide() {
    if (this.containerDropdownElement.className.indexOf('show') !== -1) {
      this.containerDropdownElement.className = this.containerDropdownElement.className.replace(' show', '');
    }
  }

  show() {
    if (this.containerDropdownElement.className.indexOf('show') === -1) {
      this.containerDropdownElement.className += ' show';
    }
  }

	/**
	 * Function to invoke when the player is ready.
	 *
	 * This is a great place for your plugin to initialize itself. When this
	 * function is called, the player will have its DOM and child components
	 * in place.
	 *
	 * @function onPlayerReady
	 * @param    {Player} player
	 * @param    {Object} [options={}]
	 */
  onPlayerReady(options) {
    this.containerDropdownElement = document.createElement('div');
    this.containerDropdownElement.className = 'vjs-quality-dropdown';
    this.containerDropdownElement.onmouseenter = () => this.show();
    this.containerDropdownElement.onmouseleave = () => this.hide();

    let containerElement = document.createElement('div');

    containerElement.className = 'vjs-quality-container';
    containerElement.onmouseenter = () => this.show();
    containerElement.onmouseleave = () => this.hide();

    let buttonElement = document.createElement('button');

    buttonElement.className = 'vjs-brand-quality-link';
    buttonElement.innerText = options.text || '清晰度';


    let ulElement = document.createElement('ul');
    ulElement.onmouseenter = () => this.show();
    ulElement.onmouseleave = () => this.hide();


    if (options.onFormatSelected) {
      this.callback = options.onFormatSelected;
    }

    if (options.sources) {
      this.sources = options.sources;
    }

    options.formats.map((format) => {
      let liElement = document.createElement('li');

      liElement.dataset.code = format.code;

      let linkElement = document.createElement('a');

      linkElement.innerText = format.name;
      linkElement.setAttribute('href', '#');
      linkElement.addEventListener('click', (event) => {
        event.preventDefault();
        this.onQualitySelect(format);
      });

      liElement.appendChild(linkElement);
      ulElement.appendChild(liElement);
    });

    this.containerDropdownElement.appendChild(ulElement);
    containerElement.appendChild(this.containerDropdownElement);
    containerElement.appendChild(buttonElement);

    this.selected(options.text);


    const fullScreenToggle = this.player.controlBar.fullscreenToggle.el();

    this.player.controlBar.el().insertBefore(containerElement, fullScreenToggle);

    this.player.addClass('vjs-qualityselector');
  }
}

/**
 * A video.js plugin.
 *
 * In the plugin function, the value of `this` is a video.js `Player`
 * instance. You cannot rely on the player being in a 'ready' state here,
 * depending on how the plugin is invoked. This may or may not be important
 * to you; if not, remove the wait for 'ready'!
 *
 * @function qualityselector
 * @param    {Object} [options={}]
 *           An object of options left to the plugin author to define.
 */
const qualityselector = function(options) {
  this.ready(() => {
    let qualityControl = new QualitySelector(this);
    qualityControl.onPlayerReady(videojs.mergeOptions(qualityControl.defaults, options));
  });
};

videojs.registerPlugin('qualityselector', qualityselector);
