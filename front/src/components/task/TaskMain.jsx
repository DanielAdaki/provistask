import React, { useEffect, useState } from "react";

import { useLocation } from "react-router-dom";

import SimpleHeader from "../basic/SimpleHeader";
import Footer from "../basic/Footer";
import TaskHero from "./TaskHero";
import TaskProcess from "./TaskProcess";
import TaskProcessOne from "./TaskProcessOne";
import TaskProcessTwo from "./TaskProcessTwo";
import TaskProcessThree from "./TaskProcessThree";
import TaskProcessFour from "./TaskProcessFour";

import { sortIntoPieces } from "../../helpers/utilities";

const APIEndpointServices = "./api/services.json";
const APIEndpointLocations = "./api/locations.json";
const APIEndpointProfiles = "./api/profiles.json";
const APIEndpointVehicles = "./api/vehicles.json";

const TaskMain = () => {
  const [process, setProcess] = useState(1);
  const [step1, setStep1] = useState(1);
  const [step2, setStep2] = useState(0);
  const [step3, setStep3] = useState(0);
  const [serviceID, setServiceID] = useState(null);
  const [locationZIP, setLocationZIP] = useState(null);

  const [services, setServices] = useState("");
  const [locations, setLocations] = useState("");
  const [service, setService] = useState("");
  const [location, setLocation] = useState("");

  const [profiles, setProfiles] = useState([]);
  const [vehicles, setVehicles] = useState([]);

  const [sortedProfiles, setSortedProfiles] = useState([]);
  const [sortedProfilesPieces, setSortedProfilesPieces] = useState([]);

  const [address, setAddress] = useState("");
  const [durationOption, setDurationOption] = useState(0);
  const [transportationOption, setTransportationOption] = useState(0);
  const [taskDetail, setTaskDetail] = useState("");
  const [files, setFiles] = useState([]);

  const [mainDate, setMainDate] = useState(null);
  const [day, setDay] = useState(0);
  const [month, setMonth] = useState(0);
  const [year, setYear] = useState(0);
  const [dayOfWeek, setDayOfWeek] = useState(0);
  const [hour, setHour] = useState(0);
  const [sufix, setSufix] = useState("AM");

  const [selectedProviderProfile, setSelectedProviderProfile] = useState({});

  const [variableSetTwo, setVariableSetTwo] = useState({
    day,
    setDay,
    month,
    setMonth,
    year,
    setYear,
    dayOfWeek,
    setDayOfWeek,
    hour,
    setHour,
    sufix,
    setSufix,
  });

  const [variableSetOne, setVariableSetOne] = useState({
    address,
    setAddress,
    durationOption,
    setDurationOption,
    transportationOption,
    setTransportationOption,
    taskDetail,
    setTaskDetail,
    files,
    setFiles,
  });

  useEffect(() => {
    setVariableSetOne({
      address,
      setAddress,
      durationOption,
      setDurationOption,
      transportationOption,
      setTransportationOption,
      taskDetail,
      setTaskDetail,
      files,
      setFiles,
    });
  }, [address, durationOption, transportationOption, taskDetail, files]);

  useEffect(() => {
    setVariableSetTwo({
      day,
      setDay,
      month,
      setMonth,
      year,
      setYear,
      dayOfWeek,
      setDayOfWeek,
      hour,
      setHour,
      sufix,
      setSufix,
    });
  }, [day, month, year, dayOfWeek, hour, sufix]);

  const useQuery = () => {
    const { search } = useLocation();

    return React.useMemo(() => new URLSearchParams(search), [search]);
  };

  let query = useQuery();

  useEffect(() => {
    let s = query.get("service");
    let l = query.get("location");

    setServiceID(s);
    setLocationZIP(l);
    // eslint-disable-next-line
  }, []);

  const fetchResources = async () => {
    const [
      servicesResponse,
      locationsResponse,
      profilesResponse,
      vehiclesResponse,
    ] = await Promise.all(
      [
        fetch(APIEndpointServices),
        fetch(APIEndpointLocations),
        fetch(APIEndpointProfiles),
        fetch(APIEndpointVehicles),
      ],
      {
        headers: {
          "Content-Type": "application/json",
          Accept: "application/json",
        },
      }
    );

    const servicesJSON = await servicesResponse.json();
    const locationsJSON = await locationsResponse.json();
    const profilesJSON = await profilesResponse.json();
    const vehiclesJSON = await vehiclesResponse.json();

    setServices(servicesJSON);
    setLocations(locationsJSON);
    setProfiles(profilesJSON);
    setVehicles(vehiclesJSON);
  };

  useEffect(() => {
    fetchResources();
  }, []);

  useEffect(() => {
    if (services.length > 0) {
      const serviceObject = services.filter((el) => {
        return el.id === Number(serviceID);
      });

      setService(...serviceObject);
    }
    // eslint-disable-next-line
  }, [services]);

  useEffect(() => {
    if (locations.length > 0) {
      let locationObject = "";

      for (let i = 0; i < locations.length; i++) {
        for (let j = 0; j < locations[i].cities.length; j++) {
          if (Number(locations[i].cities[j].zip) === Number(locationZIP)) {
            locationObject = {
              city: locations[i].cities[j].name,
              state: locations[i].state,
            };
          }
        }
      }

      setLocation(locationObject);
    }
    // eslint-disable-next-line
  }, [locations]);

  useEffect(() => {
    if (profiles.length > 0) {
      setSortedProfiles(sortProfilesByService());
    }
    // eslint-disable-next-line
  }, [profiles]);

  useEffect(() => {
    setSortedProfilesPieces(sortIntoPieces(sortedProfiles, 4));
  }, [sortedProfiles]);

  const sortProfilesByService = () => {
    if (profiles.length > 0) {
      let sortedProByServ = [];

      for (let i = 0; i < profiles.length; i++) {
        for (let j = 0; j < profiles[i].services.length; j++) {
          if (profiles[i].services[j].id === Number(serviceID)) {
            sortedProByServ.push(profiles[i]);
          }
        }
      }

      // console.log(sortedProByServ);

      return sortedProByServ;
    }
  };

  const sortProfilesBySpecialization = (specID) => {
    if (sortedProfiles.length > 0) {
      console.log(sortedProfiles);

      if (specID !== 0) {
        let sortedProBySpec = [];

        for (let i = 0; i < sortedProfiles.length; i++) {
          let servArray = sortedProfiles[i].services;

          for (let j = 0; j < servArray.length; j++) {
            if (servArray[j].id === Number(serviceID)) {
              for (let k = 0; k < servArray[j].specialization.length; k++) {
                let specArray = servArray[j].specialization;

                if (specArray[k] === specID) {
                  sortedProBySpec.push(sortedProfiles[i]);

                  break;
                }
              }
            }
          }
        }

        // console.log(sortedProBySpec);

        setSortedProfilesPieces(sortIntoPieces(sortedProBySpec, 4));
      } else {
        // console.log(sortedProfiles);
        setSortedProfilesPieces(sortIntoPieces(sortedProfiles, 4));
      }
    }
  };

  const editProcess = (option) => {
    switch (option) {
      case 1:
        setProcess(2);
        setStep1(5);
        break;
      case 2:
        setProcess(1);
        setStep1(5);
        setAddress("");
        break;
      case 3:
        setProcess(1);
        setStep1(5);
        setDurationOption(0);
        break;
      case 4:
        setProcess(1);
        setStep1(5);
        setTransportationOption(0);
        break;

      default:
        break;
    }
  };

  return (
    <div className="task-main">
      <SimpleHeader noBG={true} white={true} />

      <TaskHero process={process} />

      <TaskProcess
        process={process}
        step1={step1}
        step2={step2}
        step3={step3}
      />

      {process === 1 ? (
        <TaskProcessOne
          service={service}
          location={location}
          setLocation={setLocation}
          locations={locations}
          step={step1}
          setProcess={setProcess}
          setStep={setStep1}
          variableSetOne={variableSetOne}
        />
      ) : process === 2 ? (
        <TaskProcessTwo
          setProcess={setProcess}
          setStep={setStep2}
          step={step2}
          variableSetTwo={variableSetTwo}
          setMainDate={setMainDate}
          mainDate={mainDate}
        />
      ) : process === 3 ? (
        <TaskProcessThree
          setProcess={setProcess}
          setStep={setStep3}
          step={step3}
          sortedProfiles={sortedProfilesPieces}
          service={service}
          vehicles={vehicles}
          sortProfilesBySpecialization={sortProfilesBySpecialization}
          setSelectedProviderProfile={setSelectedProviderProfile}
        />
      ) : (
        <TaskProcessFour
          variableSetOne={variableSetOne}
          variableSetTwo={variableSetTwo}
          selectedProviderProfile={selectedProviderProfile}
          service={service}
          location={location}
          editProcess={editProcess}
        />
      )}

      <Footer />
    </div>
  );
};

export default TaskMain;
