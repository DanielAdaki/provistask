import React from "react";

import { Link } from "react-router-dom";

import Logo from "../../images/logo-header-color.png";
import LogoWhite from "../../images/logo-header.png";
import HammerWhite from "../../images/hammer-white.png";

const SimpleHeader = ({ noBG, white, shadow }) => {
  return (
    <div className="simple-header-container">
      <header
        id="simple-header"
        className={`${noBG ? "transparent" : ""} ${white ? "white" : ""} ${
          shadow ? "shadow" : ""
        }`}
      >
        <Link to="/">
          <img src={white ? LogoWhite : Logo} className="logo" alt="Logo" />
        </Link>

        <nav>
          <ul>
            <li>
              <Link to="/">Home</Link>
            </li>
            <li>
              <a
                href="https://blog.provitask.com"
                target="_blank"
                rel="noopener noreferrer"
              >
                Blog
              </a>
            </li>
            <li>
              <Link to="/services">Services</Link>
            </li>
          </ul>

          <div className="buttons">
            <Link to="/tasker" className="button jointo">
              Join as a Provider
              <img src={HammerWhite} alt="Hammer" />
            </Link>
            <Link to="/signup" className="button client-signup">
              Sign up as a Client
            </Link>
            <Link to="/access" className="button login">
              Login
            </Link>
          </div>
        </nav>
      </header>
    </div>
  );
};

export default SimpleHeader;
