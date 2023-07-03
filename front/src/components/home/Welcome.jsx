import React from "react";

import Choose from "../../images/choose.jpg";
import ProgressiveImg from "../reusable/ProgressiveImg";

const Welcome = () => {
  return (
    <section className="welcome">
      <div className="container">
        <ProgressiveImg src={Choose} alt="Choose" width="55.0625rem" />
        <div className="text-content">
          <h1>Welcome to ProviTask</h1>
          <p>
            It is a pleasure for us that you are part of our ProviTask family,
            whether you are a client or a professional, our interactive platform
            is linked to the daily work of our homes lives and work centers, we
            are satisfied with being able to help our clients to have a longer
            life easy, without worrying about doing usual complicated tasks,
            often not having the necessary knowledge and equipment
          </p>
          <button>Read More</button>
        </div>
      </div>
    </section>
  );
};

export default Welcome;
