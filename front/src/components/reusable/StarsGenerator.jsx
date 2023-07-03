import React from "react";

import Star from "../../images/star.png";
import EmptyStar from "../../images/empty-star.png";

const Stars = ({ refName, rating }) => {
  const arrayOfStars = new Array(rating - 1);

  const maxStars = 5;

  for (let i = 0; i < maxStars; i++) {
    if (arrayOfStars.length < rating) {
      arrayOfStars[i] = 1;
    } else {
      arrayOfStars[i] = 0;
    }
  }

  return (
    <div className="stars-container">
      {arrayOfStars.map((point, index) => {
        if (point === 1) {
          return <img src={Star} alt="Star" key={refName + index} />;
        } else {
          return <img src={EmptyStar} alt="Empty Star" key={refName + index} />;
        }
      })}
    </div>
  );
};

export default Stars;
