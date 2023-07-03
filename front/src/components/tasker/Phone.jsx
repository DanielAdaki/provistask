import React from "react";

import Arrow from "../../images/phone-arrow.png";
import AppStore from "../../images/app-store-badge.png";
import PlayStore from "../../images/google-play-badge.png";

const Phone = () => {
  return (
    <div className="phone">
      <div className="text">
        <p>For better services download the app</p>
        <strong>NOW</strong>
        <img src={Arrow} alt="Arrow" />
      </div>

      <div className="stores">
        <button className="img-container">
          <img src={PlayStore} alt="Play Store" />
        </button>
        <button className="img-container">
          <img src={AppStore} alt="App Store" />
        </button>
      </div>
    </div>
  );
};

export default Phone;
