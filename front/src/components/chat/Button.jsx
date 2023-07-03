import React from "react";

const Button = ({ onClick = null, children = null }) => {
  return (
    <button onClick={onClick} className="firebase-btn">
      {children}
    </button>
  );
};

export default Button;
