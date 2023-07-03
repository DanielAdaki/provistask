import React from "react";

import WhatDude from "../../images/what-dude.png";

const What = () => {
  return (
    <div className="what">
      <div className="text">
        <h2>What is ProviTask?</h2>
        <p>
          It is a pleasure for us that you are part of our ProviTask family,
          whether you are a client or a professional, our interactive platform
          is linked to the daily work of our home lives and work centers, we are
          satisfied with being able to help our clients to have a longer life
          easy, without worrying about doing usual complicated tasks, often not
          having the necessary knowledge and equipment
        </p>
      </div>
      <img src={WhatDude} alt="Dude" />
    </div>
  );
};

export default What;
