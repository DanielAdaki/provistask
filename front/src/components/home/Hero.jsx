import React, { useEffect, useState } from "react";
import { Link } from "react-router-dom";

import MagGlass from "../../images/mag-glass.png";
import AppStore from "../../images/app-store-badge.png";
import PlayStore from "../../images/google-play-badge.png";
import ChevronDown from "../../images/chevron-down.png";
import HeroDude from "../../images/hero-dude.png";
import ProgressiveImg from "../reusable/ProgressiveImg";

const HeroDropdown = ({ className, data, changePar }) => {
  const [dropdownData, setDropdownData] = useState([]);
  const [isOpen, setIsOpen] = useState(false);
  const [value, setValue] = useState("");

  const handleClick = () => {
    setIsOpen(!isOpen);
  };
  const handleBlur = () => {
    setTimeout(() => {
      setIsOpen(false);
    }, 100);
  };
  const changeValue = (newValue) => {
    console.log(newValue);
    setValue(newValue);
    setIsOpen(false);
  };

  useEffect(() => {
    if (data.length > 0) {
      setDropdownData(data);
      setValue(data[0]);
    }
  }, [data]);

  useEffect(() => {
    if (value) changePar(value.id);
    // eslint-disable-next-line
  }, [value]);

  return (
    <div className={`dropdown ${className} ${isOpen ? "active" : ""}`}>
      <button onClick={handleClick} onBlur={handleBlur}>
        <span>{value.name}</span>
        <img src={ChevronDown} alt="Chevron Down" />
      </button>

      <div className={`content ${isOpen ? "open" : ""}`}>
        {dropdownData &&
          dropdownData.map((el, index) => {
            return (
              <button
                key={el.name + index}
                onClick={() => {
                  changeValue(el);
                }}
              >
                {el.name}
              </button>
            );
          })}
      </div>
    </div>
  );
};

const Hero = ({ locations, services }) => {
  const [location, setLocation] = useState("");
  const [service, setService] = useState("");

  return (
    <div id="hero">
      <div className="text-content">
        <strong>Live Easier</strong>
        <p>
          All the experience from cleaning, plumbing, electrical, design and
          many more. You can also register as a service provider.
        </p>

        <div className="search">
          <div className="dropdowns">
            <HeroDropdown
              className="service"
              data={services}
              changePar={setService}
            ></HeroDropdown>
            <HeroDropdown
              className="zipcode"
              data={locations}
              changePar={setLocation}
            ></HeroDropdown>
          </div>
          <Link
            to={
              service && location
                ? `/task?service=${service}&location=${location}`
                : "/"
            }
            className="btn-search"
          >
            <img src={MagGlass} alt="MagGlass" />
          </Link>
        </div>

        <p>For better services download the app now</p>

        <div className="app-stores">
          <ProgressiveImg src={AppStore} alt="AppStore" height="3.5rem" />
          <ProgressiveImg src={PlayStore} alt="PlayStore" height="3.5rem" />
        </div>
      </div>

      <div className="decoration-content">
        <div className="rectangles"></div>
        <ProgressiveImg src={HeroDude} alt="Hero Dude" />
      </div>
    </div>
  );
};

export default Hero;
