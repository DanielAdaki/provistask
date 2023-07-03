import React from "react";

import Quotes from "../../images/quotes.png";
import Stars from "./StarsGenerator";

const ReviewCard = ({ review }) => {
  const { image_url, name, occupation, review_text, rating, featured_phrase } =
    review;

  return (
    <div className={`review-card ${rating === 5 ? "active" : ""}`}>
      <img src={Quotes} className="quote" alt="Quote" />
      <div className="info">
        <img src={image_url} alt="Avatar" />
        <div className="text">
          <strong className="name">{name}</strong>
          <span className="occupation">{occupation}</span>
        </div>
      </div>
      <p> {review_text}</p>
      <span className="rating">
        <Stars refName={name} rating={rating} />
      </span>
      <strong className="phrase">{featured_phrase}</strong>
    </div>
  );
};

export default ReviewCard;
