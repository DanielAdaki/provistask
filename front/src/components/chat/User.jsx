import React from "react";

const User = ({ id, name, image_url, online, last_msg }) => {
  return (
    <div className="chat-user">
      <div className="container">
        <div className="avatar">
          <img srcSet={`${image_url} 2x`} alt="Avatar" />
          <span className="notification">1</span>
        </div>
        <div className="text">
          <div className="name">
            <strong>{name}</strong>
            <span>{last_msg.time}</span>
          </div>
          <p className="last-msg">{last_msg.text}</p>
        </div>
      </div>
    </div>
  );
};

export default User;
