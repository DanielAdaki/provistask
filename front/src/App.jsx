import "./sass/App.scss";

import HomeHeader from "./components/basic/HomeHeader";

import Hero from "./components/home/Hero";
import Welcome from "./components/home/Welcome";
import Categories from "./components/home/Categories";
import HowItWorks from "./components/home/HowItWorks";
import FeaturedProviders from "./components/home/FeaturedProviders";
import WhyChooseUs from "./components/home/WhyChooseUs";
import ServiceDeals from "./components/home/ServiceDeals";
import ProvidersInfo from "./components/home/ProvidersInfo";
import Reviews from "./components/home/Reviews";
import BecomeProvider from "./components/home/BecomeProvider";
import Community from "./components/home/Community";

import Footer from "./components/basic/Footer";
import { useEffect, useState } from "react";

const APIEndpointServices = "./api/services.json";
const APIEndpointLocations = "./api/locations.json";

function App() {
  const [locations, setLocations] = useState([]);
  const [services, setServices] = useState([]);

  const fetchResources = async () => {
    const [servicesResponse, locationsResponse] = await Promise.all(
      [fetch(APIEndpointServices), fetch(APIEndpointLocations)],
      {
        headers: {
          "Content-Type": "application/json",
          Accept: "application/json",
        },
      }
    );

    const servicesJSON = await servicesResponse.json();
    const locationsJSON = await locationsResponse.json();

    let servicesArray = [];
    let locationsArray = [];

    servicesJSON.forEach((el) => {
      servicesArray.push({ name: el.name, id: el.id });
    });

    for (let i = 0; i < locationsJSON.length; i++) {
      for (let j = 0; j < locationsJSON[i].cities.length; j++) {
        locationsArray.push({
          name: locationsJSON[i].cities[j].name,
          id: locationsJSON[i].cities[j].zip,
        });
      }
    }

    setServices(servicesArray);
    setLocations(locationsArray);
  };

  useEffect(() => {
    fetchResources();
  }, []);
  return (
    <div className="app">
      <HomeHeader />
      <Hero locations={locations} services={services} />
      <Welcome />
      <div className="wrapper">
        <Categories />
        <HowItWorks />
        <FeaturedProviders />
        <WhyChooseUs />
      </div>
      <ServiceDeals services={services} />
      <ProvidersInfo />
      <Reviews />
      <BecomeProvider />
      <Community />
      <Footer />
    </div>
  );
}

export default App;
