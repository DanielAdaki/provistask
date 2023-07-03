import React from "react";

import { Link } from "react-router-dom";

import SimpleHeader from "../basic/SimpleHeader";
import Footer from "../basic/Footer";

import Background from "../../images/access-bg.jpg";
import Help from "../../images/help.png";
import Logo from "../../images/logo.png";

const AccessScreen = () => {
  return (
    <div id="access">
      <SimpleHeader />

      <div className="background">
        <img src={Background} alt="Background" />
      </div>

      <div className="container">
        <div className="main">
          <img src={Logo} alt="Logo" />
          <button>
            <Link to="/login">Log in as a provider</Link>
          </button>
          <button>
            <Link to="/login">Log in as a client</Link>
          </button>
          <p>
            By signing up, you agree to our
            <Link to="#"> Terms of Use and Privacy Policy.</Link>
          </p>
        </div>
        <button className="help-btn">
          <img src={Help} className="help" alt="Help" />
          <span>Help!</span>
        </button>
      </div>

      <Footer className="up" />
    </div>
  );
};

export default AccessScreen;
