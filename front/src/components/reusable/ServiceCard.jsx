import React from "react";

import Stars from "./StarsGenerator";

const ServiceCard = ({ service }) => {
  let { image_url, name, description, price, on_site, rating, average_rating } =
    service;

  return (
    <div className="service-card">
      <img src={image_url} alt="Service" />
      <div className="text">
        <h3>{name}</h3>
        <p>{description}</p>
      </div>
      <div className="container">
        <div className="price">{`${price}$`}</div>
        <span className="on-site-estimated">{`On site estimate: (${on_site})`}</span>
        <div className="rating">
          <Stars refName={name} rating={rating ? rating : average_rating} />
        </div>
      </div>
    </div>
  );
};

export default ServiceCard;
