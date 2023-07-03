import React from "react";
import { Link } from "react-router-dom";

import BG from "../../images/services-hero-bg.jpg";
import Hammer from "../../images/services-hero-hammer.png";

const ServicesHero = () => {
  return (
    <div className="services-hero">
      <img src={BG} alt="Background" />

      <div className="content">
        <img src={Hammer} alt="Background" />

        <div className="text">
          <h1>Leave your to-do list with us.</h1>
          <div className="buttons">
            <Link to={"/access"}>Login</Link>
          </div>
        </div>
      </div>
    </div>
  );
};

export default ServicesHero;
