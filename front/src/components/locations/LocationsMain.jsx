import React, { useEffect, useState } from "react";

import Footer from "../basic/Footer";
import SimpleHeader from "../basic/SimpleHeader";

const APIEndpointLocations = "api/locations.json";

const LocationsMain = () => {
  const [locations, setLocations] = useState([]);

  const fetchResources = async () => {
    const locationsResponse = await fetch(APIEndpointLocations, {
      headers: {
        "Content-Type": "application/json",
        Accept: "application/json",
      },
    });

    const servicesJSON = await locationsResponse.json();

    setLocations(servicesJSON);
  };

  useEffect(() => {
    fetchResources();
  }, []);

  return (
    <div className="location-main">
      <SimpleHeader noBG={true} />

      <div className="inner-container">
        <h1>Cities where we work - ProviTask</h1>
        <div className="container">
          {locations.length > 0 &&
            locations.map((state) => {
              return (
                <div className="group" key={state.state}>
                  <strong>{state.state}</strong>
                  {state.cities.map((city) => {
                    return <p key={city.name}>{city.name}</p>;
                  })}
                </div>
              );
            })}
        </div>
      </div>

      <div className="footer">
        <Footer />
      </div>
    </div>
  );
};

export default LocationsMain;
