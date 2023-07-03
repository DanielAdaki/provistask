import React, { useEffect, useState } from "react";

import Chevron from "../../images/chevron-right.png";
import ServiceCard from "./ServiceCard";

const PaginationServices = ({ sortedData = [], executeScroll }) => {
  const [position, setPosition] = useState(0);
  const [maxPosition, setMaxPosition] = useState(1);
  const [simpleArray, setSimpleArray] = useState([]);

  useEffect(() => {
    setMaxPosition(sortedData.length - 1);
    setSimpleArray([...Array(sortedData.length).keys()]);
  }, [sortedData]);

  const scrollTime = 0;

  const goNext = () => {
    executeScroll();

    if (position < maxPosition) {
      setTimeout(() => {
        setPosition(position + 1);
      }, scrollTime);
    }
  };
  const goBack = () => {
    executeScroll();

    if (position > 0) {
      setTimeout(() => {
        setPosition(position - 1);
      }, scrollTime);
    }
  };

  const goTo = (position) => {
    executeScroll();

    setTimeout(() => {
      setPosition(position);
    }, scrollTime);
  };

  return (
    <div className="pagination-component services">
      {sortedData.length > 0 && (
        <div className="container">
          {sortedData.map((group, index) => {
            return (
              <div
                className={`group`}
                style={{ transform: `translateX(-${100 * position}%)` }}
                key={index}
              >
                {group.map((service, index) => {
                  return <ServiceCard service={service} key={index} />;
                })}
              </div>
            );
          })}
        </div>
      )}

      <div className="controls">
        <button
          className={`previous ${position === 0 ? "disabled" : ""}`}
          disabled={position === 0 ? true : false}
          onClick={goBack}
        >
          <img src={Chevron} className="left" alt="Chevron" />
          <p>Previous</p>
        </button>
        <div className="numbers">
          {simpleArray.map((el, index) => {
            return (
              <span
                className={position === index ? "active" : ""}
                onClick={() => {
                  goTo(index);
                }}
                key={index + 1}
              >
                {index + 1}
              </span>
            );
          })}
        </div>
        <button
          className={`next ${position === maxPosition ? "disabled" : ""}`}
          disabled={position === maxPosition ? true : false}
          onClick={goNext}
        >
          <p>Next</p>
          <img src={Chevron} alt="Chevron" />
        </button>
      </div>
    </div>
  );
};

export default PaginationServices;
