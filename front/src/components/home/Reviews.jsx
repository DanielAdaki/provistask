import React, { useEffect, useState } from "react";

import { sortIntoPieces } from "../../helpers/utilities";

import CarouselReviews from "../reusable/CarouselReviews";

const APIEndpointReviews = "api/reviews.json";

const Reviews = () => {
  const [reviews, setReviews] = useState({});
  const [sortedData, setSortedData] = useState({});

  const fetchResources = async () => {
    const reviewsResponse = await fetch(APIEndpointReviews, {
      headers: {
        "Content-Type": "application/json",
        Accept: "application/json",
      },
    });

    const reviewsJSON = await reviewsResponse.json();

    setReviews(reviewsJSON);
  };

  useEffect(() => {
    fetchResources();
  }, []);

  useEffect(() => {
    if (reviews.length > 0) {
      let array = sortIntoPieces(reviews, 3);
      let slicedArray = array.slice(0, 2);

      setSortedData(slicedArray);
    }
  }, [reviews]);

  return (
    <section className="reviews">
      <h2>What peolpe are saying</h2>
      <div className="reviews-carousel">
        <CarouselReviews sortedData={sortedData} wide={true} />
      </div>
    </section>
  );
};

export default Reviews;
