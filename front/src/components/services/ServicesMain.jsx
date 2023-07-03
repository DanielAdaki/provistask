import React, { useEffect, useRef, useState } from "react";

import SimpleHeader from "../basic/SimpleHeader";
import ServicesHero from "./ServicesHero";
import Footer from "../basic/Footer";
import PaginationServices from "../reusable/PaginationServices";

import { sortIntoPieces } from "../../helpers/utilities";

const APIEndpointServices = "api/services.json";

const ServicesMain = () => {
  const [services, setServices] = useState([]);
  const [sortedServices, setSortedServices] = useState([]);

  const componentRef = useRef(null);

  const executeScroll = () => {
    componentRef.current.scrollIntoView({ behavior: "auto", block: "start" });
  };

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
      setSortedServices(sortIntoPieces(services, 9));
    }
  }, [services]);

  return (
    <div className="services-main">
      <SimpleHeader noBG={true} />
      <div className="inner-container">
        <ServicesHero />
        <h2 ref={componentRef}>Hire a trusted Tasker quickly.</h2>
        <PaginationServices
          sortedData={sortedServices}
          executeScroll={executeScroll}
        />
      </div>
      <Footer />
    </div>
  );
};

export default ServicesMain;
