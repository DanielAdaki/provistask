import React, { useState } from "react";

const FAQDropdown = ({ question, answer }) => {
  const [isOpen, setIsOpen] = useState(false);

  const handleClick = () => {
    setIsOpen(!isOpen);
  };

  return (
    <div className="faq-dropdown">
      <button onClick={handleClick} className={isOpen ? "active" : ""}>
        {question}
      </button>
      <div className={`answer ${isOpen ? "open" : ""}`}>
        <p>{answer}</p>
      </div>
    </div>
  );
};

export default FAQDropdown;
