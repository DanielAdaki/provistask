import React from "react";
import { Link } from "react-router-dom";

import Logo from "../../images/logo-header.png";
import Hammer from "../../images/hammer.png";

const HomeHeader = () => {
  return (
    <div className="home-header-container">
      <header className="home-header">
        <Link to="/">
          <img src={Logo} alt="Logo" className="logo" />
        </Link>

        <div className="content">
          <ul>
            <li>
              <Link to="/">Home</Link>
            </li>
            <li>
              <a
                href="https://blog.provitask.com/"
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

          <Link to="/tasker" className="button jointo">
            Join as a Provider
            <img src={Hammer} alt="Hammer" />
          </Link>

          <Link to="/signup" className="button client-signup">
            Sign up as a Client
          </Link>

          <Link to="/access" className="button login">
            Login
          </Link>
        </div>
      </header>
    </div>
  );
};

export default HomeHeader;
