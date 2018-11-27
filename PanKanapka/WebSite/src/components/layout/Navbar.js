import React, { Component} from 'react'
import { Link } from 'react-router-dom'


//const Navbar = ( childProps) => {
//  const { isAuthenticated } = childProps;

export default class Navbar extends Component {
    constructor(props){
        super(props);
    }

  render() {
    if (this.props.isAuthenticated) 
    return(
    <nav>
          <div className="nav-wrapper">
            <a href="#" className="brand-logo"><Link to="/">Pan Kanapka</Link></a>
            {console.log(this.props.isAuthenticated)}
            <ul id="nav-mobile" className="right hide-on-med-and-down">
           
                       
              <li onClick={this.handleLogout}>Wyloguj się</li>
              
            </ul>
          </div>
        </nav>
    );
  return(
    <nav>
          <div className="nav-wrapper">
            <a href="#" className="brand-logo"><Link to="/">Pan Kanapka</Link></a>
            {console.log(this.props.isAuthenticated)}
            <ul id="nav-mobile" className="right hide-on-med-and-down">
                
                  
                 
                <li><Link to="/login">Zaloguj się</Link></li>

              
            </ul>
          </div>
        </nav>
    );
  }
}


//export default Navbar
