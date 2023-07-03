import React, { useEffect, useRef, useState } from "react";

import PaginationComponent from "../reusable/PaginationComponent";

import Shield from "../../images/shield.png";

const TaskProcessThree = ({
  sortedProfiles,
  service,
  vehicles,
  sortProfilesBySpecialization,
  setProcess,
  setSelectedProviderProfile,
  setStep,
}) => {
  const [priceOption, setPriceOption] = useState(0);
  const [filterOption, setFilterOption] = useState(0);
  const [filterSectionIsOpen, setFilterSectionIsOpen] = useState(false);

  const componentRef = useRef(null);

  const executeScroll = () => {
    componentRef.current.scrollIntoView({ behavior: "smooth", block: "start" });
  };
  const scrollTime = 300;

  const changeFilter = (id) => {
    if (id === filterOption) {
      executeScroll();

      setFilterOption(0);
    } else {
      setFilterOption(id);
    }
  };

  const viewMoreFilters = () => {
    if (!filterSectionIsOpen) {
      setFilterSectionIsOpen(!filterSectionIsOpen);
    }

    if (!!filterSectionIsOpen) {
      executeScroll();

      setTimeout(() => {
        setFilterSectionIsOpen(!filterSectionIsOpen);

        if (filterOption > 3) {
          setFilterOption(0);
        }
      }, scrollTime);
    }
  };

  const nextProcess = (profile) => {
    window.scrollTo({ top: 0, behavior: "smooth" });

    setTimeout(() => {
      setSelectedProviderProfile(profile);
      setProcess(4);
      setStep(1);
    }, 600);
  };

  useEffect(() => {
    sortProfilesBySpecialization(filterOption);

    // eslint-disable-next-line
  }, [filterOption]);

  const changePriceOption = (option) => {
    setPriceOption(option);
  };

  // if (service) {
  //   console.log(service);
  // }

  return (
    <div className="task-process-three">
      <div className="providers-section" ref={componentRef}>
        <PaginationComponent
          executeScroll={executeScroll}
          screen="task"
          vehiclesData={vehicles}
          service={service}
          sortedData={sortedProfiles}
          nextProcess={nextProcess}
        />
      </div>
      <div className="filters-section">
        <h3>Price</h3>
        <div className="selection">
          <button
            className={`option ${priceOption === 0 ? "selected" : ""}`}
            onClick={() => {
              changePriceOption(0);
            }}
          >
            Per hour
          </button>
          <button
            className={`option ${priceOption === 1 ? "selected" : ""}`}
            onClick={() => {
              changePriceOption(1);
            }}
          >
            By project/flat rate
          </button>
          <button
            className={`option ${priceOption === 2 ? "selected" : ""}`}
            onClick={() => {
              changePriceOption(2);
            }}
          >
            Free Trading
          </button>
        </div>

        <hr className="separator" />

        <h3>Task</h3>
        <h4 className="selected-service">{service.name}</h4>
        <p className="reminder">
          To make your search easier, you can give us more specific information
          about your task.
        </p>
        <div className={`container ${filterSectionIsOpen ? "open" : ""}`}>
          {service &&
            service.specialization.map((spec, index) => {
              return (
                <button
                  className={`filter-card ${
                    filterOption === spec.id ? "selected" : ""
                  }`}
                  key={spec.name + index}
                  onClick={() => {
                    changeFilter(spec.id);
                  }}
                >
                  <img
                    src={
                      filterOption === spec.id
                        ? spec.image_url_selected
                        : spec.image_url
                    }
                    alt="Icon"
                  />
                  <p>{spec.name}</p>
                </button>
              );
            })}
        </div>
        {service && service.specialization.length > 4 && (
          <button className="more" onClick={viewMoreFilters}>
            {filterSectionIsOpen ? "Less" : "More"}
          </button>
        )}

        <div className="safety-reminder">
          <img src={Shield} alt="Shield" />
          <p>
            Keep your mind at ease at all times. All Providers are subjected to
            identification and criminal background checks.
          </p>
        </div>
      </div>
    </div>
  );
};

export default TaskProcessThree;
