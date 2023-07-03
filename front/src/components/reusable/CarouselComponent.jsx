import React, { useState } from "react";

import ServiceCard from "./ServiceCard";
import ChevronRight from "../../images/chevron-right.png";

const CarouselComponent = ({ sortedData }) => {
  const [position, setPosition] = useState(0);

  const maxPosition = 1;

  const goNext = () => {
    if (position < maxPosition) {
      setPosition(position + 1);
    }
  };
  const goBack = () => {
    if (position > 0) {
      setPosition(position - 1);
    }
  };

  return (
    <div className="carousel">
      <button
        className={`carousel-btn left ${position === 0 ? "hidden" : ""}`}
        onClick={goBack}
      >
        <img src={ChevronRight} className="rotated" alt="Back" />
      </button>
      <div className="carousel-container">
        <div className="inner-container">
          {sortedData.map((group, index) => {
            return (
              <div
                className={`group`}
                style={{ transform: `translateX(-${100 * position}%)` }}
                key={index}
              >
                {group.map((service, index) => {
                  return (
                    <ServiceCard
                      className="service-card"
                      service={service}
                      key={service.name + index}
                    />
                  );
                })}
              </div>
            );
          })}
        </div>
      </div>
      <button
        className={`carousel-btn right  ${
          position === maxPosition ? "hidden" : ""
        }`}
        onClick={goNext}
      >
        <img src={ChevronRight} alt="Next" />
      </button>
    </div>
  );
};

export default CarouselComponent;
