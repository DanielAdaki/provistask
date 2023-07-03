import React, { useEffect, useState } from "react";

import { sortIntoPieces } from "../../helpers/utilities";

import CarouselComponent from "../reusable/CarouselComponent";

const APIEndpointServices = "api/services.json";

const Categories = () => {
  const [services, setServices] = useState([]);
  const [sortedServices, setSortedServices] = useState([]);

  const fetchResources = async () => {
    const servicesResponse = await fetch(APIEndpointServices, {
      headers: {
        "Content-Type": "application/json",
        Accept: "application/json",
      },
    });

    const servicesJSON = await servicesResponse.json();

    setServices(servicesJSON);
  };

  useEffect(() => {
    fetchResources();
  }, []);

  useEffect(() => {
    if (services.length > 0) {
      setSortedServices(sortIntoPieces(services, 3));
    }
  }, [services]);

  return (
    <div className="categories">
      <h2>ProviTask Categories</h2>

      <CarouselComponent sortedData={sortedServices}></CarouselComponent>
    </div>
  );
};

export default Categories;
