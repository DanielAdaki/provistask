import React, { useState } from "react";

import ArrowRight from "../../images/arrow-right.png";
import ReviewCard from "./ReviewCard";

const CarouselReviews = ({ sortedData, wide }) => {
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
    <div className="carousel" style={{ marginTop: "-1rem" }}>
      <button
        className={`carousel-btn arrow left ${position === 0 ? "hidden" : ""}`}
        onClick={goBack}
      >
        <img src={ArrowRight} className="rotated" alt="Back" />
      </button>
      <div className="carousel-container">
        <div
          className={`inner-container ${wide && "wide"}`}
          style={{ paddingBottom: 0, paddingTop: "2rem" }}
        >
          {sortedData.length > 0 &&
            sortedData.map((group, index) => {
              return (
                <div
                  className={`group`}
                  style={{ transform: `translateX(-${100 * position}%)` }}
                  key={index}
                >
                  {group.map((review, index) => {
                    return (
                      <ReviewCard review={review} key={review.name + index} />
                    );
                  })}
                </div>
              );
            })}
        </div>
      </div>
      <button
        className={`carousel-btn arrow right  ${
          position === maxPosition ? "hidden" : ""
        }`}
        onClick={goNext}
      >
        <img src={ArrowRight} alt="Next" />
      </button>
    </div>
  );
};

export default CarouselReviews;
