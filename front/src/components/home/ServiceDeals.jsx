import React, { useEffect, useState } from "react";

import MagGlass from "../../images/mag-glass.png";
import Drill from "../../images/deal-drill.png";
import Tools from "../../images/deal-tools.png";
import BG from "../../images/deal-bg.jpg";
import { Link } from "react-router-dom";

const ServiceDeals = ({ services }) => {
  const [inputValue, setInputValue] = useState("");
  const [sortedServices, setSortedServices] = useState([]);
  const [serviceID, setServiceID] = useState(0);

  const handleChange = (e) => {
    setInputValue(e.target.value);

    if (serviceID !== 0) {
      setServiceID(0);
    }
  };

  const handleBlur = () => {
    setTimeout(() => {
      setSortedServices([]);
    }, 100);
  };
  const handleFocus = () => {
    sortByValue();
  };

  const sortByValue = () => {
    if (services.length > 0) {
      let sortedArray = services.filter((service) => {
        return service.name.toLowerCase().includes(inputValue.toLowerCase());
      });

      setSortedServices(sortedArray);
    }
  };

  const handleClick = (service) => {
    setInputValue(service.name);
    setServiceID(service.id);
  };

  useEffect(() => {
    sortByValue();

    // eslint-disable-next-line
  }, [inputValue]);

  return (
    <section className="service-deals">
      <div className="container">
        <img src={BG} alt="Background" />
        <div className="inner-container">
          <div className="text">
            <h2>Best Service Deals</h2>
            <div className="content">
              <p>
                Veniam, quis nostrud exercitation ullamco laboris nisi ut
                aliquip ex ea commodo consequat. Duis aute irure dolor in
                reprehenderit in voluptate velit esse cillum dolore eu fugiat
                nulla pariatur. Excepteur sint occaecat
              </p>
              <div className="input-container">
                <input
                  type="text"
                  value={inputValue}
                  onChange={handleChange}
                  placeholder="What service do you need?"
                  onBlur={handleBlur}
                  onFocus={handleFocus}
                />
                <Link
                  className={serviceID !== 0 ? "active" : ""}
                  to={
                    serviceID ? `/task?service=${serviceID}&location=${0}` : "/"
                  }
                >
                  <img src={MagGlass} alt="Search" />
                </Link>

                {sortedServices.length > 0 && (
                  <div className="options">
                    {sortedServices.map((service) => {
                      return (
                        <span
                          key={service.name + service.id}
                          className="service"
                          onClick={() => {
                            handleClick(service);
                          }}
                        >
                          {service.name}
                        </span>
                      );
                    })}
                  </div>
                )}
              </div>
            </div>
          </div>
          <div className="decoration">
            <img src={Drill} className="drill" alt="Drill" />
            <img src={Tools} className="tools" alt="Tools" />
          </div>
        </div>
      </div>
    </section>
  );
};

export default ServiceDeals;
