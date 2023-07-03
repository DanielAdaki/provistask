import React from "react";

import Stars from "./StarsGenerator";

const FeaturedProvidersCard = ({ f_provider }) => {
  const { image_url, name, description, rating } = f_provider;

  return (
    <div className="featured-provider-card">
      <img src={image_url} alt="Avatar" />
      <div className="text">
        <strong>{name}</strong>
        <p>{description}</p>
        <span>
          <Stars refName={name} rating={rating} />
        </span>
      </div>
    </div>
  );
};

export default FeaturedProvidersCard;
