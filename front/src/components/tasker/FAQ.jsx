import React from "react";

import Search from "../../images/search.png";
import FAQDropdown from "./FAQDropdown";

const FAQ = () => {
  return (
    <div className="faq-section">
      <div className="input-bar">
        <p>Your questions, answered</p>
        <img src={Search} alt="Search" />
      </div>

      <div className="content">
        <FAQDropdown
          question={"What’s required to become a Tasker?"}
          answer={
            "Lorem ipsum dolor sit amet consectetur adipisicing elit. Illum, ratione tempora mollitia dignissimos excepturi sapiente harum ullam accusantium omnis reprehenderit animi inventore praesentium quasi quia temporibus repellat beatae consectetur exercitationem."
          }
        />
        <FAQDropdown
          question={"Do I need experience to task?"}
          answer={
            "Lorem ipsum dolor sit amet consectetur adipisicing elit. Illum, ratione tempora mollitia dignissimos excepturi sapiente harum ullam accusantium omnis reprehenderit animi inventore praesentium quasi quia temporibus repellat beatae consectetur exercitationem."
          }
        />
        <FAQDropdown
          question={"How do I get jobs?"}
          answer={
            "Lorem ipsum dolor sit amet consectetur adipisicing elit. Illum, ratione tempora mollitia dignissimos excepturi sapiente harum ullam accusantium omnis reprehenderit animi inventore praesentium quasi quia temporibus repellat beatae consectetur exercitationem."
          }
        />
        <FAQDropdown
          question={"How do I get paid?"}
          answer={
            "Lorem ipsum dolor sit amet consectetur adipisicing elit. Illum, ratione tempora mollitia dignissimos excepturi sapiente harum ullam accusantium omnis reprehenderit animi inventore praesentium quasi quia temporibus repellat beatae consectetur exercitationem."
          }
        />
        <FAQDropdown
          question={"Where does ProviTask operate?"}
          answer={
            "Lorem ipsum dolor sit amet consectetur adipisicing elit. Illum, ratione tempora mollitia dignissimos excepturi sapiente harum ullam accusantium omnis reprehenderit animi inventore praesentium quasi quia temporibus repellat beatae consectetur exercitationem."
          }
        />
        <FAQDropdown
          question={"What categories can I task in on ProviTask?"}
          answer={
            "Lorem ipsum dolor sit amet consectetur adipisicing elit. Illum, ratione tempora mollitia dignissimos excepturi sapiente harum ullam accusantium omnis reprehenderit animi inventore praesentium quasi quia temporibus repellat beatae consectetur exercitationem."
          }
        />
        <FAQDropdown
          question={
            "How long does it take for my registration to be processed?"
          }
          answer={
            "Lorem ipsum dolor sit amet consectetur adipisicing elit. Illum, ratione tempora mollitia dignissimos excepturi sapiente harum ullam accusantium omnis reprehenderit animi inventore praesentium quasi quia temporibus repellat beatae consectetur exercitationem."
          }
        />
      </div>
    </div>
  );
};

export default FAQ;
