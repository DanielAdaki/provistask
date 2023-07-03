import React from "react";
import { Link } from "react-router-dom";

import FooterBackground from "../../images/footer-bg.jpg";
import Logo from "../../images/logo-header.png";
import ChevronRight from "../../images/chevron-right.png";
import LogoLinkedin from "../../images/logo-linkedin.png";
import LogoInstagram from "../../images/logo-instagram.png";
import LogoFacebook from "../../images/logo-facebook.png";
import AppStore from "../../images/app-store-badge.png";
import PlayStore from "../../images/google-play-badge.png";

const Footer = ({ className }) => {
  return (
    <footer id="footer" className={className ? className : ""}>
      <div className="background">
        <img src={FooterBackground} alt="Background" />
      </div>
      <div className="content">
        <div className="container">
          <div className="first">
            <img src={Logo} alt="Logo" />
            <p>
              It is a pleasure for us that you are part of our ProviTask family,
              whether you are a client or a professional, our interactive
              platform is linked to the daily work of our home lives and work
              centers, we are satisfied with being able to help our clients to
              have a longer life easy, without worrying about doing usual
              complicated tasks, often not having the necessary knowledge and
              equipment
            </p>
          </div>
          <div className="second">
            <div className="button">Site Links</div>
            <ul>
              <li>
                <img src={ChevronRight} alt="Chevron Right" />
                <Link to="/">Home</Link>
              </li>
              <li>
                <img src={ChevronRight} alt="Chevron Right" />
                <Link to="#">Blog</Link>
              </li>
              <li>
                <img src={ChevronRight} alt="Chevron Right" />
                <Link to="#">Terms & Conditions</Link>
              </li>
              <li>
                <img src={ChevronRight} alt="Chevron Right" />
                <Link to="#">Privacy Policy</Link>
              </li>
              <li>
                <img src={ChevronRight} alt="Chevron Right" />
                <Link to="#">FAQs</Link>
              </li>
            </ul>
            <div className="button">Contact Us</div>
            <div className="social">
              <a
                href="https://www.linkedin.com/"
                target="_blank"
                rel="noopener noreferrer"
              >
                <img src={LogoLinkedin} alt="Linkedin" />
              </a>
              <a
                href="https://www.instagram.com/"
                target="_blank"
                rel="noopener noreferrer"
              >
                <img src={LogoInstagram} alt="Instagram" />
              </a>
              <a
                href="https://www.facebook.com/"
                target="_blank"
                rel="noopener noreferrer"
              >
                <img src={LogoFacebook} alt="Facebook" />
              </a>
            </div>
          </div>
          <div className="third">
            <div className="button">Popular Cities</div>
            <ul>
              <li>
                <img src={ChevronRight} alt="Chevron Right" />
                <span>Cutler Bay</span>
              </li>
              <li>
                <img src={ChevronRight} alt="Chevron Right" />
                <span>Daytona Beach</span>
              </li>
              <li>
                <img src={ChevronRight} alt="Chevron Right" />
                <span>Florida City</span>
              </li>
              <li>
                <img src={ChevronRight} alt="Chevron Right" />
                <span>Homestead</span>
              </li>
              <li>
                <img src={ChevronRight} alt="Chevron Right" />
                <span>Jacksonville</span>
              </li>
              <li>
                <img src={ChevronRight} alt="Chevron Right" />
                <span>Miami</span>
              </li>
            </ul>
            <p>For better services download the app now</p>
            <div className="app-stores">
              <a
                href="https://www.apple.com/app-store/"
                target="_blank"
                rel="noopener noreferrer"
              >
                <img src={AppStore} alt="App Store" />
              </a>
              <a
                href="https://play.google.com/store/"
                target="_blank"
                rel="noopener noreferrer"
              >
                <img src={PlayStore} alt="Play Store" />
              </a>
            </div>
          </div>
        </div>
        <p className="copy">Copyright 2022 | ProviTask. All Rights Reserved.</p>
      </div>
    </footer>
  );
};

export default Footer;
