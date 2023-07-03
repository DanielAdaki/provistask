import React, { useEffect, useState } from "react";

import { sortIntoPieces } from "../../helpers/utilities";

import CarouselProviders from "../reusable/CarouselProviders";

const APIEndpointProviders = "./api/featured.json";

const FeaturedProviders = () => {
  const [profiles, setProfiles] = useState({});
  const [sortedData, setSortedData] = useState({});

  const fetchResources = async () => {
    const profilesResponse = await fetch(APIEndpointProviders, {
      headers: {
        "Content-Type": "application/json",
        Accept: "application/json",
      },
    });

    const profilesJSON = await profilesResponse.json();

    setProfiles(profilesJSON);
  };

  useEffect(() => {
    fetchResources();
  }, []);

  //Detect screen resize
  const [windowWidth, setWindowWidth] = useState(null);

  const isWindow = typeof window !== "undefined";

  const getWidth = () => (isWindow ? window.visualViewport.width : windowWidth);

  const resize = () => setWindowWidth(getWidth());

  useEffect(() => {
    if (isWindow) {
      setWindowWidth(getWidth());

      window.addEventListener("resize", resize);

      return () => window.removeEventListener("resize", resize);
    }
    // eslint-disable-next-line
  }, [isWindow]);

  const getGrupoSize = () => {
    let w = getWidth();

    // console.log(w);

    if (w > 800) {
      return 3;
    } else if (w > 560) {
      return 2;
    } else {
      return 2;
    }
  };

  const [sizeOfGroups, setSizeOfGroups] = useState(getGrupoSize());

  useEffect(() => {
    setSizeOfGroups(getGrupoSize());
    // eslint-disable-next-line
  }, [windowWidth]);

  useEffect(() => {
    if (profiles.length > 0) {
      let array = sortIntoPieces(profiles, sizeOfGroups);
      let slicedArray = array.slice(0, 2);

      setSortedData(slicedArray);
    }
  }, [profiles, sizeOfGroups]);

  return (
    <section className="featured-providers">
      <h2>Featured Providers</h2>
      <p>
        Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
        tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim
        veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea
        commodo consequat.
      </p>

      <div className="providers">
        <CarouselProviders
          sortedData={sortedData}
          wide={true}
          className={"carausel-providers"}
        />
      </div>
    </section>
  );
};

export default FeaturedProviders;
