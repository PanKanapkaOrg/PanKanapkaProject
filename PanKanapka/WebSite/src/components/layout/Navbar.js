import React from 'react'
import { Link } from 'react-router-dom'

const Navbar = (props) => {
  let right;
  let left;

  if (props.isAuthenticated) {
    right = <li onClick={props.handleLogout}>Wyloguj się</li>;
  } else {
    right = <li><Link to="/login">Zaloguj się</Link></li>;
  }

  return (
    <nav>
      <div className="nav-wrapper">
        <ul id="nav-mobile" className="left hide-on-med-and-down">
          <li><Link to="/" >Pan Kanapka</Link></li>
          <li><Link to="/firm">Firma</Link></li>
          <li><Link to="/plans">Plany</Link></li>
        </ul>
        <ul id="nav-mobile" className="right hide-on-med-and-down">
          {right}
        </ul>
      </div>
    </nav>
  );

}

export default Navbar
