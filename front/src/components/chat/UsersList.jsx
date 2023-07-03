import React, { useEffect, useState } from "react";
import User from "./User";

import SearchIcon from "../../images/search.png";

const UsersList = ({ children, users = [] }) => {
  const [search, setSearch] = useState("");
  const [sortedUsers, setSortedUsers] = useState([]);

  const handleChange = (e) => {
    setSearch(e.target.value);
  };

  useEffect(() => {
    if (sortedUsers.length === 0) {
      if (users.length > 0) setSortedUsers(users);
    }
    // eslint-disable-next-line
  }, [users]);

  useEffect(() => {
    if (users.length > 0) {
      let sortedArray = users.filter((profile) => {
        return profile.name.toLowerCase().includes(search.toLowerCase());
      });

      setSortedUsers(sortedArray);
    }
    // eslint-disable-next-line
  }, [search]);

  return (
    <div className="users-list">
      {children}
      <div className="container">
        <div className="search">
          <input
            type="text"
            value={search}
            onChange={handleChange}
            placeholder="Search chat"
          />
          <img srcSet={`${SearchIcon} 2x`} alt="Search" />
        </div>
        <div className="users">
          {sortedUsers.length > 0 &&
            sortedUsers.map((user) => {
              return <User key={user.id} {...user} />;
            })}
        </div>
      </div>
    </div>
  );
};

export default UsersList;
