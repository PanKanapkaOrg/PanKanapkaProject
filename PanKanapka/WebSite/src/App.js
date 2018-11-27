import React, { Component, Fragment } from "react";
import { BrowserRouter } from "react-router-dom";
import "./App.css";

import Navbar from "./components/layout/Navbar"
import Footer from "./components/layout/Footer"
import Routes from "./Routes";

class App extends Component {
  constructor(props) {
    super(props);

    this.state = {
      isAuthenticated: false,
      Role: null,
      AuthID: null,
      CateringFrimId: null,
      Name: null,
      Surname: null,
      CateringFrimName: null
    };
  }

  userHasAuthenticated = authenticated => {
    this.setState({ isAuthenticated: authenticated });
  }

  setAuthId = Id => {
    this.setState({ AuthID: Id });
  }

  setCateringFrimId = Id => {
    this.setState({ CateringFrimId: Id });
  }

  setName = n => {
    this.setState({ Name: n });
  }

  setSurname = sn => {
    this.setState({ Surname: sn });
  }

  setCateringFrimName = n => {
    this.setState({ CateringFrimName: n });
  }

  handleLogout = event => {
    this.userHasAuthenticated(false);
  }




  render() {
    const childProps = {
      isAuthenticated: this.state.isAuthenticated,
      userHasAuthenticated: this.userHasAuthenticated, 
      CateringFrimName:this.state.CateringFrimName,   
      setAuthId: this.setAuthId,
      setCateringFrimId: this.setCateringFrimId,
      setName: this.setName,
      setSurname: this.setSurname,
      setCateringFrimName: this.setCateringFrimName
    };


    return (
      <BrowserRouter>
        <div className="App">
          <Navbar  childProps={childProps}/>
          <Routes  childProps={childProps}/>
          <Footer  childProps={childProps} />
         
        </div>
      </BrowserRouter>
    );
  }
  
}

export default App;