import React from 'react'
import { Link } from 'react-router-dom'

const Navbar = (props) => {
  let right;
  console.log(props);

  if (props.isAuthenticated) {
    right = <li onClick={props.handleLogout}><a href="#"><i className="material-icons right">keyboard_tab</i>{props.managerName} {props.managerSurname}, wyloguj się</a></li>;
  } else {
    right = <li><Link to="/login"><i className="material-icons right">vpn_key</i>Zaloguj się</Link></li>;
  }

  return (
    <nav class="#303f9f indigo darken-2">
      <div className="nav-wrapper ">
      <a className="brand-logo"><Link to="/" >Serwis kateringowy</Link></a>
        <ul id="nav-mobile" className="left hide-on-med-and-down">
          
        </ul>
        <ul id="nav-mobile" className="right hide-on-med-and-down">
          <li><Link to="/firm">Firma<i className="material-icons right">info</i></Link></li>
          <li><Link to="/plans">Plany<i className="material-icons right">timeline</i></Link></li>
        
          {right}
        </ul>
      </div>
    </nav>
  );

}

export default Navbar
