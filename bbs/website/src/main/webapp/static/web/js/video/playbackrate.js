class Playbackrate {
  constructor(player) {
    this.player = player;
    this.rates = [2, 1.5, 1.25, 1, 0.75, 0.5];
    this.callback = undefined;
    this.containerDropdownElement = undefined;
    this.defaults = {};
  }

  selected(rate) {
    Array.from(this.containerDropdownElement.firstChild.childNodes).forEach(ele => {
      if (ele.innerText === rate) {
        ele.setAttribute('class', 'current');
      } else {
        ele.removeAttribute('class');
      }
    });
  }


  onRateSelect(rate) {

    this.player.playbackRate(rate);

    this.selected(rate + 'x');

    const player = document.getElementById(this.player.id_);
    const rateSelector = player.getElementsByClassName('vjs-brand-rate-link');

    if (rateSelector && rateSelector.length > 0) {
      rateSelector[0].innerText = rate + 'x';
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


  onPlayerReady(options) {
    this.containerDropdownElement = document.createElement('div');
    this.containerDropdownElement.className = 'vjs-rate-dropdown';
    this.containerDropdownElement.onmouseenter = () => this.show();
    this.containerDropdownElement.onmouseleave = () => this.hide();

    let containerElement = document.createElement('div');
    containerElement.className = 'vjs-rate-container';
    containerElement.onmouseenter = () => this.show();
    containerElement.onmouseleave = () => this.hide();

    let buttonElement = document.createElement('button');
    buttonElement.className = 'vjs-brand-rate-link';
    buttonElement.innerText = options.text || '1x';


    let ulElement = document.createElement('ul');
    ulElement.onmouseenter = () => this.show();
    ulElement.onmouseleave = () => this.hide();

    this.rates.map((rate) => {
      let liElement = document.createElement('li');

      let linkElement = document.createElement('a');

      linkElement.innerText = rate + 'x';
      linkElement.setAttribute('href', '#');
      linkElement.addEventListener('click', (event) => {
        event.preventDefault();
        this.onRateSelect(rate);
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

    this.player.addClass('vjs-myplaybackrate');
  }

}


const playbackrate = function(options) {
  this.ready(() => {
    let playbackrateControl = new Playbackrate(this);
    playbackrateControl.onPlayerReady(videojs.mergeOptions(playbackrateControl.defaults, options));
  });
};

videojs.registerPlugin('playbackrate', playbackrate);
