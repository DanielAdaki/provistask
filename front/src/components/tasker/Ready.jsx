import React from "react";

import AppStore from "../../images/app-store-badge.png";
import PlayStore from "../../images/google-play-badge.png";

const Ready = () => {
  return (
    <div className="ready-section">
      <h2>Ready to make money your way?</h2>

      <button>Get Started</button>

      <div className="stores">
        <img src={AppStore} alt="App Store" />
        <img src={PlayStore} alt="Play Store" />
      </div>
    </div>
  );
};

export default Ready;
